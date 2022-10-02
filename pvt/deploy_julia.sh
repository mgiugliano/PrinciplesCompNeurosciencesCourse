#
# Deploying julia 1.8.2 on Google Colab
#
# October 2nd, 2022 - Michele GIUGLIANO
#

# First, I define the url (from julialang.org) where the
# desired julia stable release can be downloaded..
# See: https://julialang.org/downloads/
url = 'https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.2-linux-x86_64.tar.gz'

# Next we use the command 'wget' to download and uncompressed the tar archive
wget -O- $url | tar xz -C /usr/local --strip-components 1

# We finally launch julia non-interactively and instruct it to
#
julia -e 'using Pkg; pkg"add IJulia; precompile;"'
julia -e ./install_packages.jl
julia -e ./precompile_packages.jl

