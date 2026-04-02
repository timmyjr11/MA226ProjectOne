using Plots

function feuler(f, x0, y0, h, n)
    xx = zeros(n + 1)
    yy = zeros(n + 1)

    xx[1] = x0
    yy[1] = y0

    for k in 1:n
        xx[k+1] = xx[k] + h
        yy[k+1] = yy[k] + h * f(xx[k], yy[k])
    end

    return xx, yy
end

function rk2(f, x0, y0, h, n)
    xx = zeros(n + 1)
    yy = zeros(n + 1)

    xx[1] = x0
    yy[1] = y0

    for k in 1:n
        k1 = f(xx[k], yy[k])
        k2 = f(xx[k] + h / 2, yy[k] + (h / 2) * k1)

        xx[k + 1] = xx[k] + h
        yy[k + 1] = yy[k] + h * k2
    end

    return xx, yy
end

function rk4(f, x0, y0, h, n)
    xx = zeros(n + 1)
    yy = zeros(n + 1)

    xx[1] = x0
    yy[1] = y0

    for k in 1:n
        k1 = f(xx[k], yy[k])
        k2 = f(xx[k] + h / 2, yy[k] + (h / 2) * k1)
        k3 = f(xx[k] + h / 2, yy[k] + (h / 2) * k2)
        k4 = f(xx[k] + h, yy[k] + h * k3)



        xx[k + 1] = xx[k] + h
        yy[k + 1] = yy[k] + (h / 6) * (k1 + 2k2 + 2k3 + k4)
    end

    return xx, yy
end

B = 15
A = 10
omega = pi/12
phi = -((3*pi)/4)
k = 0.4

f(t, T) = k*(A*cos(omega*t + phi) + B) - k*T
# f(t) = A*k((k*cos(omega*t + phi) + omega*sin(omega*t + phi))/(k^2 + omega^2)) + B + 

x0 = 0.0
y0 = 85
xf = 24
h = 0.5
n = round(Int, (xf - x0) / h)

xe, ye = feuler(f, x0, y0, h, n)
xm, ym = rk2(f, x0, y0, h, n)
xr, yr = rk4(f, x0, y0, h, n)

den = k^2 + omega^2
C = T0 - (A*k*(k*cos(phi) + omega*sin(phi)) / den + B)
sol(t) = A*k*(k*cos(omega*t + phi) + omega*sin(omega*t + phi)) / den + B + C*exp(-k*t)
t_fine = 0:0.1:24

p = plot(
    xe,
    ye;
    label="F-Euler Approximation",
    color=:blue,
    linewidth=2,
    xlabel="Time (Hours)",
    ylabel="Temp (C)",
    legend=:topright,
)

plot!(p, xm, ym; label="Midpoint Approximation", color=:purple, linewidth=2)
plot!(p, xr, yr; label="RK4 Approximation", color=:green, linewidth=2)
plot!(p, t_fine, sol.(t_fine), label="Particular Solution", color=:red, linewidth=2, alpha=0.5)

savefig(p, "problem2_5.png")
