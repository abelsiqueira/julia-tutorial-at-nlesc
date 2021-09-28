# This file was generated, do not modify it. # hide
using Unitful # hide
println("width = ", 30u"cm" + 0.8u"m")
println("area = ", 30u"cm" * 0.8u"m")
println("area = ", uconvert(u"m^2", 30u"cm" * 0.8u"m"))
println("ratio1 = ", 12u"m" / 30u"m")
println("ratio2 = ", 12u"m" / 3000u"cm")
println("ratio2 = ", uconvert(NoUnits, 12u"m" / 3000u"cm"))