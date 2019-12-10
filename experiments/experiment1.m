function main
tic
N      = 100;    % Number of dimensions
n_max  = 10000;  % Maximum number of (outer) epochs in the Rosenblatt algorithm
augm   = false;  % We will disregard augmentation in all our experiments
n_D    = 500;    % Number of independently drawn random sets

step  = N/4;
P_min = 1.5*N; 
P_max = 2.5*N; 
arrAlpha = zeros((P_max-P_min)/step,1);    % Array to be filled with tested values of alpha
arrQ_ls  = zeros((P_max-P_min)/step,1);    % Array to be filled with fraction of correctly separated data sets to vary of alpha
arrP_ls  = zeros((P_max-P_min)/step,1);    % Array to be filled with probabilities
i     = 1;                         % Array iterator

for P = P_min:step:P_max            % Loop over P (number of data points)
  arrAlpha(i) = P/N;
  [arrQ_ls(i),embedding] = Q_ls(P, N, augm, n_max, n_D);
  arrP_ls(i) = P_ls(P, N);
  fprintf("%.2f/%d\n", P/N, 4);
  i = i + 1;
end

t = toc

figure(1)
stairs(arrAlpha,arrP_ls,'DisplayName',sprintf('P_{l.s.}(P,%d)', N),'Color', 'r','LineWidth',1.5);
hold on
scatter(arrAlpha,arrQ_ls,50,'o','filled','MarkerFaceColor','b','DisplayName',sprintf('Q_{l.s.}(P,%d)', N));

grid on
xlabel('\alpha = P/N','FontSize',15);
xlim([0 4]);
title( { '{\bf\fontsize{20} Q_{l.s.}(P,N) vs. P_{l.s.}(P,N)}', sprintf('n_{max} = %d, n_D = %d, computation time: %.3fs', n_max, n_D, t) },'FontWeight','Normal','FontSize',12);
lgd = legend;
lgd.FontSize = 12;
end
