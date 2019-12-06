function [w,epoch] = rosenblatt_loop(vecs, labels, n_max)
%ROSENBLATT_LOOP Runs the Rosenblatt perceptron algorithm
%   Required parameters are the 'vecs' matrix of feature vectors and the
%   'labels' vector of the output labels in the format as outputted by the
%   generate function. n_max refers to the maximum number of epochs.
%   Returns the obtained solution vector w and the number of epochs that
%   were used (n_max at most).
    
    sz = size(vecs);
    P = sz(1);
    N = sz(2);
    w = zeros([N 1]);  % Initial w(0) vector
    
    for epoch = 1:n_max
        cnt = 0;
        for mu = 1:P
            cur_sample = vecs(mu,:)';
            E = dot(w, cur_sample) * labels(mu);
            if E <= 0
                cnt = cnt + 1;
                w = w + (cur_sample * labels(mu))/P;
            end
        end
        if (cnt == 0)
            break;
        end
    end
    
end

