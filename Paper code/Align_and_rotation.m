function [F1,F2n,gamcum,idx,O] = Align_and_rotation(F1,F2,eps,Theta,Phi,Psi,b)
close all;

[n,t,d] = size(F1);
F1=MakeClosedGrid(F1,n);
F2=MakeClosedGrid(F2,n);

gamid = MakeDiffeo_Closed(0,n,0,b);

[A1,multfact1,sqrtmultfact1] = area_surf_closed(F1);
[A2,multfact2,sqrtmultfact2] = area_surf_closed(F2);

q1 = Test_surface_to_q(F1);
q2 = Test_surface_to_q(F2);

[F2n,sqrtmultfact2n,idx,O]=findoptimalparametproc_addrotation(F1,F2,Theta,Phi);

iter1=1;

tic;
[A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n);
q2n =  Test_surface_to_q(F2n);
[F2n,Ot] = ProcrustesAlignClosed_noscaling(q1,q2n,F1,F2n,sqrtmultfact1,sqrtmultfact2n,Theta);
[A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n);
iter1=iter1+1;
[F2n,H1,gamcum,iter1] = ReParamclosed_nodisplay(F1,F2n,sqrtmultfact1,sqrtmultfact2n,b,gamid,gamid,Theta,Phi,Psi,iter1,10,eps);

[A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n);
q2n = Test_surface_to_q(F2n);
[F2n,Ot] = ProcrustesAlignClosed_noscaling(q1,q2n,F1,F2n,sqrtmultfact1,sqrtmultfact2n,Theta);
[A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n);
[F2n,H2,gamcum,iter1] = ReParamclosed_nodisplay(F1,F2n,sqrtmultfact1,sqrtmultfact2n,b,gamcum,gamid,Theta,Phi,Psi,iter1+1,30,eps);

[A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n);
q2n = Test_surface_to_q(F2n);
[F2n,Ot] = ProcrustesAlignClosed_noscaling(q1,q2n,F1,F2n,sqrtmultfact1,sqrtmultfact2n,Theta);
[A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n);
[F2n,H3,gamcum,iter1] = ReParamclosed_nodisplay(F1,F2n,sqrtmultfact1,sqrtmultfact2n,b,gamcum,gamid,Theta,Phi,Psi,iter1+1,70,eps);

toc;

H = [H1,H2,H3];

H = min(H);