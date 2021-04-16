function Fnew = Apply_Gamma_Surf_Closed(F,Theta,Phi,gam)

Fnew(:,:,1) = interp2(Theta,Phi,F(:,:,1),gam(:,:,1),gam(:,:,2),'spline');
Fnew(:,:,2) = interp2(Theta,Phi,F(:,:,2),gam(:,:,1),gam(:,:,2),'spline');
Fnew(:,:,3) = interp2(Theta,Phi,F(:,:,3),gam(:,:,1),gam(:,:,2),'spline');