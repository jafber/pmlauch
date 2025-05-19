using Distributions

function f1(s1, μ1, σ1)
    return pdf(Normal(μ1, σ1), s1)
end

function f2(s1, p1, β)
    return pdf(Normal(s1, β), p1)
end

function f3(s2, μ2, σ2)
    return pdf(Normal(μ2, σ2), s2)
end

function f4(s2, p2, β)
    return pdf(Normal(s2, β), p2)
end

function f5(p1, p2, d)
    return p1 - p2 == d ? 1 : 0
end

function f6(d)
    return d > 0
end
