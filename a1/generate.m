function [vecs, labels] = generate(P,N,augmented)
%GENERATE Generates a random data set of P vectors in N dimensions, 0 mean
%and 1 variance
% If augmented is true, the vectors are augmented with -1 as the last
% feature
    if augmented
        vecs = [normrnd(0,1,[P N]) repmat(-1,P,1)];
    else
        vecs = normrnd(0,1,[P N]);
    end
    labels = sign(normrnd(0,1,[P 1]));
end

