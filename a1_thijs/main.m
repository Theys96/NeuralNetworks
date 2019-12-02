function void = main
N      = 5;      % Number of dimensions
n_max  = 100;    % Maximum number of (outer) epochs in the Rosenblatt algorithm
augm   = false;  % We will disregard augmentation in all our experiments
n_D    = 100;   % Number of independently drawn random sets

P_max = 4*N;
alpha = zeros(P_max,1);    % Array to be filled with tested values of alpha
Q_ls  = zeros(P_max,1);    % Array to be filled with fraction of correctly separated data sets to vary of alpha
for P = 1:1:P_max          % Loop over P (number of data points)
  alpha(P) = P/N;
  succ_count = 0;                            % Counts number of correctly separated independent data sets
  for set = 1:n_D                            % Loop over data sets
    [vecs, labels] = generate(P, N, augm);   % Generate random dataset with random +- labels
                                             % Run the Rosenblatt algorithm
    [~, epoch]     = rosenblatt_loop(vecs, labels, n_max);
    if (epoch < n_max) % This means not all epochs were used up by the Rosenblatt algorithm
      succ_count = succ_count + 1;
    end
  end
  Q_ls(P) = succ_count/n_D;
  fsprintf("%d/%d", P, P_max);
end

scatter(alpha,Q_ls,'filled','MarkerFaceColor','#A2142F','DisplayName','N = 5')
grid on
xlabel('\alpha = P/N','FontSize',15);
ylabel('Q_{l.s.}','FontSize',15);
title( { '{\bf\fontsize{20} Q_{l.s.}(P,N)}', sprintf('n_{max} = %d, \tn_D = %d', n_max, n_D) },'FontWeight','Normal','FontSize',12);
lgd = legend;
lgd.FontSize = 12;
