# Dimensions

3x2 Matrix with `size(M) = (3,2)`:

```
    1   2  -> Dim 2 (cols)
1   x   x
2   x   x
3   x   x
|
V
Dim 1 (rows)
```

# Sums

```
a =
[1 2;
 3 4;
 5 6]
sum(a) = 21
sum(a, dims=1) = [9 12] # sum up values along axis 1 (vertical)
sum(a, dims=2) = # sum up values along axis 2 (horizontal)
 [3;
  7;
  11]
```

# Matrix Broadcasting

Vektoren sind standardmäßig Spaltenvektoren!

```
b1 = [4.0, 5, 6]                # 3-element Vector{Float64}
b2 = [4.0; 5; 6]                # 3-element Vector{Float64}
m1 = [4.0 5 6]                  # 1×3 Matrix{Float64}
```

```
a .* 2 =
 [2 4;
  6 8;
  10 12]
a .* [1 2] =
 [1 4;
  3 8;
  5 12]
a .* [1; 2; 3] =
 [1 2;
  5 8;
  15 18]
```

# 3D Arrays

```julia
A = ones(4, 3, 2)
A[:, :, 2] *= 2
A
# 4×3×2 Array{Float64, 3}:
# [:, :, 1] =
#  1.0  1.0  1.0
#  1.0  1.0  1.0
#  1.0  1.0  1.0
#  1.0  1.0  1.0

# [:, :, 2] =
#  2.0  2.0  2.0
#  2.0  2.0  2.0
#  2.0  2.0  2.0
#  2.0  2.0  2.0
s = sum(A, dims=(1,2))
# 1×1×2 Array{Float64, 3}:
# [:, :, 1] =
#  12.0

# [:, :, 2] =
#  24.0
vec(s)
# 2-element Vector{Float64}:
#  12.0
#  24.0
```

# Transpositions

```julia
a = [1, 2, 3]
# 3-element Vector{Int64}:
#  1
#  2
#  3
reshape(a, :, 1)
# 3×1 Matrix{Int64}:
#  1
#  2
#  3
a'
# 1×3 adjoint(::Vector{Int64}) with eltype Int64:
#  1  2  3
reshape(a, 1, :)
# 1×3 Matrix{Int64}:
#  1  2  3
```