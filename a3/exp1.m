%exp1 run main to vary of P

clear all

P = [20 50 200 500 1000 2000];
nPs = size(P,2);
Q = 100;
first = false;
nhidden = 2;
norm1 = true;
tmax = 1e4;
eta = 5e-2;

finalMSEtrain = zeros([1,nPs]);
finalMSEgen   = zeros([1,nPs]);

reps = 10;

for i = 1:nPs
  fprintf('doing P = %g \n',P(i));
  finalMSEt = 0;
  finalMSEg = 0;
  for rep = 1:reps
    fprintf('doing rep %g \n',rep);
    [MSEvec_train, MSEvec_gen,w] = main(P(i),Q,first,nhidden,norm1,tmax,eta);
    finalMSEt = finalMSEt + MSEvec_train(end);
    finalMSEg = finalMSEg + MSEvec_gen(end);
  %{
  figure(i);
  subplot(1,2,1);
  plot_MSE(MSEvec_train,MSEvec_gen,tmax,P(i),Q,eta);
  subplot(1,2,2);
  plot_w(w,nhidden);
  %}
  end
  finalMSEtrain(i) = finalMSEt/reps;
  finalMSEgen(i)   = finalMSEg/reps;
end

figure('Position', [0 0 900 500]);
semilogy(P,finalMSEtrain,'LineStyle','-','LineWidth',1.5,'Marker','x','MarkerSize',13,'color','r','MarkerEdgeColor','k','DisplayName','training error');
hold on
xlim([-100,2100]);
semilogy(P,finalMSEgen,'LineStyle','-','LineWidth',1.5,'Marker','x','MarkerSize',13,'color','b','MarkerEdgeColor','k','DisplayName','test error (Q = 100)');
xlabel('P (training set size)','FontSize',14)
ylabel('Mean square error by the end of training','FontSize',14);
title({'Final error after training on training sets of various sizes' sprintf('t_{max} = %g, \\eta = %g, %g repetitions',tmax,eta,reps)},'FontSize',14);
grid on
lgd = legend;
lgd.FontSize = 12;