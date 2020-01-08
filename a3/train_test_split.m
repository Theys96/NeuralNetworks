function [train,test,train_labels,test_labels,dim] = train_test_split(filename,P,Q,first)
  if mod(P,1)~=0 || mod(Q,1)~=0
    error('both P and Q must be integers!');
  end
  data = load(filename);
  labels = data.tau;
  data = data.xi;
  dim = size(data,1);
  nsamples = size(data,2);
  if first == true
    train = data(:,1:P);
    test = data(:,P+1:P+Q);
    train_labels = labels(1:P);
    test_labels = labels(P+1:P+Q);
  else
    rdm_indices = randperm(nsamples,P+Q);
    train = data(:,rdm_indices(1:P));
    test = data(:,rdm_indices(P+1:P+Q));
    train_labels = labels(rdm_indices(1:P));
    test_labels = labels(rdm_indices(P+1:P+Q));
  end
end