# This file was generated, do not modify it. # hide
using Plots, SequGen # hide
t = range(0, 10, length=50)
s = GaussianNoise(0.2)
y = sample(s, t)
plot(t, y)
savefig(joinpath(@OUTPUT, "gaussiannoise-1.png")) # hide