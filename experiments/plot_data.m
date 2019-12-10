function void = plot_data(vecs, labels, w)
%PLOT_DATA Plots given data vectors if they are 2-dimensional with given
%labels.
	sz = size(vecs);
    if (sz(2) > 3) || (sz(2) < 2)
        error("plot_data only works for (augmented) 2-dimensional vectors.");
    end
    
    % Plotting of the data points
    scatter(vecs(labels == 1, 1), vecs(labels == 1, 2), 50, 'k', 'filled');
    xlim([-3 3])
    ylim([-3 3])
    hold on
    scatter(vecs(labels == -1, 1), vecs(labels == -1, 2), 50, 'k');
    
    % Plotting of the solution vector
    if exist('w','var')
        theta = 0;
        if sz(2) == 3
            theta = w(3);
        end
    
        ax = gca;
        x = [ax.XLim(1) ax.XLim(2)];
        y = (theta-w(1)*x)/w(2);
        plot(x,y);
    end
    
    hold off
end

