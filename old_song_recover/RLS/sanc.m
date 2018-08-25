function out = sanc(x,L,mu,delta)
%self-adaptive noise cancellation

%x:     signal to be filtered
%L:     length of  the filter
%mu:    adaptation rate
%delta: delay
index = 1;
W = mean(x)*ones(L,1); %initial weight vector, equal weights
n = size(x,1); %length of the vector for prediction
sigma2_k = 0;
alpha = 0.05;
Y = zeros(n,1);
for i=L+delta:n-1
    X = x(i-delta:-1:i-L+1-delta); %elements [i-delta-L+1:i+1]
    y = W'*X;
    e = x(i+1) - y;
    sigma2_k = alpha*X(1)^2 + (1-alpha)*sigma2_k;
    %sigma2_k
	Y(index,1) = y;
    index = index + 1;
    Wm1 = W;
    W = Wm1 + (2*mu*e/((L+1)*sigma2_k))*X;
    %diff(i) = norm((W-Wm1)./Wm1);
    
    % mu = (1-alpha)*mu; %reduce convergence factor exponentially if
%                           desired
end

% W

out.filteredSignal = Y;
out.weight = W;
end