//! The letters Babbage computes with. A value on a sheet is a rational
//! function of the letters the sheet starts with (a, b, c, a′, b′, c′ on
//! BAB/L/001), held exactly: a numerator and a denominator, each a polynomial
//! with fractional coefficients. Two values are the same when they are equal
//! as rational functions, which is decided exactly by cross-multiplying; no
//! value is ever evaluated at numbers to be compared.

use crate::rat::Rat;
use std::collections::BTreeMap;
use std::fmt;

/// A product of letters, each to a power: `b′a` is {a: 1, b′: 1}.
pub type Monomial = BTreeMap<String, u32>;

#[derive(Clone, PartialEq, Eq, Default)]
pub struct Poly(BTreeMap<Monomial, Rat>);

impl Poly {
    pub fn zero() -> Poly {
        Poly::default()
    }
    pub fn constant(r: Rat) -> Poly {
        let mut m = BTreeMap::new();
        if !r.is_zero() {
            m.insert(Monomial::new(), r);
        }
        Poly(m)
    }
    pub fn letter(name: &str) -> Poly {
        let mut mono = Monomial::new();
        mono.insert(name.to_string(), 1);
        let mut m = BTreeMap::new();
        m.insert(mono, Rat::ONE);
        Poly(m)
    }
    pub fn is_zero(&self) -> bool {
        self.0.is_empty()
    }
    /// The constant this polynomial is, if it has no letters.
    pub fn as_constant(&self) -> Option<Rat> {
        match self.0.len() {
            0 => Some(Rat::ZERO),
            1 => self.0.get(&Monomial::new()).copied(),
            _ => None,
        }
    }
    pub fn add(&self, o: &Poly) -> Poly {
        let mut m = self.0.clone();
        for (k, v) in &o.0 {
            let e = m.entry(k.clone()).or_insert(Rat::ZERO);
            *e = *e + *v;
            if e.is_zero() {
                m.remove(k);
            }
        }
        Poly(m)
    }
    pub fn neg(&self) -> Poly {
        Poly(self.0.iter().map(|(k, v)| (k.clone(), -*v)).collect())
    }
    pub fn sub(&self, o: &Poly) -> Poly {
        self.add(&o.neg())
    }
    pub fn mul(&self, o: &Poly) -> Poly {
        let mut out = Poly::zero();
        for (k1, v1) in &self.0 {
            for (k2, v2) in &o.0 {
                let mut k = k1.clone();
                for (name, p) in k2 {
                    *k.entry(name.clone()).or_insert(0) += p;
                }
                let mut m = BTreeMap::new();
                m.insert(k, *v1 * *v2);
                out = out.add(&Poly(m));
            }
        }
        out
    }
    pub fn eval(&self, at: &BTreeMap<String, Rat>) -> Option<Rat> {
        let mut total = Rat::ZERO;
        for (mono, c) in &self.0 {
            let mut t = *c;
            for (name, p) in mono {
                let v = *at.get(name)?;
                for _ in 0..*p {
                    t = t.try_mul(v)?;
                }
            }
            total = total.try_add(t)?;
        }
        Some(total)
    }
    fn terms(&self) -> usize {
        self.0.len()
    }
}

/// Letters are printed in the order the sheet introduces them, which is the
/// order of their names here: a, a′, b, b′, c, c′.
fn letter_key(name: &str) -> (String, usize) {
    (name.trim_end_matches('\'').to_string(), name.len())
}

impl fmt::Display for Poly {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        if self.0.is_empty() {
            return write!(f, "0");
        }
        let mut first = true;
        for (mono, c) in &self.0 {
            let neg = *c < Rat::ZERO;
            let mag = if neg { -*c } else { *c };
            if first {
                if neg {
                    write!(f, "-")?;
                }
            } else {
                write!(f, " {} ", if neg { "-" } else { "+" })?;
            }
            first = false;
            let mut letters: Vec<(&String, &u32)> = mono.iter().collect();
            letters.sort_by_key(|(n, _)| letter_key(n));
            if letters.is_empty() || mag != Rat::ONE {
                write!(f, "{mag}")?;
            }
            for (name, p) in letters {
                write!(f, "{}", name.replace('\'', "′"))?;
                if *p > 1 {
                    write!(f, "^{p}")?;
                }
            }
        }
        Ok(())
    }
}

