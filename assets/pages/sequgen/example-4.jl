# This file was generated, do not modify it. # hide
using SequGen # hide
using Unitful, UnitfulRecipes, Plots
n = 100
month = 30u"d"
t = range(3month, 3month + 3u"d", length=n+1)[1:n]
seqs = [
  Constant(15.0u"°C"),
  SineWave(:from_peak, 15.0u"K", 12month, (6 + 22 / 30) * month),
  SineWave(:from_peak, 2.0u"K", 24u"hr", 12u"hr")
]
ys = sample.(seqs, Ref(t))
y = uconvert.(u"°C", sum(ys))
ticks = range(3month, 3month + 3u"d", step=12u"hr")
plot(t, y, leg=false, xticks=ticks)
title!("Average temperature of 2022 in some city")
xlabel!("Days since 01/Jan/2022")
ylabel!("Temperature (in degrees Celsius)")
png(joinpath(@OUTPUT, "example-4")) # hide