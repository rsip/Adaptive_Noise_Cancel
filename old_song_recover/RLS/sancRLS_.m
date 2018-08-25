function out = sancRLS_(x,L,lambda,delta)
%self-adaptive noise cancellation

%x:     signal to be filtered
%L:     length of  the filter
%mu:    adaptation rate
%delta: delay

I = eye(L);
n = size(x,1);
Y = [];
for i=L+delta:n-1
    if i == L+delta
        P_last = I;
        w_last = zeros(L,1);  
    end
    X = x(i-delta:-1:i-L+1-delta);
    y = w_last'*X;
	Y = [Y;y];
    alpha = x(i+1) - y;
    g = P_last * X / (lambda + X'* P_last * X);
    P = (I - g * X') * P_last / lambda;
    w = w_last + g * alpha;
    P_last = P;
    w_last = w;
end

out.weight = w;
out.filteredSignal = Y;
end