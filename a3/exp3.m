%exp1 run main to vary of n° of hidden units

clear all

P = 500;
Q = 100;
nhidden = [1 2 3 4 5];
nhiddens = size(nhidden,2);
first = false;
norm1 = true;
tmax = 1e4;
eta = 5e-2;

finalMSEtrain = zeros([1,nhiddens]);
finalMSEtrain = zeros([1,nhiddens]);

reps = 10;

for i = 1:nhiddens
  fprintf('doing nhidden = %g \n',nhidden(i));
  finalMSEt = 0;
  finalMSEg = 0;
  for rep = 1:reps
    fprintf('doing rep %g \n',rep);
    [MSEvec_train, MSEvec_gen,w] = main(P,Q,first,nhidden(i),norm1,tmax,eta);
    finalMSEt = finalMSEt + MSEvec_train(end);
    finalMSEg = finalMSEg + MSEvec_gen(end);
  end
  %{
  figure(i);
  subplot(1,2,1);
  plot_MSE(MSEvec_train,MSEvec_gen,tmax,P,Q,eta,false);
  subplot(1,2,2);
  plot_w(w,i);
  %}
  finalMSEtrain(i) = finalMSEt/reps;
  finalMSEgen(i)   = finalMSEg/reps;
end

figure(nhiddens+1);
semilogy(nhidden,finalMSEtrain,'LineStyle','-','LineWidth',1,'Marker','d','MarkerSize',13,'color','r','DisplayName','training error');
hold on
semilogy(nhidden,finalMSEgen,'LineStyle','-','LineWidth',1,'Marker','d','MarkerSize',13,'color','b','DisplayName','test error');
xlabel('n° of hidden units','FontSize',14);
xticks([nhidden]);
xlim([nhidden(1)-0.5,nhidden(end)+0.5]);
ylabel('MSE by the end of training','FontSize',14);
title({'Final error to vary of number of hidden units' sprintf('tmax = %g, \\eta = %g, P = %g, reps = %g',tmax,eta,P,reps)});
grid on
lgd = legend;
lgd.FontSize = 12;