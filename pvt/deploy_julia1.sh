#
# Deploying (statically compiled) julia 1.8.2 on Google Colab
#
# October 13th, 2022 - Michele GIUGLIANO
#

echo "-== Installing Julia... please wait (~3min) ==-"

echo "Downloading the sysimage..."
# First, I define the source url (from my Dropbox)
url='https://www.dropbox.com/s/fksi0gbrb50swtf/sys.tgz?dl=0'
wget $url -O sys.tgz >/dev/null 2>&1
echo "done!"
echo "Uncompressing the sysimage..."
tar xzf sys.tgz >/dev/null 2>&1
rm sys.tgz >/dev/null 2>&1
echo "done!"

# Next, I define the source url (from julialang.org)
# See: https://julialang.org/downloads/
url='https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.2-linux-x86_64.tar.gz'

# Now we use the command 'wget' to download and uncompressed the tar archive
echo "Downloading and installing julia from julialang.org..."
#wget -O- $url >/dev/null 2>&1 | tar xz -C /usr/local --strip-components 1 #>/dev/null 2>&1
wget $url -O julia.tar.gz >/dev/null 2>&1
tar xz -C /usr/local --strip-components 1 -f julia.tar.gz >/dev/null 2>&1
rm julia.tar.gz >/dev/null 2>&1
echo "done!"
echo ""

# From https://github.com/localtunnel/localtunnel
# Discovered from https://www.youtube.com/watch?v=NEhrkeF2o_M
npx localtunnel --port 1234 & 
julia --sysimage /content/sys_mg.so -O3 --eval 'using Pluto; Pluto.run(Pluto.ServerSession(secret="", options=Pluto.Configuration.from_flat_kwargs(host="0.0.0.0", port=1234)))' 

echo "Congrats!! Installation was successful."
