using Gadfly
using DataFrames

diff_forward(f, h; x=0.5) = (f(x + h) - f(x)) / h
diff_central(f, h; x=0.5) = (f(x + h) - f(x - h)) / 2 / h
diff_backward(f, h; x=0.5) = (f(x) - f.(x - h)) / h
diff_complex(f, h; x=0.5) = imag(f(x + h*im)) / h


hs = 10.0 .^ (-18:0);

result = zeros(5, length(hs))
result[1, :] .= diff_forward.(sin, hs);
result[2, :] .= diff_central.(sin, hs);
result[3, :] .= diff_backward.(sin, hs);
result[4, :] .= diff_complex.(sin, hs);
result[5, :] .= cos(0.5);

for i=1:4
    result[i, :] = log10.(abs.(result[i, :] - result[5, :]) .+ 1e-18)
end

x = repeat(Array(-18:0), 1, 4)'
plot(x=x, y=result[1:4, :], Geom.line)

df = DataFrame(result[1:4, :]')
df[:, :x] = Array(-18:0)

plot(df, layer(x=:x, y=:x1, Geom.line),
         layer(x=:x, y=:x2, Theme(default_color="red"), Geom.line),
         layer(x=:x, y=:x3, Theme(default_color="green"), Geom.line),
         layer(x=:x, y=:x4, Theme(default_color="brown"), Geom.line))
