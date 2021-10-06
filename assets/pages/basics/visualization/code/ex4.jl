# This file was generated, do not modify it. # hide
using PyPlot
x = range(0, 2π, length=1000)
y = sin.(3 * x + 4 * cos.(2 * x))
PyPlot.figure()
PyPlot.plot(x, y, color="red", linewidth=2.0, linestyle="--")
PyPlot.title("A sinusoidally modulated sinusoid")
PyPlot.savefig(joinpath(@OUTPUT, "vis-pyplot-1"))