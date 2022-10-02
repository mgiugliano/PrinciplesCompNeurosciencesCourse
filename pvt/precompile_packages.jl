using Pkg

Pkg.precompile("PackageCompiler")
Pkg.precompile("PlotlyJS")
Pkg.precompile("IJulia")

using PackageCompiler
using PlotlyJS
using IJulia

using PlotlyJS
p = plot(rand(2,2))

using IJulia
installkernel("Julia")

