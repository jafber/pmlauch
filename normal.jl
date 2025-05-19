using Distributions, Plots, Random, Colors

Random.seed!(420)

# DISTRIBUTIONS

μ1 = -3
μ2 = 7
σ1 = 2
σ2 = 2
n1 = Normal(μ1, σ1)
n2 = Normal(μ2, σ2)
μ12 = (μ1 * σ1^2 + μ2 * σ2^2) / (σ1^2 + σ2^2)
σ12 = (σ1^2 * σ2^2) / (σ1^2 + σ2^2)
n12 = Normal(μ12, σ12)

# DRAW SAMPLES

N = 10000
X_vals = rand(n1, N)
Y_vals = rand(n2, N)
Z_vals = X_vals .* Y_vals

# INITIALIZE PLOT

# min_x = minimum(vcat(X_vals, Y_vals, Z_vals))
# max_x = maximum(vcat(X_vals, Y_vals, Z_vals))
min_x = -50
max_x = 20
x = min_x:0.1:max_x
plot(xlims=(min_x, max_x), legend=:topleft)

# HISTOGRAMS

function hist(vals, label, color)
    histogram!(vals, label=label, normalize=:pdf, color=RGBA(color.r, color.g, color.b, 0.5), linealpha=0)
end

hist(X_vals, "X", colorant"red")
hist(Y_vals, "Y", colorant"blue")
hist(Z_vals, "Z=X*Y", colorant"green")

# PLOTS

function dist_plot(n, label, color)
    plot!(x, pdf.(n, x), label=label, linewidth=3, linecolor=color)
end

dist_plot(n1, "fX(x)", colorant"darkred")
dist_plot(n2, "fY(x)", colorant"darkblue")
dist_plot(n12, "fX(x)*fY(x)", colorant"darkgreen")

# DRAW

savefig("normal.png")
# gui()
# readline()
