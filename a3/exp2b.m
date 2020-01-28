%exp2b eta(t) schedule

clear all 

P = 500;
Q = 100;
first = false;
nhidden = 2;
norm1 = true;
tmax = 1e4;
eta0 = 1;
alpha = [0.01 0.1 1 10 100 500];
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
    plot_MSE(MSEvec_train,MSEvec_gen,tmax,P,Q,eta0,false,alpha(i));
    subplot(1,2,2);
    plot_w(w,nhidden);
    %}
  end
  finalMSEtrain(i) = finalMSEt/reps;
  finalMSEgen(i)   = finalMSEg/reps;
end

figure(nalphas+1);
loglog(alpha,finalMSEtrain,'LineWidth',2,'Marker','d','MarkerSize',12,'color','r','DisplayName','training error');
hold on
loglog(alpha,finalMSEgen,'LineWidth',2,'Marker','d','MarkerSize',12,'color','b','DisplayName','test error');
xlabel('\alpha','FontSize',14);
xticks([alpha]);
ylabel('MSE by the end of training','FontSize',14);
title({'Final error with $\eta(t) = \frac{1}{\alpha + t}$' sprintf('tmax = %g, P = %g, reps = %g',tmax,P,reps)},'FontSize',14,'interpreter','latex');
grid on
lgd = legend;
lgd.FontSize = 12;