include("marginals.jl")

N = 20
μ1 = 8
μ2 = 12
σ1 = sqrt(2)
σ2 = sqrt(2)
β = sqrt(3)

print(s1(N, μ1, μ2, σ1, σ2, β))
print(s2(N, μ1, μ2, σ1, σ2, β))
print(p1(N, μ1, μ2, σ1, σ2, β))
print(p2(N, μ1, μ2, σ1, σ2, β))
print(d(N, μ1, μ2, σ1, σ2, β))
