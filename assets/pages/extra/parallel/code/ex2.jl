# This file was generated, do not modify it. # hide
using Plots # hide
pyplot() # hide
plot(leg=false, axis=false, axis_ratio=:equal, ticks=false) # hide
plot!([0,1,1,0,0], [0,0,1,1,0], c=:blue, fill=true, fillcolor=:lightblue) # hide
t = range(0, π / 2, length=100) # hide
plot!([0; cos.(t); 0], [0; sin.(t); 0], c=:red, fill=true, fillcolor=:pink) # hide
png(joinpath(@OUTPUT, "parallel-1")) # hide