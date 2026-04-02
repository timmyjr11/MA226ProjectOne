using Plots

B = 15
A = 10
omega = pi/12
phi = -((3*pi)/4)
k = 0.4
T0 = 85

f(t, T) = k*(A*cos(omega*t + phi) + B) - k*T

# Create grid for slope field
trange = 0:5:60
Trange = 10:10:100

# Calculate slopes
t_grid = [t for t in trange, T in Trange]
T_grid = [T for t in trange, T in Trange]
u = ones(size(t_grid)) # Horizontal component
v = f.(t_grid, T_grid) # Vertical component (slope)

sol(t) = 17.64*(cos(omega*t - phi) + omega*sin(omega*t - phi)) 
       + B + 85.64*exp(-k*t)

t_fine = 0:0.1:60

quiver(t_grid, T_grid, quiver=(u, v), 
       arrow=arrow(:closed, :head, 0.1, 0.1), 
       title="Coffee Outside in Boston", 
       xlabel="Time (Hours)", ylabel="Temp (C)", 
       color=:gray, alpha=0.5, label="Slope Field")

p = plot!(t_fine, sol.(t_fine), color=:red, linewidth=3, 
       label="Particular Solution")

savefig(p, "problem2_4.png")