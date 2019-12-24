function MSE = evaluate_MSE(data,labels,w)
  nsamples = size(data,2);
  MSE = 0;
  for i = 1:nsamples
   input = data(:,i);
   tau = labels(i);
   ss_error = evaluate_error(w,input,tau);
   MSE = MSE + ss_error;
  end
  MSE = MSE/nsamples;
end