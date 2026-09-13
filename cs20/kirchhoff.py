import sympy as sp
from sympy import Matrix

raw = \
"""1	0	0	0	0	-1	0	-1	0	0	0	0	0
0	1	0	1	1	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	1	-1	0	0	1	0
0	0	0	0	0	0	0	0	0	-1	1	-1	0
0	0	0	0	-1	0	1	0	0	0	-1	0	0
-1	-1	1	0	0	0	0	0	0	0	0	0	0
0	0	-1	-1	0	1	-1	0	1	1	0	0	0
-20	0	-50	0	0	-50	0	0	0	0	0	0	0
0	10	50	0	0	0	0	0	0	0	0	0	-1
0	0	0	0	-10	0	-30	0	0	0	0	0	1
0	0	0	0	0	50	0	-10	0	0	0	0	-5
0	0	0	0	0	0	30	0	0	30	20	0	0
0	0	0	0	0	0	0	0	0	30	0	-10	-5
"""

def convert_string_to_matrix(raw):
    return [
        list(map(int, line.split()))
        for line in raw.strip().splitlines()
    ]

M = Matrix(convert_string_to_matrix(raw))

rref_matrix, pivot_cols = M.rref()
sp.pprint(rref_matrix)

A = M[:, :-1]
b = M[:, -1]

print("A shape:", A.shape)
print("rank(A):", A.rank())
print("nullity:", A.cols - A.rank())

print("rank([A|b]):", M.rank())

currents = []
for idx, val in enumerate(rref_matrix[:, -1],1):
    currents.append(val)
    print(f"I_{str(idx).zfill(2)} = {'%.4f'%float(val*1000)} mA")

print(currents)

resistor_values = {
    'A': 10,
    'B': 10,
    'C': 10,
    'D': 50,
    'E': 10,
    'F': 50,
    'G': 30,
    'H': 10,
    'I': 30,
    'J': 10,
    'K': 10,
    'L': 10,
}

resistor_map = {
    'A': 1,
    'B': 2,
    'C': 1,
    'D': 3,
    'E': 5,
    'F': 6,
    'G': 7,
    'H': 8,
    'I': 10,
    'J': 11,
    'K': 12,
    'L': 11,
}

for r, curr_idx in resistor_map.items():
    print(r, '%.4f'%float(abs(currents[curr_idx-1]*resistor_values[r])))



