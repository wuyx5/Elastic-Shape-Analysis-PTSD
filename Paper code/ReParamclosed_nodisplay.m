function [Fnew,H,gamp,iter1] = ReParamclosed_nodisplay(f1,f2new,A_tmp21,A_tmp22new,b,gamp,gamid,Theta,Phi,Psi,iter1,itermax,eps)

% f1 = MakeClosedGrid(f1,30);
% f2 = MakeClosedGrid(f2,30);
[n,t,d]=size(f1);
% [Theta,Phi,Psi,b] = spherharmbasis(2,n);

% gamn = formdiffeosph(.25,0,n);
% f2 = FormClosedSurf(Theta,Phi,3);
% % [tmp,gamn] = MakeDiffeo_Closed(0.6,n,0,b);
% f1 = Apply_Gamma_Surf_Closed(f2,Theta,Phi,gamn);
% f1 = FormClosedSurf(Theta,Phi,0);
% f1(:,:,1)=f2(:,:,2);
% f1(:,:,2)=f2(:,:,1);
% f1(:,:,3)=f2(:,:,3);
% DisplayGrid(gamn,gamid,97);

% gamid = MakeDiffeo_Closed(0,n,0,b);

% [f1,f2new,Hstart]= findoptimalparamet(f1,f2,Theta,Phi);

% DisplaySurfaceClosed(f1,Theta,1);

% [A1,A_tmp11,A_tmp21] = area_surf_closed(f1);
q1 = surface_to_q(f1,A_tmp21);
% DisplaySurfaceClosed(f2new,Theta,2);
% [A2new,A_tmp12new,A_tmp22new] = area_surf_closed(f2);
q2 = surface_to_q(f2new,A_tmp22new);

H(1)=Calculate_Distance_Closed(q1,q2,Theta);

Fnew=f2new;
iter=1;
Hdiff = 100;

while (iter<itermax && Hdiff>0.000004)
% while (iter<itermax)

% Find phistar

w = findphistarclosed(q2,Psi,b,Theta);

% Find Vector to Project

for j=1:size(q1,3)
    v(:,:,j) = q1(:,:,j)-q2(:,:,j);
end

% Find Update for Gamma

gamupdate = findupdategamclosed(v,w,b,Theta);

% figure(99),quiver(Phi,Theta,gamupdate(:,:,2),gamupdate(:,:,1));

% eps = linesearch( .1, gamupdate,n,q1,Fnew,b );

gamnew = updategam(gamupdate,gamid,eps);

gamp = Apply_gam_gamid_closed(gamp,gamnew,n);

% Update Curve

Fnew = Apply_Gamma_Surf_Closed(Fnew,Theta,Phi,gamnew);

iter

for j=1:3
    Fnew(1,:,j)=Fnew(end,:,j);
end

[Anew,multfactnew,sqrtmultfactnew] = area_surf_closed(Fnew);
q2 = surface_to_q(Fnew,sqrtmultfactnew);

iter = iter+1;
iter1 = iter1+1;

%Calculate Distance

H(iter) = Calculate_Distance_Closed(q1,q2,Theta);

if (iter>1)
    if (H(iter)>H(iter-1))
        sprintf('ERROR: The step size is too large')
        break;
    end
end

if (iter>2)
    Hdiff = (H(iter-2)-H(iter-1))/H(iter-2);
end
end

% keyboard;