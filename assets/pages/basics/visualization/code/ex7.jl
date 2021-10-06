# This file was generated, do not modify it. # hide
using GraphRecipes
g = rand(0:1, 5, 5)
graphplot(g)
png(joinpath(@OUTPUT, "vis-graphrecipes-1"))