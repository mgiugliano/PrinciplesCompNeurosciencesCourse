using Pkg

Pkg.add("PackageCompiler")
Pkg.add("PlotlyJS")
Pkg.add("IJulia")

Pkg.precompile("PackageCompiler")
Pkg.precompile("PlotlyJS")
Pkg.precompile("IJulia")

