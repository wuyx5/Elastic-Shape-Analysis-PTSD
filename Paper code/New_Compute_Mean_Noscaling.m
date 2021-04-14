function [mu,mu_m,dist_m,dist_sum,Fnew,mu0] = New_Compute_Mean_Noscaling(F,itermax,eps,Theta,Phi,Psi,b)
   
n = size(F,2);

for i = 1:n
    F{i} = center_and_normscale(F{i},Theta);
end

iter = 1;
% mu0 = randi([1,n],1);
% Puta mu0 = 33;
mu0 = 17;
mu_m{iter} = F{mu0};
mudiff = 10;
Fnew = F;

while (iter<=itermax && abs(mudiff)>0.05)
% while (iter<itermax)

    for i = 1:n
        [~, Fnew{i}, ~] = Align_and_rotation(mu_m{iter},Fnew{i},eps,Theta,Phi,Psi,b);
        Fnew{i} = center_and_rescale(F{i},Fnew{i},Theta);
        q = Test_surface_to_q(Fnew{i});
        dist_m(iter,i) = Calculate_Distance_Closed(q,Test_surface_to_q(mu_m{iter}),Theta);
    end
    dist_sum(iter) = sum(dist_m(iter,:)); 
      
    F_flat = cat(4,Fnew{:});
    mu_m{iter+1} = mean(F_flat,4);

    if iter > 2
        dist1 = Calculate_Distance_Closed(Test_surface_to_q(mu_m{iter}),Test_surface_to_q(mu_m{iter+1}),Theta);
        dist2 = Calculate_Distance_Closed(Test_surface_to_q(mu_m{iter-1}),Test_surface_to_q(mu_m{iter}),Theta);
        mudiff = (dist2-dist1)/dist1;
    end
    iter = iter+1;
    disp(['***************' num2str(iter) ' ' num2str(mudiff) '********************']);
    disp(['***************' num2str(iter) ' ' num2str(mudiff) '********************']);
    disp(['***************' num2str(iter) ' ' num2str(mudiff) '********************']);
end

for i = 1:n
    [~, Fnew{i}, ~] = Align_and_rotation(mu_m{iter},Fnew{i},eps,Theta,Phi,Psi,b);
    Fnew{i} = center_and_rescale(F{i},Fnew{i},Theta);
    q = Test_surface_to_q(Fnew{i});
    dist_m(iter,i) = Calculate_Distance_Closed(q,Test_surface_to_q(mu_m{iter}),Theta);
end
dist_sum(iter) = sum(dist_m(iter,:));

mu = mu_m{iter};


