# This file was generated, do not modify it. # hide
using RDatasets, StatsPlots

df = dataset("datasets", "iris")
@df df cornerplot(cols(1:4), compact=true)
png(joinpath(@OUTPUT, "vis-statsplots-1"))