%Learning by gradient descent
function [MSEvec_train, MSEvec_gen, w] = main(P,Q,first,nhidden,norm1,tmax,eta,alpha)

%Obtain data set. Split in training set & test set
%P = 100; %n� of training vectors 
%Q = 100; %n� of testing vectors

%call a function(P,Q) that returns the split data set
%first = true; %if true, select first 1, ..., P vectors as training set 
               %          and subsequent P+1, ..., Q as test set
               %else, pick data randomly 
[train,test,train_labels,test_labels,dim] = train_test_split('data3.mat',P,Q,first);

%Initialize input-to-hidden weights
%nhidden = 2;  %number of hidden units
%norm1 = true; %if true, each input-to-hidden independent weight vector is normalized at 1
w = init_weights(nhidden,dim,norm1);

%set tmax
%tmax = 1000; %n� of iterations in terms of P single step updates;
              %the actual number of steps is therefore tmax * P
tvec = 1:tmax;

MSEvec_train = zeros([1,tmax]); %to store in-training error
MSEvec_gen = zeros([1,tmax]);   %to store generalization error
           
%Training routine. Each "epoch" consists of P single steps; 
%vectors are presented randomly within the training set (SGD)
for t = tvec
  
  if exist('alpha','var') %eta(t) schedule
    if t == 1
      eta0 = eta;
    end
    eta = eta0/(t+alpha)
  end
  
  for pattern = 1:P %extract P random examples within the training set
                    %Note: this way the same example might be
                    %presented more than once
    k = randi(P);
    input = train(:,k);
    tau = train_labels(k);
    ss_error = evaluate_error(w,input,tau); %single step "mean squared" error
    for hidden = 1:nhidden %update weights with gradient descent step.
                           %all hidden neurons are updated based on the
                           %current single step error
      grad = evaluate_gradient(hidden,w,input,tau);
      w(hidden,:) = w(hidden,:) - eta*grad*ss_error;
    end
  end
  %save MSE at current training time for both training and test sets
  MSEvec_train(t) = evaluate_MSE(train,train_labels,w);
  MSEvec_gen(t)   = evaluate_MSE(test,test_labels,w);
end
end