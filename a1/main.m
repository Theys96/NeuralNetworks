function void = main
N      = 5;
%P      = 10;
n_max  = 100;
augm   = true;
n_D    = 100; %number of independently drawn random sets
%alpha  = P/N;
 
alphav = [];         %array to be filled with tested values of alpha
succv = [];          %array to be filled with fraction of correctly separated data sets to vary of alpha
for P = 2:(N/5):(4*N)    %loop over P
  alpha = P/N;
  alphav = [alphav alpha];
  succ_count = 0;                          %counts number of correctly separated independent data sets
  for set = 1:n_D            %loop over data sets
    [vecs, labels] = generate(P, N, augm); %generate random dataset with random +- labels
    w = zeros([(N+augm) 1]); %initialize weigths
    epoch = 0;               %counts n° of sweeps through all patterns
    while 1                  %loop over epochs
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
      if wc == P %quit current data classification as it has been separated correctly
        %disp('success!')
        succ_count = succ_count+1;
        break
      end
      if epoch == n_max %quit current data classification as maximum number of epochs has been reached
        %disp('max epoch was reached. Could not separate data')
        break
      end
    end
    %w
    %plot_data(vecs, labels, w);
  end
  disp(['fraction of successes for alpha = ',num2str(alpha),': '])
  succ_rate = succ_count/n_D
  succv = [succv succ_rate];
end

plot(alphav,succv,'DisplayName','N = 5')
grid on
xlabel('\alpha','FontSize',13);
ylabel('P_{l.s.}','FontSize',13);
title('P_{l.s.}(P,N)','FontSize',15);
lgd = legend;
lgd.FontSize = 12;
