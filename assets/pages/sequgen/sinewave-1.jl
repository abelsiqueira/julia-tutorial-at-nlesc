# This file was generated, do not modify it. # hide
using Plots, SequGen # hide
t = range(0, 10, length=50)
s = SineWave(2.0, 7.0, pi / 3)
y = sample(s, t)
plot(t, y)
savefig("sinewave-1.png") # hide