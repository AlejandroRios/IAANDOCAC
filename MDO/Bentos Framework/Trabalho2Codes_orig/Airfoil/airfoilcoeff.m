function [r0, t_c, phi, X_tcmax, theta, epsilon, ...
    Ycmax, YCtcmax, X_Ycmax]=airfoilcoeff(PROOT,PKINK,PTIP)
%
airfoil_file_root = PROOT;
airfoil_file_kink = PKINK;
airfoil_file_tip  = PTIP;
%
figh7=figure(7);
subplot(3,1,1)
fileToRead1=airfoil_file_root;
[r0(1), t_c(1), phi(1), X_tcmax(1), theta(1), epsilon(1), ...
    Ycmax(1), YCtcmax(1), X_Ycmax(1), ~, ~, ~ ]=airfoil_sobieski_coef(fileToRead1);
fprintf(' \n Maximum relative thickness of root airfoil: %4.1f \n',t_c(1)*100);
axis equal
 subplot(3,1,2)
fileToRead2=airfoil_file_kink;
[r0(2), t_c(2), phi(2), X_tcmax(2), theta(2), epsilon(2), ...
    Ycmax(2), YCtcmax(2), X_Ycmax(2), ~, ~, ~ ]=airfoil_sobieski_coef(fileToRead2);
fprintf(' \n Maximum relative thickness of kink airfoil: %4.1f \n',t_c(2)*100);
axis equal
subplot(3,1,3)
fileToRead3=airfoil_file_tip;
[r0(3), t_c(3), phi(3), X_tcmax(3), theta(3), epsilon(3), ...
    Ycmax(3), YCtcmax(3), X_Ycmax(3), ~, ~, ~ ]=airfoil_sobieski_coef(fileToRead3);
axis equal
%
fprintf(' \n Maximum relative thickness of tip airfoil: %4.1f \n',t_c(3)*100);
if exist('airfoils.jpg','file') 
    delete 'airfoils.jpg'
end
cd ..
cd Figures
print(figh7,'airfoils.jpg','-djpeg','-r300')
close(figure(7))
cd ..
cd Airfoil
end % function
