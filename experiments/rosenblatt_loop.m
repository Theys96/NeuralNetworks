function [w,epoch,es] = rosenblatt_loop(vecs, labels, n_max)
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
    es = zeros([P 1]);     %embedding strengths
    epoch = 0;
    while 1
      wc = 0;   %well classified patterns count
      cnt = 0;
      for mu = 1:P
          cur_sample = vecs(mu,:)';
          E = dot(w, cur_sample) * labels(mu);
          if E <= 0    %might want to replace 0 with nonzero c
            cnt = cnt + 1;
            w = w + (cur_sample * labels(mu))/N;
            es(mu) = es(mu)+1 ;
          else
            wc = wc + 1;
          end
      end
      epoch = epoch +1;
      if (wc == P)
        %disp('Data has been correctly separated.')
        success = 1;
        break;
      end
      if (epoch == n_max)
        %disp('max epochs reached. RP could not converge.')
        break;
      end
    end
    es = es/sum(es); %rescale
    
end

