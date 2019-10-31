function [CLmax_Clmax_R,CLmax_Clmax_K,CLmax_Clmax_T] =CLMAXDATCON(wSweepLE,...
     xutip,yutip,xukink,yukink, xuroot,yuroot)

% Descobre valores de Ay para os três aerofólios
%==> Raiz
DeltaY_root=FIND_DY(xuroot,yuroot);
CLmax_Clmax_R=clmaxratio(wSweepLE,DeltaY_root*100);
%==> Quebra
DeltaY_kink=FIND_DY(xukink,yukink);
CLmax_Clmax_K=clmaxratio(wSweepLE,DeltaY_kink*100);
%==> Ponta
DeltaY_tip=FIND_DY(xutip,yutip);
CLmax_Clmax_T=clmaxratio(wSweepLE,DeltaY_tip*100);

end% function