/// A value: numerator over denominator.
#[derive(Clone)]
pub struct Value {
    pub num: Poly,
    pub den: Poly,
}

impl Value {
    pub fn constant(r: Rat) -> Value {
        Value {
            num: Poly::constant(r),
            den: Poly::constant(Rat::ONE),
        }
    }
    pub fn zero() -> Value {
        Value::constant(Rat::ZERO)
    }
    pub fn letter(name: &str) -> Value {
        Value {
            num: Poly::letter(name),
            den: Poly::constant(Rat::ONE),
        }
    }
    pub fn is_zero(&self) -> bool {
        self.num.is_zero()
    }
    pub fn same(&self, o: &Value) -> bool {
        self.num.mul(&o.den) == o.num.mul(&self.den)
    }
    pub fn add(&self, o: &Value) -> Value {
        Value {
            num: self.num.mul(&o.den).add(&o.num.mul(&self.den)),
            den: self.den.mul(&o.den),
        }
        .tidy()
    }
    pub fn sub(&self, o: &Value) -> Value {
        self.add(&o.neg())
    }
    pub fn neg(&self) -> Value {
        Value {
            num: self.num.neg(),
            den: self.den.clone(),
        }
    }
    pub fn mul(&self, o: &Value) -> Value {
        Value {
            num: self.num.mul(&o.num),
            den: self.den.mul(&o.den),
        }
        .tidy()
    }
    /// None when the divisor is identically zero.
    pub fn div(&self, o: &Value) -> Option<Value> {
        if o.is_zero() {
            return None;
        }
        Some(
            Value {
                num: self.num.mul(&o.den),
                den: self.den.mul(&o.num),
            }
            .tidy(),
        )
    }
    /// Only the cheap simplifications: a constant denominator is divided
    /// into the numerator, and a zero numerator has denominator 1. Common
    /// factors are left, which is harmless, since values are compared by
    /// cross-multiplying.
    fn tidy(self) -> Value {
        if self.num.is_zero() {
            return Value::zero();
        }
        if let Some(d) = self.den.as_constant() {
            return Value {
                num: self.num.mul(&Poly::constant(Rat::ONE / d)),
                den: Poly::constant(Rat::ONE),
            };
        }
        self
    }
    pub fn eval(&self, at: &BTreeMap<String, Rat>) -> Option<Rat> {
        let d = self.den.eval(at)?;
        if d.is_zero() {
            return None;
        }
        self.num.eval(at)?.try_div(d)
    }
}

impl fmt::Display for Value {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self.den.as_constant() {
            Some(d) if d == Rat::ONE => write!(f, "{}", self.num),
            _ => {
                let wrap = |p: &Poly| {
                    if p.terms() > 1 {
                        format!("({p})")
                    } else {
                        format!("{p}")
                    }
                };
                write!(f, "{}/{}", wrap(&self.num), wrap(&self.den))
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn cramer() {
        let l = Value::letter;
        // (bc′ − b′c)/(b′a − ba′) written two ways
        let x = l("b")
            .mul(&l("c'"))
            .sub(&l("b'").mul(&l("c")))
            .div(&l("b'").mul(&l("a")).sub(&l("b").mul(&l("a'"))))
            .unwrap();
        let x2 = l("b'")
            .mul(&l("c"))
            .sub(&l("b").mul(&l("c'")))
            .div(&l("b").mul(&l("a'")).sub(&l("a").mul(&l("b'"))))
            .unwrap();
        assert!(x.same(&x2));
        assert!(!x.same(&l("a")));
    }
}
