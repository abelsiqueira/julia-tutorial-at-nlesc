# This file was generated, do not modify it. # hide
using Plots, SequGen # hide
t = range(0, 11, length=12)
seqs = [
  Constant(15.0),
  SineWave(:from_peak, 15.0, 12.0, (6 + 22 / 30)),
  GaussianNoise(0.5),
]
ys = sample.(seqs, Ref(t))
y = sum(ys)
plot(t, y, leg=false)
title!("Average temperature of 2022 in some city")
xticks!(0:11)
xlabel!("Months since 01/Jan/2022")
ylabel!("Temperature (in degrees Celsius)")
savefig(joinpath(@OUTPUT, "example-1.png")) # hide