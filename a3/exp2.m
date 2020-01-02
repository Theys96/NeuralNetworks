%exp2 systematic influence of learning step \eta

clear all 

P = 500;
Q = 100;
first = true;
nhidden = 2;
norm1 = true;
tmax = 2e3;
eta = [0.2 0.1 0.05 0.025 0.01];
netas = size(eta,2);

train_thres = 0.03;
test_thres = 0.035;
t_thres_train = zeros([1,netas]);
t_thres_test  = zeros([1,netas]);

for i = 1:netas
  [MSEvec_train, MSEvec_gen,w] = main(P,Q,first,nhidden,norm1,tmax,eta(i));
  finalMSEtrain(i) = MSEvec_train(end);
  finalMSEgen(i)   = MSEvec_gen(end);
  t_thres_train(i) = find_time_thres(MSEvec_train,train_thres);
  t_thres_test(i) = find_time_thres(MSEvec_gen,test_thres);
  figure(i);
  subplot(1,2,1);
  plot_MSE(MSEvec_train,MSEvec_gen,tmax,P,Q,eta(i));
  subplot(1,2,2);
  plot_w(w,nhidden);
end

figure(netas+1);
plot(eta,finalMSEtrain,'o','MarkerSize',12,'color','r','DisplayName','training error');
hold on
plot(eta,finalMSEgen,'o','MarkerSize',12,'color','b','DisplayName','test error');
xlabel('\eta','FontSize',14);
ylabel('MSE by the end of training','FontSize',14);
title({'Final error to vary of learning step \eta' sprintf('tmax = %g',tmax)});
grid on
lgd = legend;
lgd.FontSize = 12;

figure(netas+2);
plot(eta,t_thres_train,'o','MarkerSize',12,'color','r','DisplayName',sprintf('training, thres = %g',train_thres));
hold on
plot(eta,t_thres_test,'o','MarkerSize',12,'color','b','DisplayName',sprintf('test, thres = %g',test_thres));
xlabel('\eta','FontSize',14);
ylabel('time','Fontsize',14);
title({'Learning time to reach the threshold vs \eta' sprintf('P = %g, Q = %g',P,Q)});
grid on
lgd = legend;
lgd.FontSize = 12;