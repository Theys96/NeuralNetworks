function frac = P_ls(P,N)
%P_LS Computes the fraction of linearly seperable dichotomies for a P sized
%data set in N dimensions analytically
    if (P <= N)
        frac = 1;
    else
        sum = 0;
        for i = 0:(N-1)
            sum = sum + nchoosek(P-1, i);
        end
        frac = 2^(1-P) * sum;
    end
end

