module Marginals

export d, s1, s2, p1, p2

using Distributions

function f1(s1, μ1, σ1)
    return pdf(Normal(μ1, sqrt(σ1)), s1)
end

function f2(s1, p1, β)
    return pdf(Normal(s1, sqrt(β)), p1)
end

function f3(s2, μ2, σ2)
    return pdf(Normal(μ2, sqrt(σ2)), s2)
end

function f4(s2, p2, β)
    return pdf(Normal(s2, sqrt(β)), p2)
end

function f5(p1, p2, d)
    return p1 - p2 == d ? 1 : 0
end

function f6(d)
    return d > 0
end

function joint_probability(s1, s2, p1, p2, d, μ1, μ2, σ1, σ2, β)
    return f1(s1, μ1, σ1) * f2(s1, p1, β) * f3(s2, μ2, σ2) * f4(s2, p2, β) * f5(p1, p2, d) * f6(d)
end

function s1(N, μ1, μ2, σ1, σ2, β)
    level_values = 1:N
    result_values = -N:N
    p_s1 = Dict{Int, Float64}()

    for s1 in level_values
        total = 0.0
        for s2 in level_values, p1 in level_values, p2 in level_values, d in result_values
            total += joint_probability(s1, s2, p1, p2, d, μ1, μ2, σ1, σ2, β)
        end
        p_s1[s1] = total
    end

    return p_s1
end

function s2(N, μ1, μ2, σ1, σ2, β)
    level_values = 1:N
    result_values = -N:N
    p_s2 = Dict{Int, Float64}()

    for s2 in level_values
        total = 0.0
        for s1 in level_values, p1 in level_values, p2 in level_values, d in result_values
            total += joint_probability(s1, s2, p1, p2, d, μ1, μ2, σ1, σ2, β)
        end
        p_s2[s2] = total
    end

    return p_s2
end

function p1(N, μ1, μ2, σ1, σ2, β)
    level_values = 1:N
    result_values = -N:N
    p_p1 = Dict{Int, Float64}()

    for p1 in level_values
        total = 0.0
        for s1 in level_values, s2 in level_values, p2 in level_values, d in result_values
            total += joint_probability(s1, s2, p1, p2, d, μ1, μ2, σ1, σ2, β)
        end
        p_p1[p1] = total
    end

    return p_p1
end

function p2(N, μ1, μ2, σ1, σ2, β)
    level_values = 1:N
    result_values = -N:N
    p_p2 = Dict{Int, Float64}()

    for p2 in level_values
        total = 0.0
        for s1 in level_values, s2 in level_values, p1 in level_values, d in result_values
            total += joint_probability(s1, s2, p1, p2, d, μ1, μ2, σ1, σ2, β)
        end
        p_p2[p2] = total
    end

    return p_p2
end

function d(N, μ1, μ2, σ1, σ2, β)
    level_values = 1:N
    result_values = -N:N
    p_d = Dict{Int, Float64}()

    for d in result_values
        total = 0.0
        for s1 in level_values, s2 in level_values, p1 in level_values, p2 in level_values
            total += joint_probability(s1, s2, p1, p2, d, μ1, μ2, σ1, σ2, β)
        end
        p_d[d] = total
    end

    return p_d
end

end