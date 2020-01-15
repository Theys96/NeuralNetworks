% Global parameters
N      = 20;     % Number of dimensions
augm   = false;  % We will disregard augmentation in all our experiments


% Part 1
n_max  = 100;    % Maximum number of (outer) epochs in the Rosenblatt algorithm
n_D    = 50;    % Number of independently drawn random sets
P_max = 4*N;
step  = N/4;
arrAlpha = zeros(P_max/step,1);    % Array to be filled with tested values of alpha
arrQ_ls  = zeros(P_max/step,1);    % Array to be filled with fraction of correctly separated data sets to vary of alpha
arrP_ls  = zeros(P_max/step,1);    % Array to be filled with probabilities
i     = 1;                         % Array iterator
for P = step:step:P_max            % Loop over P (number of data points)
  arrAlpha(i) = P/N;
  arrQ_ls(i) = Q_ls(P, N, augm, n_max, n_D);
  arrP_ls(i) = P_ls(P, N);
  fprintf("%.2f/%d\n", P/N, 4);
  i = i + 1;
end
figure(1)
stairs(arrAlpha,arrP_ls,'DisplayName',sprintf('P_{l.s.}(P,%d)', N),'Color', 'r','LineWidth',1.5);
hold on
scatter(arrAlpha,arrQ_ls,50,'o','filled','DisplayName',sprintf('Q_{l.s.}(P,%d), n_{max} = %d, n_D = %d', N, n_max, n_D));


% Part 2
n_max  = 1000;   % Maximum number of (outer) epochs in the Rosenblatt algorithm
n_D    = 500;    % Number of independently drawn random sets
arrAlpha = zeros(P_max/step,1);    % Reinitialize
arrQ_ls  = zeros(P_max/step,1);    % Reinitialize
arrP_ls  = zeros(P_max/step,1);    % Reinitialize
i     = 1;                         % Array iterator
for P = step:step:P_max            % Loop over P (number of data points)
  arrAlpha(i) = P/N;
  arrQ_ls(i) = Q_ls(P, N, augm, n_max, n_D);
  arrP_ls(i) = P_ls(P, N);
  fprintf("%.2f/%d\n", P/N, 4);
  i = i + 1;
end
scatter(arrAlpha,arrQ_ls,50,'o','filled','DisplayName',sprintf('Q_{l.s.}(P,%d), n_{max} = %d, n_D = %d', N, n_max, n_D));


% Plot
grid on
xlabel('\alpha = P/N','FontSize',15);
title( { '{\bf\fontsize{20} Q_{l.s.}(P,N) vs. P_{l.s.}(P,N)}', '' },'FontWeight','Normal','FontSize',12);
lgd = legend;
lgd.FontSize = 12;
