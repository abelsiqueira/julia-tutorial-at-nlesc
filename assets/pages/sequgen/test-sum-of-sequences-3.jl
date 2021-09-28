# This file was generated, do not modify it. # hide
seq = sum(
  SineWave(1 / (2k + 1), 1 / (2k + 1), 0.0) for k = 0:6
)
t = range(0, 1, length=300)
y = sample(seq, t)
plot(t, y)
savefig(joinpath(@OUTPUT, "test-sum-of-sequences-3.png")) # hide