function main
tic
Ns     = [2 10 20 100];    % Number of dimensions
n_maxs = [100 1000 10000];  % Maximum number of (outer) epochs in the Rosenblatt algorithm
augm   = false;  % We will disregard augmentation in all our experiments
n_D    = 1000;    % Number of independently drawn random sets

results = zeros(length(Ns), length(n_maxs));
i_N = 1;
for N = Ns
    fprintf("N = %d\n", N);
    
    step  = 0.5*N;
    P_min = 1.5*N; 
    P_max = 2.5*N;
    
    i_nm = 1;
    for n_max = n_maxs
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
        results(i_N, i_nm) = 1 - mean(arrQ_ls ./ arrP_ls);
        
        i_nm = i_nm + 1;
    end
    i_N = i_N + 1;
end

t = toc

bar(results)
ax=gca;
ax.XTickLabel=Ns;
title({'{\bf\fontsize{20} Systematic bias of Q_{ls} compared to P_{ls}}', sprintf('P in [1.5N, 2N, 2.5N], n_D = %d', n_D)},'FontWeight','Normal','FontSize',12);
ylabel('mean of 1-(Q_{ls} / P_{ls})','Interpreter','tex','FontSize',15)
xlabel('N','FontSize',15)

i = 1;
leg_labels = strings(numel(n_maxs));
for n_max = n_maxs
    leg_labels(i) = sprintf("n_{max} = %d", n_max);
    i = i + 1;
end 
legend(leg_labels, 'Location', 'northwest')
