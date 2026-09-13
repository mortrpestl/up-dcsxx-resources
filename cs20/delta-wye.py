from fractions import Fraction
from decimal import Decimal


def delta_wye(a,b,c):
    a,b,c = (Fraction(x) for x in [a,b,c])
    _sum = sum([a,b,c])
    ab = a*b / _sum 
    bc = b*c / _sum
    ac = a*c / _sum 
    
    print(
        f"a={a} "
        f"b={b} "
        f"ab={ab}\n"
        
        f"a={a} "
        f"c={c} "
        f"ac={ac}\n"

        f"b={b} "
        f"c={c} "
        f"bc={bc}\n"
    )
    
delta_wye("8/15","2/15","6/5")
    
def parallel(a,b):
    a,b = map(Fraction, (a,b))
    print(1/(1/a + 1/b))
    return 1/(1/a + 1/b)
    
parallel("9600/143", "24000/143")

parallel("5200/21", "2600/21")

    
def series(a,b):
    a,b = map(Fraction, (a,b))
    print(a+b)
    return a+b
    
# print( float(series(parallel("45100/351","112700/702"), 2500/26)) )

# print (float(series(2400/35, 5200/63) ))