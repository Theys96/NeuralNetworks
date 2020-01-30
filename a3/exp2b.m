%exp2b eta(t) schedule

clear all 

P = 500;
Q = 100;
first = false;
nhidden = 2;
norm1 = true;
tmax = 1e4;
eta0 = 1;
alpha = [0.01 0.1 1 10 100];
nalphas = size(alpha,2);

finalMSEtrain = zeros([1,nalphas]);
finalMSEgen   = zeros([1,nalphas]);
reps = 10;

for i = 1:nalphas
  fprintf('doing alpha = %.2f \n',alpha(i));
  finalMSEt = 0;
  finalMSEg = 0;
  for rep = 1:reps
    fprintf('doing rep %g \n',rep);
    [MSEvec_train, MSEvec_gen,w] = main(P,Q,first,nhidden,norm1,tmax,eta0,alpha(i));
    finalMSEt = finalMSEt + MSEvec_train(end);
    finalMSEg = finalMSEg + MSEvec_gen(end);
    %{
    subplot(1,2,1);
    figure(i);
    plot_MSE(MSEvec_train,MSEvec_gen,tmax,P,Q,eta0,alpha(i));
    subplot(1,2,2);
    plot_w(w,nhidden);
    %}
  end
  finalMSEtrain(i) = finalMSEt/reps;
  finalMSEgen(i)   = finalMSEg/reps; 
end

figure('Position', [0 0 900 500]);
loglog(alpha,finalMSEtrain,'LineWidth',1.5,'Marker','x','MarkerSize',12,'MarkerEdgeColor','k','color','r','DisplayName',sprintf('training error (P = %g)', P));
hold on
loglog(alpha,finalMSEgen,'LineWidth',1.5,'Marker','x','MarkerSize',12,'MarkerEdgeColor','k','color','b','DisplayName',sprintf('test error (Q = %g)', Q));
xlabel('\alpha','FontSize',14);
xticks([alpha]);
ylabel('Mean square error by the end of training','FontSize',14);
title({'Final error after training with various learning rate schedules' sprintf('t_{max} = %g, %g repetitions',tmax,reps)},'FontSize',14); % ,'interpreter','latex'
grid on
lgd = legend;
lgd.FontSize = 12;