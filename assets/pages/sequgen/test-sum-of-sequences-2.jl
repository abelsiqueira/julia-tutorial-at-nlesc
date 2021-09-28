# This file was generated, do not modify it. # hide
seqsum = SineWave(1.0, 1.0, 0.0) + SineWave(0.5, 0.25, 0.0)
seqprod = SineWave(1.0, 0.2, 0.0) * Trend(0.5, 2.0)
seqquad = Trend(0.25, 4.0) * Trend(0.8, 2.0)
t = range(0, 1, length=100)
y1 = sample(seqsum, t)
y2 = sample(seqprod, t)
y3 = sample(seqquad, t)
plot(t, y1)
plot!(t, y2)
plot!(t, y3)
png(joinpath(@OUTPUT, "test-sum-of-sequences-2")) # hide