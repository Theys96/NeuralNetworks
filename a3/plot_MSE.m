%Plot training & generalization errors vs training time
function void = plot_MSE(MSEvec_train,MSEvec_gen,tmax,P,Q,eta,log,alpha)
  tvec = 1:tmax;
  if log == false
    plot(tvec,MSEvec_train,'LineWidth',2.5,'color','r','DisplayName',sprintf('training error P = %g \n',P));
    hold on
    plot(tvec,MSEvec_gen,'LineWidth',2.5,'color','b','DisplayName',sprintf('test error Q = %g \n',Q));
  elseif log == true
    semilogx(tvec,MSEvec_train,'LineWidth',2.5,'color','r','DisplayName',sprintf('training error P = %g \n',P));
    hold on
    semilogx(tvec,MSEvec_gen,'LineWidth',2.5,'color','b','DisplayName',sprintf('test error Q = %g \n',Q));  
  end
  xlabel('t','FontSize',14);
  ylabel('MSE','FontSize',14);
  if exist('alpha','var')
    title({'Optimization with SGD' sprintf('\\eta = \\eta_{0}/(t+%.1f)',alpha)},'FontSize',14);
  else
    title({'Optimization with SGD' sprintf('\\eta = %.2f',eta)},'FontSize',14);
  end
  lgd = legend;
  lgd.FontSize = 12;
  grid on
end