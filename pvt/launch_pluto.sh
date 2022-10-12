npx localtunnel --port 1234 & 
julia -O3 --eval 'using Pluto; Pluto.run(Pluto.ServerSession(secret="mg", options=Pluto.Configuration.from_flat_kwargs(host="0.0.0.0", port=1234)))' 
