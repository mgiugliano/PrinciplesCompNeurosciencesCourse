#
# Deploying julia 1.8.2 on Google Colab
#
# October 2nd, 2022 - Michele GIUGLIANO
#

if command -v julia --version &> /dev/null
then
    echo "julia is already installed! Nothing to do."
    exit
fi

echo "Installing Julia... please wait (~2min)"

# First, I define the source url (from julialang.org)
# See: https://julialang.org/downloads/
url='https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.2-linux-x86_64.tar.gz'

# Next we use the command 'wget' to download and uncompressed the tar archive
wget -O- $url | tar xz -C /usr/local --strip-components 1
echo "Julia downloaded and uncompressed!"


# We finally launch julia non-interactively and instruct it to install a series of packages
julia -e 'using Pkg; Pkg.add("PackageCompiler"); Pkg.add("PlotlyJS"); Pkg.add("IJulia"); Pkg.precompile("PackageCompiler"); Pkg.precompile("PlotlyJS"); Pkg.precompile("IJulia");'

echo "Julia packages have been installed!"

# as well as precompile them
julia -e 'using Pkg; Pkg.precompile("PackageCompiler"); Pkg.precompile("PlotlyJS"); Pkg.precompile("IJulia"); using PackageCompiler; using PlotlyJS; using IJulia; using PlotlyJS; p = plot(rand(2,2)); using IJulia; installkernel("Julia");'

echo "Julia packages have been precompiled and IJulia kernel added!"

echo "You are ready to go! Please refresh the page."
