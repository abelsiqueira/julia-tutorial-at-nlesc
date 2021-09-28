# This file was generated, do not modify it. # hide
seqsin = 2 * sin(Trend(0, 2pi))
seqlog = log(1.1 + SineWave(1.0, 1.0, 0.0) + 0.05 * exp(GaussianNoise()))
f(t) = 1 / (1 + exp(-t))
seqf = 5 * TransformedSequence(Trend(0.5, 10), f) - 2
t = range(0, 1, length=100)
y1 = sample(seqsin, t)
y2 = sample(seqlog, t)
y3 = sample(seqf, t)
plot(t, y1)
plot!(t, y2)
plot!(t, y3)
savefig(joinpath(@OUTPUT, "test-transform-1.png")) # hide