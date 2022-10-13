using Pluto, PlutoUI, Plotly, Plots

x = 0:0.1:6.28
y = sin.(x)
plot(x, y)
