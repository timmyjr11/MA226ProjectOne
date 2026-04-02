using Plots

k = 0.5
m = 2
b = 20
T0 = 4

f(t, T) = -k * (T - (m*t + b))

trange = 0:2:24
Trange = 10:10:100

t_grid = [t for t in trange, T in Trange]
T_grid = [T for t in trange, T in Trange]
u = ones(size(t_grid))
v = f.(t_grid, T_grid)

C = T0 - (b - m/k)
sol(t) = m*t + b - m/k + C * exp(-k*t)

t_fine = 0:0.1:24

quiver(t_grid, T_grid, quiver=(u, v), 
       arrow=arrow(:closed, :head, 0.1, 0.1), 
       title="Energy Drink Inside Room", 
       xlabel="Time (Hours)", ylabel="Temp (C)", 
       color=:gray, alpha=0.5, label="Slope Field")

p = plot!(t_fine, sol.(t_fine), color=:red, linewidth=3, 
          label="Particular Solution")

savefig(p, "problem2_3.png")