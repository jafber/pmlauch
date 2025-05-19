using Plots

s1 = [1,2,3,4,5,6]
# s1 = -10:0.1:10
μ1 = 4
σ1 = 2

function f1(s1)
    a = 1.0 / (2.0 * σ1^2)
    return (
        sqrt(a/π)
        .* exp.(
            (-a) .* (s1 .- μ1).^2.0
        )
    )
end

println(s1)
println(f1(s1))

# plot(s1, f1(s1))
# gui()
# readline()
