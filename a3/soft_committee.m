function sigma = soft_committee(w,input)
  sigma = 0;
  nhidden = size(w,1);
  for i = 1:nhidden
    sigma = sigma + tanh(dot(w(i,:),input));
  end
end