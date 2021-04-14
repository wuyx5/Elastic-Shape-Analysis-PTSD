function [C,U,S] = Covariance_PCA1(F,mu,Theta)

n = size(F,2);
d = size(F{1},1);
dtheta=(d*pi+pi-.02*pi)/(d^2+.02*d);
dphi=2*pi/(d);

C = zeros(51*51*3,51*51*3);

for i = 1:n
    V = F{i} - mu;
    for j = 1:size(V,3)
%         V1(:,:,j) = V(:,:,j).*sin(Theta)*dphi*dtheta;
        V1(:,:,j) = V(:,:,j).*sin(Theta)*dphi*dtheta;
    end
    V_vec1 = reshape(V1,51*51*3,1);
    V_vec = reshape(V,51*51*3,1);
    V_mult = V_vec1*V_vec';
    C = C + V_mult;
end

disp('PCA');
[U,S,~] = svd(C);

end