function void = plot_data(vecs, labels, w)
%PLOT_DATA Plots given data vectors if they are 2-dimensional with given
%labels.
	sz = size(vecs);
    if (sz(2) > 3) || (sz(2) < 2)
        error("plot_data only works for (augmented) 2-dimensional vectors.");
    end
    scatter(vecs(labels == 1, 1), vecs(labels == 1, 2), 50, 'k', 'filled');
    hold on
    scatter(vecs(labels == -1, 1), vecs(labels == -1, 2), 50, 'k');
    
    if exist('w','var')
        if sz(2) == 3
            st = w/norm(w)*w(3);
        else
            st = [0 0];
        end
        l1 = [0 -1; 1 0]*w(1:2);
        l2 = -l1;
        plot([0 st(1)], [0 st(2)])
        plot([l1(1)+st(1) l2(1)+st(1)], [l1(2)+st(2) l2(2)+st(2)]);
    end
    
    hold off
end

