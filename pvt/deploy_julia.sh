#
# Deploying julia 1.8.2 on Google Colab
#
# October 2nd, 2022 - Michele GIUGLIANO
#

if [ -f ./foo.bar ]; then
    echo "Script already run!"
    echo "NOW REFRESH/RELOAD THIS PAGE BY THE BROWSER (CTRL-R OR CMD-R)"
    exit 0
fi

! command -v julia --version >/dev/null 2>&1 || { echo "Julia is installed. Nothing to do." >&2; exit 1; }

#echo "Installing webIO jupyter extension..."
#pip3 install --upgrade webio_jupyter_extension >/dev/null 2>&1
#echo "Done!"
#echo ""

echo "-== Installing Julia... please wait (~3min) ==-"

# First, I define the source url (from julialang.org)
# See: https://julialang.org/downloads/
url='https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.2-linux-x86_64.tar.gz'

# Next we use the command 'wget' to download and uncompressed the tar archive
echo "Downloading and installing julia from julialang.org..."
#wget -O- $url >/dev/null 2>&1 | tar xz -C /usr/local --strip-components 1 #>/dev/null 2>&1
wget $url -O julia.tar.gz >/dev/null 2>&1
tar xz -C /usr/local --strip-components 1 -f julia.tar.gz >/dev/null 2>&1
rm julia.tar.gz >/dev/null 2>&1
echo "Done!"
echo ""

# We finally launch julia non-interactively and instruct it to install a series of packages
echo "Installing packages... (i.e. Plots, IJulia, Distributions, DSP)"
# echo "As we wait, ...let me introduce you my beloved dog."
# echo "Her name is Margherita...she is a Sloughi, also known as an Arabian Greyhound Galgo!"
# echo "             /)-_-(\ "
# echo "              (o o)"
# echo "      .-----__/\o/"
# echo "     /  __      /"
# echo " \__/\ /  \_\ |/"
# echo "      \\     ||"
# echo "      //     ||"
# echo "      |\     |\ "

julia -e 'using Pkg; Pkg.add("Plots"); Pkg.add("IJulia"); Pkg.add("Distributions"); Pkg.add("DSP");' >/dev/null 2>&1
# julia -e 'using Pkg; Pkg.add("PackageCompiler"); Pkg.add("Plots"); Pkg.add("Plotly"); Pkg.add("Pluto"); Pkg.add("PlutoUI"); Pkg.add("IJulia");' >/dev/null 2>&1
echo "Done!"
echo ""

# as well as precompile them
echo "Precompiling packages and installing kernel..."
julia -e 'using Pkg; Pkg.precompile("Plots"); Pkg.precompile("Distributions"); Pkg.precompile("DSP"); Pkg.precompile("IJulia"); using IJulia; installkernel("Julia");' >/dev/null 2>&1
# julia -e 'using Pkg; Pkg.precompile("PackageCompiler"); Pkg.precompile("Plots"); Pkg.precompile("IJulia"); using PackageCompiler; using Plots; using IJulia; p = plot(rand(2,2)); installkernel("Julia");' >/dev/null 2>&1
echo "Done!"
echo ""

# Let's finally make it version-agnostic
echo "Making julia-version agnostic..."
mv /root/.local/share/jupyter/kernels/julia-1.8 /root/.local/share/jupyter/kernels/julia >/dev/null 2>&1
echo "Done!"
echo ""

# # This is experimental - comment it out for the moment
# echo "Static compilation step..."
# curl --output precompile.jl -fsSL https://raw.githubusercontent.com/mgiugliano/PrinciplesCompNeurosciencesCourse/main/pvt/precompile.jl

# julia -e 'using PackageCompiler; create_sysimage(["Plots", "Pluto", "PlutoUI", "Plotly"], sysimage_path="sys_mg.so", precompile_execution_file="precompile.jl")'


echo "Congrats!! Installation was successful."
echo "NOW REFRESH/RELOAD THIS PAGE BY THE BROWSER (CTRL-R OR CMD-R)"
echo ""
touch ./foo.bar
