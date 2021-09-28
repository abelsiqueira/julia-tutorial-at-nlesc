# This file was generated, do not modify it. # hide
using SequGen # hide
using Unitful, UnitfulRecipes, Plots
month = 30u"d"
t = range(0 * month, 11 * month, length=12)
seqs = [
  Constant(15.0u"°C"),
  SineWave(:from_peak, 15.0u"K", 12month, (6 + 22 / 30) * month),
  GaussianNoise(0.5u"K"),
]
ys = sample.(seqs, Ref(t))
y = uconvert.(u"°C", sum(ys))
plot(t, y, leg=false)
title!("Average temperature of 2022 in some city")
xlabel!("Days since 01/Jan/2022")
ylabel!("Temperature (in degrees Celsius)")
savefig(joinpath(@OUTPUT, "example-2.png")) # hide