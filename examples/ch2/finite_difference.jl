diff_forward(f, x; h=1e-10) = (f(x + h) - f(x)) / h
diff_central(f, x; h=1e-10) = (f(x + h) - f(x - h)) / 2 / h
diff_backward(f, x; h=1e-10) = (f(x) - f(x - h)) / h
diff_complex(f, x; h=1e-10) = imag(f(x + h*im)) / h



hs = 10.0 .^ (-18:0);

result = zeros(5, length(hs))

for i=1:length(hs)
    h = hs[i]
    result[1, i] = diff_forward(sin, 0.5; h=h)
    result[2, i] = diff_central(sin, 0.5; h=h)
    result[3, i] = diff_backward(sin, 0.5; h=h)
    result[4, i] = diff_complex(sin, 0.5; h=h)
end

result[5, :] .= cos(0.5);
