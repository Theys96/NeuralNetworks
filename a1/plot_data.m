function void = plot_data(vecs, labels, w)
%PLOT_DATA Plots given data vectors if they are 2-dimensional with given
%labels.
	sz = size(vecs);
    if (sz(2) > 3) || (sz(2) < 2)
        error("plot_data only works for (augmented) 2-dimensional vectors.");
    end
    scatter(vecs(labels == 1, 1), vecs(labels == 1, 2), 50, 'k', 'filled');
    grid on
    hold on
    scatter(vecs(labels == -1, 1), vecs(labels == -1, 2), 50, 'k');
    ax = gca;
    x = [ax.XLim(1) ax.XLim(2)];
    db = (w(3)-w(1)*x)/w(2);
    plot(x,db,'color','r','LineWidth',3)
    quiver(0,w(3)/w(2),w(1),w(2),'color','b')
    axis equal
    hold off
end

