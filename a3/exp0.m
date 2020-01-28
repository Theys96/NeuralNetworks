%exp0

clear all

P = 100;
Q = 100;
first = true;
nhidden = 2;
norm1 = true;
tmax = 1e4;
eta = 5e-2;

[MSEvec_train, MSEvec_gen,w] = main(P,Q,first,nhidden,norm1,tmax,eta);
subplot(1,2,1);
plot_MSE(MSEvec_train,MSEvec_gen,tmax,P,Q,eta,false);
subplot(1,2,2);
plot_w(w,nhidden);