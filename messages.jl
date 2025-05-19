using Distributions, Plots

N = 20
μ1 = 8
μ2 = 12
σ2_1 = 2
σ2_2 = 2
β2 = 3
s1 = s2 = p1 = p2 = Vector{Float64}(1:N)
d = Vector{Float64}(-N:N)
ϵ = 0.0001

function f1(s1::Vector{Float64})::Vector{Float64}
    # [s1 x 1]
    return pdf.(Uniform(6, 9), s1)
    return pdf.(Normal(μ1, sqrt(σ2_1)), s1)
end

function f3(s2::Vector{Float64})::Vector{Float64}
    # [s2 x 1]
    return pdf.(Uniform(10, 13), s1)
    return pdf.(Normal(μ2, sqrt(σ2_2)), s2)
end

function f2(s1::Vector{Float64}, p1::Vector{Float64})::Matrix{Float64}
    # [s1 x p1]
    #    1   2   3   4 p1
    # 1  .   .   .   .
    # 2  .   .   .   .
    # 3  .   .   .   .
    # s1
    return [
        pdf(Normal(s1_val, sqrt(β2)), p1_val)
        for s1_val in s1, p1_val in p1
    ]
end

function f4(s2::Vector{Float64}, p2::Vector{Float64})::Matrix{Float64}
    # [s2 x p2]
    return [
        pdf(Normal(s2_val, sqrt(β2)), p2_val)
        for s2_val in s2, p2_val in p2
    ]
end

function f5(p1::Vector{Float64}, p2::Vector{Float64}, d::Vector{Float64})::Array{Float64, 3}
    # [p1 x p2 x d]
    return [
        p1_val - p2_val == d_val ? 1 : 0
        for p1_val in p1, p2_val in p2, d_val in d
    ]
end

function f6(d::Vector{Float64})::Vector{Float64}
    # [d x 1]
    return [
        Float64(d_val > 0)
        for d_val in d
    ]
end

function l1n(v::Vector{Float64})::Vector{Float64}
    s = sum(v)
    return v / s 
end

@time begin
    # HINRICHTUNG

    # s1, p1

    m_f1_s1 = f1(s1) # [s1 x 1]
    p_s1 = l1n(m_f1_s1) # [s1 x 1]
    x = f2(s1, p1) .* p_s1 # [s1 x p1]
    m_f2_p1 = l1n(vec(sum(x, dims=1))) # [p1 x 1]
    p_p1 = l1n(m_f2_p1) # [p1 x 1]
    m_p1_f5 = l1n(p_p1) # [p1 x 1]

    # s2, p2

    m_f3_s2 = l1n(f3(s2)) # [s2 x 1]
    p_s2 = l1n(m_f3_s2) # [s2 x 1]
    x = f4(s2, p2) .* p_s2 # [s2 x p2]
    m_f4_p2 = l1n(vec(sum(x, dims=1))) # [p2 x 1]
    p_p2 = l1n(m_f4_p2) # [p2 x 1]
    m_p2_f5 = l1n(p_p2) # [p2 x 1]

    # d

    x = f5(p1, p2, d) .* m_p1_f5 .* m_p2_f5' # [p1 x p2 x d]
    m_f5_d = l1n(vec(sum(x, dims=(1, 2)))) # [d x 1]
    p_d = l1n(m_f5_d)

    # RÜCKRICHTUNG

    # d

    m_f6_d = l1n(f6(d)) # [d x 1]
    p_d = l1n(m_f5_d .* m_f6_d) # [d x 1]
    m_f5_d_safe = m_f5_d .+ ϵ
    m_d_f5 = l1n(p_d ./ m_f5_d_safe) # [d x 1]

    # s1, p1
    x = f5(p1, p2, d) .* reshape(m_d_f5, 1, 1, :) .* m_p2_f5' # [p1 x p2 x d]
    m_f5_p1 = l1n(vec(sum(x, dims=(2, 3)))) # [p1 x 1]
    p_p1 = l1n(m_f2_p1 .* m_f5_p1) # [p1 x 1]
    m_f2_p1_safe = m_f2_p1 .+ ϵ
    x = f2(s1, p1) .* p_p1' ./ m_f2_p1_safe' # [s1, p1]
    m_f2_s1 = l1n(vec(sum(x, dims=2))) # [s1 x 1]
    p_s1 = l1n(m_f1_s1 .* m_f2_s1) # [s1 x 1]

    # s2, p2

    x = f5(p1, p2, d) .* reshape(m_d_f5, 1, 1, :) .* m_p1_f5 # [p1 x p2 x d]
    m_f5_p2 = l1n(vec(sum(x, dims=(1, 3)))) # [p2 x 1]
    p_p1 = l1n(m_f4_p2 .* m_f5_p2) # [p2 x 1]
    m_f4_p2_safe = m_f4_p2 .+ ϵ
    x = f2(s2, p2) .* p_p2' ./ m_f4_p2_safe' # [s2, p2]
    m_f4_s2 = l1n(vec(sum(x, dims=2))) # [s2 x 1]
    p_s2 = l1n(m_f3_s2 .* m_f4_s2) # [s2 x 1]
end

# PLOT

plot(xlabel="Parameter s1 / p1 / s2 / p2", ylabel="Probability p", legend=:topleft)
plot!(s1, p_s1, linewidth=2, color=:indigo, label="s1")
plot!(p1, p_p1, linewidth=2, color=:indigo, linestyle=:dash, label="p1")
plot!(s2, p_s2, linewidth=2, color=:darkorange2, label="s2")
plot!(p2, p_p2, linewidth=2, color=:darkorange2, linestyle=:dash, label="p2")
# vline!([μ1], label="μ1 = $μ1", lw=2, linestyle=:dot, color=:red)
# vline!([μ2], label="μ2 = $μ2", lw=2, linestyle=:dot, color=:red)
savefig("sum_product_params.png")

plot(xlabel="Final score d", ylabel="Probability p(d)",  legend=:topleft)
plot!(d, p_d, linewidth=2, color=:indigo, label="d")
savefig("sum_product_data.png")
