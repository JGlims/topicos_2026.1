%  TVmodel_RLS.m: Estimation of time-varying linear model using RLS algorithm
%  y(n) = theta(n)*u + e(n)
%  theta(n): vector of parameters at time n;
% 
% Assume the vectors of output y and input u are in workspace
% y is N x 1, u is N x np
% 
%lambda = input(' Enter forgetting factor (range:0.97-0.995; default(0.98) enter 0)>>'); 
if lambda==0
    lambda = 0.98;
end;
% input number of parameters to be estimated
%np = input(' Enter number of parameters/coeffs to be estimated >>');
N = 500; % Total number of data points

% Initialization
x = zeros(np,1);    % vector containing input values at current time

t = [1:1:N]';
theta = zeros(N,np);  %tv parameter vector
Perrvar = zeros(N,np);  %tv parameter error variance 
P0 = 1000; % Initial parameter error variance - give it a very large number
P = zeros(np,np);
for i=1:np
    P(i,i) = P0;
end;    % Initialize parameter error covariance matrix
eprior = zeros(N,1); %Initialize vector of prior errors
e = zeros(N,1);   %Initialize vector of updated errors

for i=1:N,
   
% Form x-vector
   x = u(i,:)'; 
% Change in Predicted Output based on previous model parameter estimates
   if i==1
      ypred = y(i);
   else
      ypred = theta(i-1,:)*x;
   end;       
% Error(difference) between y and model prediction
%  where prediction uses prior values of model parameters
   eprior(i) = y(i) - ypred;

% Update gain vector
   den = lambda + x'*P*x;
   K = P*x/den;

%  Update parameter error covariance matrix
   P = (P - P*x*x'*P/den)/lambda;
   for k=1:np
      Perrvar(i,k) = P(k,k); %store updated P-var results
   end;
% Update parameter vector with new parameter values and updated Kalman gain
   if i>1
    theta(i,:) = theta(i-1,:) + K'*eprior(i);
   end; 
% Updated prediction (using updated parameter values)and error
   if i==1
      ypred2(i) = y(i);
   else
      ypred2(i) = theta(i,:)*x;
   end;  
   e(i) = y(i) - ypred2(i);
   
end; % for i=1:N




