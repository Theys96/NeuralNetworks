%Display the weight vectors upon completion of training
function void = plot_w(w,nhidden)
  for hidden = 1:nhidden
    bar(w(hidden,:),'DisplayName',sprintf('w_{%g}',hidden));
    hold on
  end
  grid on
  xlabel('component','FontSize',14);
  ylabel('hidden neuron weight','FontSize',14);
  title('Bar visualization of weight vectors','FontSize',13);
  lgd = legend;
  lgd.FontSize = 12;
end