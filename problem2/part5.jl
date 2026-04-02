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


# Insert Solution you find here
f(x, y) = y * sin(x) - 0.1 * y^2

x0 = 0.0
y0 = 1.3
xf = 9
h = 0.25
n = round(Int, (xf - x0) / h)

xe, ye = feuler(f, x0, y0, h, n)
xm, ym = rk2(f, x0, y0, h, n)
xr, yr = rk4(f, x0, y0, h, n)

p = plot(
    xe,
    ye;
    label="F-Euler Approximation",
    color=:blue,
    linewidth=2,
    xlabel="x",
    ylabel="y",
    legend=:topright,
)

plot!(p, xm, ym; label="Midpoint Approximation", color=:red, linewidth=2)
plot!(p, xr, yr; label="RK4 Approximation", color=:green, linewidth=2)

savefig(p, "problem2_5.png")
