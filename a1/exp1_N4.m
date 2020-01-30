% Global parameters
N      = 4;     % Number of dimensions
augm   = false;  % We will disregard augmentation in all our experiments


% Part 1
n_max  = 1000;    % Maximum number of (outer) epochs in the Rosenblatt algorithm
n_D    = 500;     % Number of independently drawn random sets
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
  fprintf("%.2f/%.2f\n", P/N, P_max/N);
  i = i + 1;
end

figure('Renderer', 'painters', 'Position', [0 0 650 450])
stairs(arrAlpha,arrP_ls,'DisplayName',sprintf('P_{ls}(P,%d)', N),'Color', 'k','LineWidth',1.5);
hold on
scatter(arrAlpha,arrQ_ls,100,'r','x','LineWidth',1.5,'DisplayName',sprintf('Q_{ls}(P,%d), n_{max} = %d, n_D = %d', N, n_max, n_D));

% Plot
grid on
xlim([0 4]);
xlabel('\alpha = P/N','FontSize',15);
title( { '{\bf\fontsize{20} Comparison of Q_{ls}(P,N) and P_{ls}(P,N)}', sprintf('N = %d', N) },'FontWeight','Normal','FontSize',12);
lgd = legend;
lgd.FontSize = 12;
