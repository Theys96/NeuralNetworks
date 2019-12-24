function grad = evaluate_gradient(hidden,w,input,tau)
   %analytically compute gradient of the error function with respect of the
   %given weight vector (i.e. hidden neuron)
   sigma = soft_committee(w,input);
   diff = sigma - tau;
   grad = input'*(sech(dot(w(hidden,:),input)))^2 * diff;
end