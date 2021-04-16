function [f2new,A_tmp22new,idx,O]=findoptimalparametproc_addrotation(f1,f2,Theta,Phi)

[n,t,d]=size(f2);
O=DodecaElements;
% O=Test_Icosa;
% sigma = 1.5;
% for i = 1:150
%     w1 = normrnd(0,sigma); w2 = normrnd(0,sigma); w3 = normrnd(0,sigma);
%     E{i} = [0 -w1 w2; w1 0 w3; -w2 -w3 0];
%     O{i} = expm(E{i});
% end
% load('O72.mat','O');

[A1,A_tmp11,A_tmp21] = area_surf_closed(f1);
q1 = surface_to_q(f1,A_tmp21);

for k=1:size(O,2)
    for i=1:n
        for j=1:n
            [x(1),x(2),x(3)]=spherical_to_cart(Theta(i,j),Phi(i,j),1);
            y=O{k}*x';
            [Thetan(i,j,k),Phin(i,j,k),tmp]=cartesian_to_sph(y(1),y(2),y(3));
            if (Phin(i,j,k)<0)
                Phin(i,j,k)=Phin(i,j,k)+2*pi;
            end
        end
    end
    Thetan(:,:,k)=min(max(0,Thetan(:,:,k)),pi);
    Phin(:,:,k)=min(max(0,Phin(:,:,k)),2*pi);
end

% sigma = 2;
% for k=1:60
%     w1 = normrnd(0,sigma); w2 = normrnd(0,sigma); w3 = normrnd(0,sigma);
%     E = [0 -w1 w2; w1 0 w3; -w2 -w3 0];
%     SO{k} = expm(E);
%     for i=1:n
%         for j=1:n
%             f2n{k}(i,j,:)=SO{k}*squeeze(f2(i,j,:));
%         end
%     end
%     [A2n{k},A_tmp12n{k},A_tmp22n{k}] = area_surf_closed(f2n{k});
%     q2n{k} = surface_to_q(f2n{k},A_tmp22n{k});
%     distparam(k)=Calculate_Distance_Closed(q1,q2n{k},Theta);
% end
% 
% [tmp,idx]=min(distparam);
% f2=f2n{idx};

for k=1:size(O,2)
    gamnew{k}(:,:,1)=Thetan(:,:,k);
    gamnew{k}(:,:,2)=Phin(:,:,k);
    f2n{k}=Apply_Gamma_Surf_Closed(f2,Theta,Phi,gamnew{k});
    for i=1:n
        for j=1:n
            f2n{k}(i,j,:)=O{k}'*squeeze(f2n{k}(i,j,:));
        end
    end
    [A2n{k},A_tmp12n{k},A_tmp22n{k}] = area_surf_closed(f2n{k});
    q2n{k} = surface_to_q(f2n{k},A_tmp22n{k});
    distparam(k)=Calculate_Distance_Closed(q1,q2n{k},Theta);
end

[tmp,idx]=min(distparam);
H=distparam(idx);
f2new=f2n{idx};
A_tmp22new=A_tmp22n{idx};
