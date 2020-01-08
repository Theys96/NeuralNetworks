%Plot training & generalization errors vs training time
function void = plot_MSE(MSEvec_train,MSEvec_gen,tmax,P,Q,eta)
  tvec = 1:tmax;
  plot(tvec,MSEvec_train,'color','r','DisplayName',sprintf('training error P = %g \n',P));
  hold on
  plot(tvec,MSEvec_gen,'color','b','DisplayName',sprintf('test error Q = %g \n',Q));
  xlabel('t','FontSize',14);
  ylabel('MSE','FontSize',14);
  title({'Optimization with SGD' sprintf('\\eta = %.2f',eta)},'FontSize',14);
  lgd = legend;
  lgd.FontSize = 12;
  grid on
end