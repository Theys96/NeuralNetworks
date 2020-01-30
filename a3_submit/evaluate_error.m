function ss_error = evaluate_error(w,input,tau)
  sigma = soft_committee(w,input);
  ss_error = 0.5 * (sigma - tau)^2;
end