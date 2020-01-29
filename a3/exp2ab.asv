%compare 2a and 2b

clear all 

P = 250;
Q = 100;
first = false;
nhidden = 2;
norm1 = true;

N = 4;
finalMSEtrain = zeros([1,N]);
finalMSEgen   = zeros([1,N]);

eta = [0.05, 0.05, 1.0, 1.0];
tmax = [1e4, 1e6, 1e4, 1e6];
alpha = 10;
reps = 5;

for i = 1:N
  fprintf('doing %g th run \n',i);
  finalMSEt = 0;
  finalMSEg = 0;
  for rep = 1:reps
    fprintf('doing rep %g \n',rep);
    if i <= 2
      [MSEvec_train, MSEvec_gen,w] = main(P,Q,first,nhidden,norm1,tmax(i),eta(i));
    else
      [MSEvec_train, MSEvec_gen,w] = main(P,Q,first,nhidden,norm1,tmax(i),eta(i),alpha);
    end
    finalMSEt = finalMSEt + MSEvec_train(end);
    finalMSEg = finalMSEg + MSEvec_gen(end);
  end
  finalMSEtrain(i) = finalMSEt/reps;
  finalMSEgen(i)   = finalMSEg/reps; 
end

figure(N);
plot(1:N,finalMSEtrain,'LineWidth',2,'Marker','d','MarkerSize',12,'color','r','DisplayName','training error');
hold on
plot(1:N,finalMSEgen,'LineWidth',2,'Marker','d','MarkerSize',12,'color','b','DisplayName','test error');
xlabel('N','FontSize',14);
xticks([1:N]);
ylabel('MSE by the end of training','FontSize',14);
title('Final errors for different prescriptions','FontSize',13);
grid on
lgd = legend;
lgd.FontSize = 12;
