tic
Ns     = [2 10 20 100];      % Number of dimensions
n_maxs = [100 1000 10000];   % Maximum number of (outer) epochs in the Rosenblatt algorithm
augm   = false;              % We will disregard augmentation in all our experiments
n_D    = 10;               % Number of independently drawn random sets

results = zeros(length(Ns), length(n_maxs));
i_N = 1;
for N = Ns
    
    i_nm = 1;
    for n_max = n_maxs
        
        fprintf("N = %d, n_max = %d\n", N, n_max);
        [vQ_ls,~] = Q_ls(N*2, N, augm, n_max, n_D);
        vP_ls     = P_ls(N*2, N);
        results(i_N, i_nm) = 1 - vQ_ls / vP_ls;
        
        i_nm = i_nm + 1;
    end
    i_N = i_N + 1;
end

t = toc

figure('Renderer', 'painters', 'Position', [0 0 650 450])
bar(results)
ax=gca;
ax.XTickLabel=Ns;
ylim([-.1 1.0]);
yticks([-.1 0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1])
title({'{\bf\fontsize{20} Systematic discrepancy between Q_{ls} and P_{ls}}', sprintf('P = 2N, n_D = %d, computation time: %.2fs', n_D, t)},'FontWeight','Normal','FontSize',12);
ylabel('1-(Q_{ls} / P_{ls})','Interpreter','tex','FontSize',15)
xlabel('N','FontSize',15)

i = 1;
leg_labels = strings(numel(n_maxs));
for n_max = n_maxs
    leg_labels(i) = sprintf("n_{max} = 10^{%d}", log10(n_max));
    i = i + 1;
end 
legend(leg_labels, 'Location', 'northwest')
