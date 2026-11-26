# BAB/L/010 as transcribed: row -> (Car1, Car2, Car3, {col: value}); "-0" is a cleared carriage.
sheet = {
1:("976",None,None,{1:"0",7:"976",8:"976"}),
2:("940","964",None,{2:"0",8:"940"}),
3:("-0","-0","964",{9:"964"}),
4:("986",None,"950",{3:"0",9:"950"}),
5:("-0","986","-0",{10:"986"}),
6:("999","985",None,{4:"0",10:"985"}),
7:("-0","-0","999",{11:"999"}),
8:(None,None,"999",{5:"0",11:"999"}),
9:("024",None,None,{7:"0",1:"024",2:"024"}),
10:("084","060",None,{8:"0",2:"084"}),
11:("-0","-0","060",{3:"060"}),
12:("050",None,"110",{9:"0",3:"110"}),
13:("-0","050","-0",{4:"050"}),
14:("015","065",None,{10:"0",4:"065"}),
15:("-0","-0","015",{5:"015"}),
16:(None,None,"016",{11:"0",5:"016"}),
17:("976",None,None,{1:"0",7:"976",8:"976"}),
18:("892","916",None,{2:"0",8:"892"}),
19:("-0","-0","916",{9:"916"}),
20:("890",None,"806",{3:"0",9:"806"}),
21:("-0","890","-0",{10:"890"}),
22:("935","825",None,{4:"0",10:"825"}),
23:("-0","-0","935",{11:"935"}),
24:(None,None,"919",{5:"0",11:"919"}),
25:("024",None,None,{7:"0",1:"024",2:"024"}),
26:("132","108",None,{8:"0",2:"132"}),
27:("-0","-0","108",{3:"108"}),
28:("194",None,"302",{9:"0",3:"320"}),
29:("-0","194","-0",{4:"194"}),
30:("175","469",None,{10:"0",4:"469"}),
31:("-0","-0","175",{5:"175"}),
32:(None,None,"256",{11:"0",5:"256"}),
}
M=1000
st={1:24,2:36,3:14,4:1,5:0}
car=[0,0,0]
row=0; agree=0; dis=[]
def chk(r,what,want,got):
    global agree
    if got is None: return
    g = 0 if got=="-0" else int(got)
    if g%M==want%M: agree+=1
    else: dis.append((r,what,got,want%M))
for block in range(4):
    comp = block%2==0          # odd n: complements written into v7..v11
    src = [1,2,3,4,5] if comp else [7,8,9,10,11]
    dst = [7,8,9,10,11] if comp else [1,2,3,4,5]
    def neg(x): return (-x)%M if comp else x%M   # what reading a column contributes
    base=block*8
    # r1: read src[0]
    x=st.pop(src[0]); c1=(M-x)%M if comp else (M-x)%M
    c1=neg(x) if comp else (M-x)%M  # positive half: column holds complement, its complement is the number
    c1 = (M-x)%M
    car=[c1,0,0]; st[dst[0]]=c1; st[dst[1]]=c1
    r=base+1; s=sheet[r]; chk(r,"Car1",car[0],s[0]); chk(r,f"v{src[0]}",0,s[3].get(src[0])); chk(r,f"v{dst[0]}",st[dst[0]],s[3].get(dst[0])); chk(r,f"v{dst[1]}",st[dst[1]],s[3].get(dst[1]))
    acc_col=[dst[1],dst[2],dst[3],dst[4]]
    carry=[None]
    # generic: for k in 1..4: read src[k]; Car_a = Car_a - x  (accumulator), Car_b = C(x); then move
    acc=0  # index of accumulating carriage
    accs=[0,2,1,2]   # Car1 accumulates for Δ³; Car3 for Δ²; Car2 for Δ; Car3 for T
    holds=[1,0,0,None]  # where C(x) goes: Car2, Car1, Car1, -
    moves=[(1,2),(0,1),(0,2)]
    for k in range(1,5):
        r=base+2*k; s=sheet[r]
        x=st.pop(src[k])
        a=accs[k-1]; car[a]=(car[a]-x)%M
        if holds[k-1] is not None: car[holds[k-1]]=(M-x)%M if True else 0
        st[acc_col[k-1]]=car[a]
        chk(r,"Car%d"%(a+1),car[a],s[a]); 
        if holds[k-1] is not None: chk(r,"Car%d"%(holds[k-1]+1),car[holds[k-1]],s[holds[k-1]])
        chk(r,f"v{src[k]}",0,s[3].get(src[k])); chk(r,f"v{acc_col[k-1]}",st[acc_col[k-1]],s[3].get(acc_col[k-1]))
        if k<4:
            r=base+2*k+1; s=sheet[r]
            f,t=moves[k-1]; v=car[f]; car=[0,0,0]; car[t]=v; st[acc_col[k]]=v
            for i in range(3):
                if i!=t: chk(r,"Car%d"%(i+1),0,s[i])
            chk(r,"Car%d"%(t+1),v,s[t]); chk(r,f"v{acc_col[k]}",v,s[3].get(acc_col[k]))
    print("block",block+1,"store",{k:st[k] for k in sorted(st)})
print("agree",agree,"disagree",len(dis))
for d in dis: print(d)
