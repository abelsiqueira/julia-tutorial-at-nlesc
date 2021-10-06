# This file was generated, do not modify it. # hide
X = [
  0.4 * randn(div(n, 2), 2) .+ 3;
  1.2 * randn(div(n, 2), 2) .- 1;
]
h = 1.0
K(x) = exp(-norm(x)^2 / h) / h
f(x) = sum(K(x - X[i,:]) for i = 1:n) / n

plt = plot(layout=grid(2,2), leg=false)
scatter!(plt[1], X[:,1], X[:,2], title="scatter")
contour!(plt[2], -5:0.1:5, -5:0.1:5, (x,y) -> f([x;y]), title="countour", levels=50)
surface!(plt[3], -5:0.1:5, -5:0.1:5, (x,y) -> f([x;y]), title="surface")
surface!(plt[4], -5:0.1:5, -5:0.1:5, (x,y) -> f([x;y]), title="surface", camera=(70,10))
plt
png(joinpath(@OUTPUT, "vis-plots-2"))