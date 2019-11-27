function void = main
N      = 5;
P      = 10;
n_max  = 100;
augm   = true;
n_D    = 100;
alpha  = P/N;
    
% rng('default');
succ_count = 0;                   %counts number of correctly separated independent data sets
for set = 1:n_D
  [vecs, labels] = generate(P, N, augm);    
  w = zeros([(N+augm) 1]);
  epoch = 0;
  while 1
    wc = 0;                        %well classified patterns counter 
    for mu = 1:P                   %loop over patterns
      cur_sample = vecs(mu,:)';
      E = dot(w, cur_sample) * labels(mu);
      if E <= 0                  %learn occurs iff pattern is misclassified
        w = w + (cur_sample/N * labels(mu));
      else
        wc = wc+1;
      end
    end
    epoch = epoch + 1;
    if wc == P
      %disp('success!')
      succ_count = succ_count+1;
      break
    end
    if epoch == n_max
      %disp('max epoch was reached. Could not separate data')
      break
    end
  end
  %w
  %plot_data(vecs, labels, w);
end
disp(['fraction of successes for alpha = ',num2str(alpha),': '])
disp(succ_count/n_D)
end
