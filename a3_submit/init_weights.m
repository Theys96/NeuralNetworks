function w = init_weights(nhidden,dim,norm1)
  w = rand([nhidden,dim]);
  if norm1 == true
    for i = 1:nhidden
      wnorm = norm(w(i,:));
      w(i,:) = w(i,:)/wnorm;
    end
  end  
end