function void = main
    N      = 2;
    P      = 4;
    n_max  = 100;
    augm   = true;
    
    % rng('default');
    [vecs, labels] = generate(P, N, augm);
    
    w = zeros([(N+augm) 1]);
    mu = 1;
    epoch = 1;
    for sweep = 1:n_max
        for mu = 1:P
            cur_sample = vecs(mu,:)';
            E = dot(w, cur_sample) * labels(mu);
            if E <= 0
                w = w + (cur_sample/N * labels(mu));
            end
            epoch = epoch + 1;
        end
    end
    
    w
    plot_data(vecs, labels, w);
end
