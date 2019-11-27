function void = main
    N      = 2;
    P      = 15;
    n_max  = 100;
    augm   = false;
    
    % rng('default');
    for i = 1:10000
        [vecs, labels] = generate(P, N, augm);
        [w, epoch]     = rosenblatt_loop(vecs, labels, n_max);
        
        if epoch < n_max
            fprintf('Finished after %d/%d epochs.\n', epoch, n_max);
            disp('Solution vector:');
            disp(w);
            plot_data(vecs, labels, w);
            break;
        end
    end
end
