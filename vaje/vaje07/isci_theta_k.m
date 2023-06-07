function [k,theta]=isci_theta_k(b,B)
%ISCI_THETA doloci theta^*, resitev g(theta)=0
%Predpostavka: T1(0,0), T2(b,B)
%[k,theta]=ISCI_THETA_K(b,B);
    f_theta = @(t) (1 - cos(t) + (B/b) * (t - sin(t)));
    theta = fzero(f_theta, pi);
    
    k = sqrt((2*b) / (theta - sin(theta)));
end