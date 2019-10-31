function SWET_FF=Wetted_area_forwfus(fus_h,fus_w,lco)
%
% Estimates the wetted area of the front fuselage
% Author: B. Mattos 30/March/2019
%--------------------------------------------------------------------------
%% Load STL mesh
% Stereolithography (STL) files are a common format for storing mesh data. STL
% meshes are simply a collection of triangular faces. This type of model is very
% suitable for use with MATLAB's PATCH graphics object.
%%
% Import an STL mesh of FFus, returning a PATCH-compatible face-vertex structure
cd Plotairplane
[fac, vert] = stlread('forwardfus_short.stl');
cd ..
%
xmin=min(vert(:,1));
xmax=max(vert(:,1));
ymin=min(vert(:,2));
ymax=max(vert(:,2));
zmin=min(vert(:,3));
zmax=max(vert(:,3));
% Proceed to scale the mesh to fit into the current airplane configuration
%xmed = 0.50*(xmin+xmax);
ymed = 0.50*(ymin+ymax);
zmed = 0.50*(zmin+zmax);
%
dx=xmax-xmin;
dy=ymax-ymin;
dz=zmax-zmin;
%
scalex     = lco/dx;
scaley     = fus_w/dz;
scalez     = fus_h/dy;
%
vert(:,1)  = vert(:,1) - xmin;
vert(:,2)  = vert(:,2) - ymed;
vert(:,3)  = vert(:,3) - zmed;
%
verts(:,2) = vert(:,2)*scalez;
verts(:,3) = vert(:,3)*scaley;
verts(:,1) = vert(:,1)*scalex;
%
aux        = verts(:,2);
verts(:,2) = verts(:,3);
verts(:,3) = aux;
 % Exposed area of the forward fuselage
nfac=size(fac,1);
AT=0;
for i=1:nfac
 x=zeros(1,3);
 y=zeros(1,3);
 z=zeros(1,3);
 % Find out vertices coordinates
     for j=1:3
         nvert=fac(i,j);
         x(j)=verts(nvert,1);
         y(j)=verts(nvert,2);
         z(j)=verts(nvert,3);
     end
% Call triangule area calculatine routine
A=D3_triangle_area(x,y,z);
AT=AT+A;
clear x y z
end
SWET_FF=AT;

%fv1=struct('faces',fac,'vertices',verts);
%% Render
% The model is rendered with a PATCH graphics object. We also add some dynamic
% lighting, and adjust the material properties to change the specular
% highlighting.
% patch(fv1,'FaceColor',[0.35 0.45 0.35],...
%           'EdgeColor',       [0  0 0], 'EdgeAlpha',0.0,         ...
%           'FaceLighting',    'gouraud',     ...
%           'AmbientStrength', 0.125);
% %nfac=size(fac,1);
% % for i=1:nfac
% %     for j=1:3
% %         nvert=fac(i,j);
% %         x(j)=vert(nvert,1);
% %         y(j)=vert(nvert,2);
% %         z(j)=vert(nvert,3);
% %     end
% %     fill3(x,y,z,'g')
% %     hold on
% % end
% hold on
% % % Add a camera light, and tone down the specular highlighting
% camlight('headlight');
% material('metal');
% axis equal
% % 
% % % Fix the axes scaling, and set a nice view angle
% %  axis('image');
%   xlabel('x');
%   ylabel('y')
%   zlabel('z');
%  view([-135 35]);
end % function