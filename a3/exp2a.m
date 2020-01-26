%exp2 systematic influence of learning step \eta

clear all 

P = 500;
Q = 100;
first = false;
nhidden = 2;
norm1 = true;
tmax = 1e4;
eta = [0.5 0.1 0.05 0.025 0.01 0.005 0.001];
netas = size(eta,2);

finalMSEtrain = zeros([1,netas]);
finalMSEgen   = zeros([1,netas]);

reps = 10;

for i = 1:netas
  fprintf('doing eta = %.2f \n',eta(i));
  finalMSEt   = 0;
  finalMSEg   = 0;
  for rep = 1:reps
    fprintf('doing rep %g \n',rep);
    [MSEvec_train, MSEvec_gen,w] = main(P,Q,first,nhidden,norm1,tmax,eta(i));
    finalMSEt   = finalMSEt   + MSEvec_train(end);
    finalMSEg   = finalMSEg   + MSEvec_gen(end);
    %{
    figure(i);
    subplot(1,2,1);
    plot_MSE(MSEvec_train,MSEvec_gen,tmax,P,Q,eta(i));
    subplot(1,2,2);
    plot_w(w,nhidden);
    %}
  end
  finalMSEtrain(i) = finalMSEt/reps;
  finalMSEgen(i)   = finalMSEg/reps;
end

figure(netas+1);
loglog(eta,finalMSEtrain,'LineWidth',2,'Marker','d','MarkerSize',12,'color','r','DisplayName','training error');
hold on
loglog(eta,finalMSEgen,'LineWidth',2,'Marker','d','MarkerSize',12,'color','b','DisplayName','test error');
xlabel('\eta','FontSize',14);
xticks([sort(eta,'ascend')]);
ylabel('MSE by the end of training','FontSize',14);
title({'Final error to vary of learning step \eta' sprintf('tmax = %g, P = %g, reps = %g',tmax,P,reps)});
grid on
lgd = legend;
lgd.FontSize = 12;