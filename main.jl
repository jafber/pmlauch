include("marginals.jl")

using .Marginals
using Plots

N = 20
μ1 = 8
μ2 = 12
σ2_1 = 2
σ2_2 = 2
β2 = 3
s1 = s2 = p1 = p2 = Vector{Float64}(1:N)
d = Vector{Float64}(-N:N)
ϵ = 0.0001

function printd(d)
    for key in sort(collect(keys(d)))
        print(d[key])
        print(" ")
    end
    print("\n")
end

@time begin
    p_d = Marginals.d(N, μ1, μ2, σ2_1, σ2_2, β2)
    p_s1 = Marginals.s1(N, μ1, μ2, σ2_1, σ2_2, β2)
    p_s2 = Marginals.s2(N, μ1, μ2, σ2_1, σ2_2, β2)
    p_p1 = Marginals.p1(N, μ1, μ2, σ2_1, σ2_2, β2)
    p_p2 = Marginals.p2(N, μ1, μ2, σ2_1, σ2_2, β2)
end

plot(xlabel="Parameter s1 / p1 / s2 / p2", ylabel="Probability p", legend=:topleft)
plot!(p_s1, linewidth=2, color=:indigo, label="s1")
plot!(p_p1, linewidth=2, color=:indigo, linestyle=:dash, label="p1")
plot!(p_s2, linewidth=2, color=:darkorange2, label="s2")
plot!(p_p2, linewidth=2, color=:darkorange2, linestyle=:dash, label="p2")
vline!([μ1], label="μ1 = $μ1", lw=2, linestyle=:dot, color=:red)
vline!([μ2], label="μ2 = $μ2", lw=2, linestyle=:dot, color=:red)
savefig("sumout_params.png")

plot(xlabel="Final score d", ylabel="Probability p(d)",  legend=:topleft)
plot!(p_d, linewidth=2, color=:indigo, label="d")
savefig("sumout_data.png")
