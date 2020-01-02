%exp1 run main to vary of P

clear all

P = [20 50 200 500 1000 2000];
nPs = size(P,2);
Q = 100;
first = true;
nhidden = 2;
norm1 = true;
tmax = 2e3;
eta = 5e-2;

finalMSEtrain = zeros([1,nPs]);
finalMSEgen   = zeros([1,nPs]);

for i = 1:nPs
  [MSEvec_train, MSEvec_gen,w] = main(P(i),Q,first,nhidden,norm1,tmax,eta);
  finalMSEtrain(i) = MSEvec_train(end);
  finalMSEgen(i)   = MSEvec_gen(end);
  figure(i);
  subplot(1,2,1);
  plot_MSE(MSEvec_train,MSEvec_gen,tmax,P(i),Q,eta);
  subplot(1,2,2);
  plot_w(w,nhidden);
end

figure(nPs+1);
plot(P,finalMSEtrain,'o','MarkerSize',12,'color','r','DisplayName','training error');
hold on
plot(P,finalMSEgen,'o','MarkerSize',12,'color','b','DisplayName','test error');
xlabel('P','FontSize',14);
ylabel('MSE by the end of training','FontSize',14);
title({'Final error to vary of number of training samples' sprintf('tmax = %g, \\eta = %g',tmax,eta)});
grid on
lgd = legend;
lgd.FontSize = 12;