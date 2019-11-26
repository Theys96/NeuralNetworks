function void = plot_data(vecs, labels)
%PLOT_DATA Plots given data vectors if they are 2-dimensional with given
%labels.
	sz = size(vecs);
    if sz ~= 2
        error("plot_data only works for 2-dimensional vectors.");
    end
    scatter(vecs(labels == 1, 1), vecs(labels == 1, 2), 50, 'k', 'filled');
    hold on
    scatter(vecs(labels == -1, 1), vecs(labels == -1, 2), 50, 'k');
    hold off
end

