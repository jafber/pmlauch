using Distributions

N = 20
μ1 = 8
μ2 = 12
σ2_1 = 2
σ2_2 = 2
β2 = 3
s1 = Vector(1:3)
s2 = Vector(1:3)
p1 = Vector(1:4)
p2 = Vector(1:4)
d = -N:N

function f1(s1::Vector{Int})::Vector{Float64}
    # [s1 x 1]
    return pdf.(Normal(μ1, σ2_1), s1)
end
function f2(s1::Vector{Int}, p1::Vector{Int})::Matrix{Float64}
    # [s1 x p1]
    #    1   2   3   4 p1
    # 1  .   .   .   .
    # 2  .   .   .   .
    # 3  .   .   .   .
    # s1
    return [
        pdf(Normal(s1_val, β2), p1_val)
        for s1_val in s1, p1_val in p1
    ]
end

m_f1_s1 = f1(s1) # [s1 x 1]
p_s1 = m_f1_s1 # [s1 x 1]
x = f2(s1, p1) .* p_s1 # [s1 x p1]
m_f2_p1 = vec(sum(x, dims=1)) # [p1 x 1]
