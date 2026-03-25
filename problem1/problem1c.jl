#Julia Newton's Law of Cooling real world graph
using Plots

# Model Parameters
Ta = 25.0
k = 0.061904
T0 = 90.0

# Define the ODE function
f(t, T) = -k * (T - Ta)

# Create grid for slope field
trange = 0:5:60
Trange = 10:10:100

# Calculate slopes
t_grid = [t for t in trange, T in Trange]
T_grid = [T for t in trange, T in Trange]
u = ones(size(t_grid)) # Horizontal component
v = f.(t_grid, T_grid) # Vertical component (slope)

# Particular solution function
sol(t) = Ta + (T0 - Ta) * exp(-k * t)
t_fine = 0:0.1:60

# Plotting
quiver(t_grid, T_grid, quiver=(u, v), arrow=arrow(:closed, :head, 0.1, 0.1), 
       title="Newton's Law of Cooling: Coffee", xlabel="Time (min)", ylabel="Temp (C)", 
       color=:gray, alpha=0.5, label="Slope Field")
p = plot!(t_fine, sol.(t_fine), color=:red, linewidth=3, label="Particular Solution (90C to 20C)")
savefig(p, "coolingCoffee.png")