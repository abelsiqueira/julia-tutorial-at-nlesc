# This file was generated, do not modify it. # hide
plt = plot(layout=grid(2, 2))
for i = 1:4
  StatsPlots.violin!(plt[i], df.Species, df[!,i], lab="", ylabel=names(df)[i])
  StatsPlots.boxplot!(plt[i], df.Species, df[!,i], lab="", fillalpha=0.6, m=(0))
  StatsPlots.dotplot!(plt[i], df.Species, df[!,i], lab="", m=(:white, 2), opacity=0.6)
end
png(plt, joinpath(@OUTPUT, "vis-statsplots-2"))