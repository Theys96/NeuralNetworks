function void = main
N      = 5;      % Number of dimensions
n_max  = 500;    % Maximum number of (outer) epochs in the Rosenblatt algorithm
augm   = false;  % We will disregard augmentation in all our experiments
n_D    = 200;    % Number of independently drawn random sets

P_max = 4*N;
step  = 2;
arrAlpha = zeros(P_max/step,1);    % Array to be filled with tested values of alpha
arrQ_ls  = zeros(P_max/step,1);    % Array to be filled with fraction of correctly separated data sets to vary of alpha
arrP_ls  = zeros(P_max/step,1);    % Array to be filled with probabilities
i     = 1;                         % Array iterator
es = [];
for P = step:step:P_max            % Loop over P (number of data points)
  arrAlpha(i) = P/N;
  [arrQ_ls(i),embedding] = Q_ls(P, N, augm, n_max, n_D);
  es = [es; embedding];
  arrP_ls(i) = P_ls(P, N);
  fprintf("%.2f/%d\n", P/N, 4);
  i = i + 1;
end

figure(1)
stairs(arrAlpha,arrP_ls,'DisplayName',sprintf('P_{l.s.}(P,%d)', N),'Color', 'r','LineWidth',1.5);
hold on

scatter(arrAlpha,arrQ_ls,50,'o','filled','MarkerFaceColor','b','DisplayName',sprintf('Q_{l.s.}(P,%d)', N));
%stairs(arrAlpha,arrQ_ls,'DisplayName',sprintf('Q_{l.s.}(P,%d)', N),'Color',	'#00315E','LineWidth',1.5);

grid on
xlabel('\alpha = P/N','FontSize',15);
%ylabel('Q_{l.s.}','FontSize',15);
%title( { '{\bf\fontsize{20} Q_{l.s.}(P,N) vs. P_{l.s.}(P,N)}', sprintf('n_{max} = %d, \tn_D = %d', n_max, n_D) },'FontWeight','Normal','FontSize',12);
title( { '{\bf\fontsize{20} Q_{l.s.}(P,N) vs. P_{l.s.}(P,N)}', sprintf('n_{max} = %d, n_D = %d', n_max, n_D) },'FontWeight','Normal','FontSize',12);
lgd = legend;
lgd.FontSize = 12;

figure(2)
histogram(es,30);
%set(gca,'Yscale','log');
