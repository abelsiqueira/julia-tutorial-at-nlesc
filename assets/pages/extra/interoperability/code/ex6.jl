# This file was generated, do not modify it. # hide
svm = pyimport_conda("sklearn.svm", "scikit-learn")
clf = svm.SVC(C=1e-2, gamma=5.0, probability=true)
clf.fit(X, y)
x1g = range(extrema(X[:,1])..., length=100)
x2g = range(extrema(X[:,2])..., length=100)
Z = [
  clf.predict_proba([x1i x2j;])[2] for x2j in x2g, x1i in x1g
]
contourf(x1g, x2g, Z, c=cgrad([:pink,:magenta,:lightblue]), levels=50)
idx = findall(y .== -1)
scatter!(X[idx,1], X[idx,2], m=(4,:red,:square), lab="", opacity=0.5)
idx = findall(y .== 1)
scatter!(X[idx,1], X[idx,2], m=(4,:blue,:circle), lab="", opacity=0.5)
png(joinpath(@OUTPUT, "pycall-2")) # hide