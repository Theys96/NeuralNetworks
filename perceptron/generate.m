function [vecs, labels] = generate(P,N)
%GENERATE Generates a random data set of P vectors in N dimensions, 0 mean
%and 1 variance
    vecs = normrnd(0,1,[P N]);
    labels = sign(normrnd(0,1,[P 1]));
end

