function [frac,embedding] = Q_ls(P, N, augm, n_max, n_D)
%Q_LS Computes the fraction of fraction of linearly seperable dichotomies for a P sized
%data set in N dimensions by simulation
  succ_count = 0;                            % Counts number of correctly separated independent data sets
  embedding = [];
  for set = 1:n_D                            % Loop over data sets
    [vecs, labels] = generate(P, N, augm);   % Generate random dataset with random +- labels
                                             % Run the Rosenblatt algorithm
    [~, epoch, es] = rosenblatt_loop(vecs, labels, n_max);
    if (epoch < n_max) % This means not all epochs were used up by the Rosenblatt algorithm
      succ_count = succ_count + 1;
      embedding = [embedding es];
    end
  end
  %embedding = embedding/P; %rescale
  embedding = reshape(embedding,[size(embedding,1)*size(embedding,2),1]);
  frac = succ_count/n_D;
  figure(P);
  histogram(embedding,10);
  title(sprintf('P = %u',P));
end

