function void = main
N      = 5;      % Number of dimensions
n_max  = 2000;   % Maximum number of (outer) epochs in the Rosenblatt algorithm
augm   = false;  % We will disregard augmentation in all our experiments
n_D    = 500;    % Number of independently drawn random sets

P_max = 4*N;
step  = 1;
arrAlpha = zeros(P_max/step,1);    % Array to be filled with tested values of alpha
arrQ_ls  = zeros(P_max/step,3);    % Array to be filled with fraction of correctly separated data sets to vary of alpha
arrP_ls  = zeros(P_max/step,1);    % Array to be filled with probabilities
i     = 1;                         % Array iterator
for P = step:step:P_max            % Loop over P (number of data points)
  arrAlpha(i) = P/N;
  arrQ_ls(i,1) = Q_ls(P, N, augm, n_max, 10);
  arrQ_ls(i,2) = Q_ls(P, N, augm, n_max, 100);
  arrQ_ls(i,3) = Q_ls(P, N, augm, n_max, 1000);
  arrP_ls(i) = P_ls(P, N);
  fprintf("%.2f/%d\n", P/N, 4);
  i = i + 1;
end

stairs(arrAlpha,arrP_ls,'DisplayName',sprintf('P_{l.s.}(P,%d)', N),'Color', '#A2142F','LineWidth',1.5);
hold on

scatter(arrAlpha,arrQ_ls(:,1),50,'o','MarkerEdgeColor','#00315E','DisplayName',sprintf('Q_{l.s.}(P,%d), n_d = %d', N, 10));
scatter(arrAlpha,arrQ_ls(:,2),50,'s','MarkerEdgeColor','#00315E','DisplayName',sprintf('Q_{l.s.}(P,%d), n_d = %d', N, 100));
scatter(arrAlpha,arrQ_ls(:,3),50,'x','MarkerEdgeColor','#00315E','DisplayName',sprintf('Q_{l.s.}(P,%d), n_d = %d', N, 1000));
%scatter(arrAlpha,arrQ_ls(:,1),50,'filled','MarkerFaceColor','#00315E','DisplayName',sprintf('Q_{l.s.}(P,%d)', N));
%stairs(arrAlpha,arrQ_ls,'DisplayName',sprintf('Q_{l.s.}(P,%d)', N),'Color',	'#00315E','LineWidth',1.5);

grid on
xlabel('\alpha = P/N','FontSize',15);
%ylabel('Q_{l.s.}','FontSize',15);
%title( { '{\bf\fontsize{20} Q_{l.s.}(P,N) vs. P_{l.s.}(P,N)}', sprintf('n_{max} = %d, \tn_D = %d', n_max, n_D) },'FontWeight','Normal','FontSize',12);
title( { '{\bf\fontsize{20} Q_{l.s.}(P,N) vs. P_{l.s.}(P,N)}', sprintf('n_{max} = %d', n_max) },'FontWeight','Normal','FontSize',12);
lgd = legend;
lgd.FontSize = 12;
