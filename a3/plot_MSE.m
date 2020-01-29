%Plot training & generalization errors vs training time
function void = plot_MSE(MSEvec_train,MSEvec_gen,tmax,P,Q,eta,alpha)
  tvec = 1:tmax;
  plot(tvec,MSEvec_train,'LineWidth',2.5,'color','r','DisplayName',sprintf('training error (P = %g)\n',P));
  hold on
  plot(tvec,MSEvec_gen,'LineWidth',2.5,'color','b','DisplayName',sprintf('test error (Q = %g)\n',Q));
  xlabel('t (epochs)','FontSize',14);
  ylabel('mean square error','FontSize',14);
  set(gca,'Xscale','log')
  %set(gca,'Yscale','log')
  if exist('alpha','var')
    title({'Error optimization with stochastic gradient descent' sprintf('\\eta = \\eta_{0}/(t+%.1f)',alpha)},'FontSize',14);
  else
    title({'Error optimization with stochastic gradient descent' sprintf('\\eta = %.2f',eta)},'FontSize',14);
  end
  lgd = legend;
  lgd.FontSize = 12;
  grid on
end