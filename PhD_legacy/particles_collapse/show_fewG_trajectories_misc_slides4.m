% time_stamp_end = 1231
% find(Ekin_outputG(:,1)<60*1e3)

NAPsi=2;
% % 
P1=8+NAPsi*1+16*NAPsi*2;
P2=8+NAPsi*14+16*NAPsi*2;
P5=8+NAPsi*1+16*NAPsi*5;
P6=8+NAPsi*14+16*NAPsi*5;



% vperp_sq_outputG=vDsq_outputG;
% Bfield_part_outputG=interp2(scale_X,scale_Z,Btot_XZ_map',Xpos_outputG,Zpos_outputG,'*linear');
mm_outputG=Eperp_outputG./Bfield_outputG;
lambda_outputG=Bavg*mm_outputG./Ekin_outputG;
% psi_value_outputG=interp2(scale_X,scale_Z,psi_XZsmall_map',Xpos_outputG,Zpos_outputG,'*linear');
% lap_psi_outputG=interp2(scale_X,scale_Z,lap_psi_XZsmall_map',Xpos_outputG,Zpos_outputG,'*linear');

% for (n=1:24)
% psi_value_corr_outputG(n,:)=psipos_outputG(n,:)-alphas_psi_star_ini(n)+psi_star_outputG(n,:);
% end
lambda_P1=lambda_outputG(P1,1);
lambda_P2=lambda_outputG(P2,1);
lambda_P5=lambda_outputG(P5,1);
lambda_P6=lambda_outputG(P6,1);

Ekin_P1=round(Ekin_outputG(P1,1));
Ekin_P2=round(Ekin_outputG(P2,1));
Ekin_P5=round(Ekin_outputG(P5,1));
Ekin_P6=round(Ekin_outputG(P6,1));

lP1=strcat('\lambda _{ini} = ',num2str(lambda_P1));
lP2=strcat('\lambda _{ini} = ',num2str(lambda_P2));
lP5=strcat('\lambda _{ini} = ',num2str(lambda_P5));
lP6=strcat('\lambda _{ini} = ',num2str(lambda_P6));

EP1=strcat('Ekin _{ini} = ',num2str(Ekin_P1));
EP2=strcat('Ekin _{ini} = ',num2str(Ekin_P2));
EP5=strcat('Ekin _{ini} = ',num2str(Ekin_P5));
EP6=strcat('Ekin _{ini} = ',num2str(Ekin_P6));



phipos_outputG_wrap=wrap2pi(phipos_outputG);
omega_outputG=theta_outputG-phipos_outputG_wrap;
omega_outputG=wrap2pi(omega_outputG);

size_phi=257;
scale_tor=40*pi*((0:size_phi-1)/(size_phi-1));
Btot_X_vector=mean(Btot_XZ_map,2);
[Btot_Xphi_map tmp]=meshgrid(Btot_X_vector,ones(size_phi,1));
Btot_Xphi_map=Btot_Xphi_map';

end_time=size(time_scale_G,2);
ejection_time=size(time_scale_G,2);
% end_time=2920;
time_end=time_scale_G(end_time);
time_stamp_end=end_time

%time0=round(0.75*end_time);
time0=1;

%%
close all


figure(1);
set(gca,'FontSize',16);
hold on;

plot(Xpos_outputG(P1,time0:0.5*time_stamp_end),Zpos_outputG(P1,time0:0.5*time_stamp_end),'b','LineWidth',2);
plot(Xpos_outputG(P2,time0:time_stamp_end),Zpos_outputG(P2,time0:time_stamp_end),'Color',[0.1 0.1 0.7],'LineWidth',2);
plot(Xpos_outputG(P5,time0:time_stamp_end),Zpos_outputG(P5,time0:time_stamp_end),'--','Color',[1.0 0.2 0.2],'LineWidth',1);
plot(Xpos_outputG(P6,time0:time_stamp_end),Zpos_outputG(P6,time0:time_stamp_end),'--','Color',[0.6 0.2 0.2],'LineWidth',1);
legend(EP1,EP2,EP5,EP6);

contour(scale_X,scale_Z,(radial_XZsmall_map'-257)*psi_global/257,12,'y');
xlim([-1.4 1.7]);
ylim([-1.7 1.7]);

contour(scale_X,scale_Z,Btot_XZ_map',(2:0.2:4.4));axis xy square
colormap('summer')
colorbar;

plot(Xpos_outputG(P1,time0:time_stamp_end),Zpos_outputG(P1,time0:time_stamp_end),'b','LineWidth',2);
plot(Xpos_outputG(P2,time0:time_stamp_end),Zpos_outputG(P2,time0:time_stamp_end),'Color',[0.1 0.1 0.7],'LineWidth',2);
plot(Xpos_outputG(P5,time0:time_stamp_end),Zpos_outputG(P5,time0:time_stamp_end),'--','Color',[1.0 0.2 0.2],'LineWidth',1);
plot(Xpos_outputG(P6,time0:time_stamp_end),Zpos_outputG(P6,time0:time_stamp_end),'--','Color',[0.6 0.2 0.2],'LineWidth',1);

xlabel('X (m)');
ylabel('Z (m)');

%%

% figure(2);
% set(gca,'FontSize',16);
% 
% imagesc(scale_X,scale_tor,Btot_Xphi_map',[1 4]);
% axis xy square
% xlim([-0.5 0.5]);
% ylim([0 40*pi]);
% colormap('summer')
% %brighten(0.6);
% hold on;
% plot(Xpos_outputG(P4,time0:end_time),phipos_outputG(P4,time0:end_time),'b','LineWidth',2);
% plot(Xpos_outputG(P5,time0:end_time),phipos_outputG(P5,time0:end_time),'Color',[0.2 0.8 0.2],'LineWidth',1);
% plot(Xpos_outputG(P6,time0:end_time),phipos_outputG(P6,time0:end_time),'Color',[0.8 0.2 0.2],'LineWidth',1);
% 
% xlabel('X (m)');
% ylabel('\phi (rad)');
% colorbar;
% 




figure(3);

subplot(2,1,1);
set(gca,'FontSize',16);
grid on;
hold on;
xlim([time_scale_G(1) time_scale_G(end-1)])
plot(time_scale_G(time0:end_time),phipos_outputG(P1,time0:end_time),'b','LineWidth',2);
plot(time_scale_G(time0:end_time),phipos_outputG(P2,time0:end_time),'Color',[0.1 0.1 0.6],'LineWidth',2);
plot(time_scale_G(time0:end_time),phipos_outputG(P5,time0:end_time),'Color',[0.2 0.8 0.2],'LineWidth',2);
plot(time_scale_G(time0:end_time),phipos_outputG(P6,time0:end_time),'Color',[0.8 0.2 0.2],'LineWidth',2);
xlabel('time (s)');
ylabel('\phi (rad)');
xlim([0 time_end]);
legend(EP1,EP2,EP5,EP6);

subplot(2,1,2);
set(gca,'FontSize',16);
grid on;
hold on
xlim([time_scale_G(1) time_scale_G(end-1)])
plot(time_scale_G(time0:end_time),vparallel_outputG(P1,time0:end_time),'b','LineWidth',2);
plot(time_scale_G(time0:end_time),vparallel_outputG(P2,time0:end_time),'Color',[0.1 0.1 0.6],'LineWidth',2);
plot(time_scale_G(time0:end_time),vparallel_outputG(P5,time0:end_time),'Color',[0.2 0.8 0.2],'LineWidth',2);
plot(time_scale_G(time0:end_time),vparallel_outputG(P6,time0:end_time),'Color',[0.8 0.2 0.2],'LineWidth',2);
xlabel('time (s)');
ylabel('v_{||} (m/s)');
xlim([0 time_end]);



figure(4)
set(gca,'FontSize',16);

grid on;
hold on;
xlim([time_scale_G(1) time_scale_G(end-1)])
% plot(time_scale_G(1:end_time),0.5*(mHe/eV)*(vparallel_outputG(P1,1:end_time).^2+vdriftsq_outputG(P1,1:end_time))+Eperp_outputG(P1,1:end_time),'b','LineWidth',2);
% plot(time_scale_G(1:end_time),0.5*(mHe/eV)*(vparallel_outputG(P2,1:end_time).^2+vdriftsq_outputG(P2,1:end_time))+Eperp_outputG(P2,1:end_time),'Color',[0.1 0.1 0.6],'LineWidth',2);
% plot(time_scale_G(1:end_time),0.5*(mHe/eV)*(vparallel_outputG(P5,1:end_time).^2+vdriftsq_outputG(P5,1:end_time))+Eperp_outputG(P5,1:end_time),'Color',[0.2 1.0 0.2],'LineWidth',2);
% plot(time_scale_G(1:end_time),0.5*(mHe/eV)*(vparallel_outputG(P6,1:end_time).^2+vdriftsq_outputG(P6,1:end_time))+Eperp_outputG(P6,1:end_time),'Color',[0.8 0.2 0.2],'LineWidth',2);
plot(time_scale_G(1:end_time),0.5*(mHe/eV)*(vparallel_outputG(P1,1:end_time).^2)+Eperp_outputG(P1,1:end_time),'b','LineWidth',2);
plot(time_scale_G(1:end_time),Ekin_outputG(P1,1:end_time),'k--','LineWidth',2);
% plot(time_scale_G(1:end_time),Etot_outputG(P1,1:end_time)-ZHe*Epot_outputG(P1,1:end_time),'k--','LineWidth',2);
plot(time_scale_G(1:end_time),0.5*(mHe/eV)*(vparallel_outputG(P2,1:end_time).^2)+Eperp_outputG(P2,1:end_time),'Color',[0.1 0.1 0.6],'LineWidth',2);
plot(time_scale_G(1:end_time),Ekin_outputG(P2,1:end_time),'k--','LineWidth',2);
% plot(time_scale_G(1:end_time),Etot_outputG(P2,1:end_time)-ZHe*Epot_outputG(P2,1:end_time),'k--','LineWidth',2);
plot(time_scale_G(1:end_time),0.5*(mHe/eV)*(vparallel_outputG(P5,1:end_time).^2)+Eperp_outputG(P5,1:end_time),'Color',[0.2 1.0 0.2],'LineWidth',2);
plot(time_scale_G(1:end_time),Ekin_outputG(P5,1:end_time),'k--','LineWidth',2);
% plot(time_scale_G(1:end_time),Etot_outputG(P5,1:end_time)-ZHe*Epot_outputG(P5,1:end_time),'k--','LineWidth',2);
plot(time_scale_G(1:end_time),0.5*(mHe/eV)*(vparallel_outputG(P6,1:end_time).^2)+Eperp_outputG(P6,1:end_time),'Color',[0.8 0.2 0.2],'LineWidth',2);
plot(time_scale_G(1:end_time),Ekin_outputG(P6,1:end_time),'k--','LineWidth',2);
% plot(time_scale_G(1:end_time),Etot_outputG(P6,1:end_time)-ZHe*Epot_outputG(P6,1:end_time),'k--','LineWidth',2);
xlabel('time (s)');
ylabel('Ekin (eV)');
xlim([0 time_end]);

xlim([time_scale_G(1) time_scale_G(end-1)])

legend(EP1,EP2,EP5,EP6);








figure(5);

subplot(2,1,1);
set(gca,'FontSize',16);
grid on;
hold on;

plot(time_scale_G(1:end_time),(mHe/eV)*(Xpos_outputG(P1,1:end_time)+R0).*(vphi_outputG(P1,1:end_time))-ZHe*(psi_value_outputG(P1,1:end_time)),'b','LineWidth',2);
plot(time_scale_G(1:end_time),(mHe/eV)*(Xpos_outputG(P2,1:end_time)+R0).*(vphi_outputG(P2,1:end_time))-ZHe*(psi_value_outputG(P2,1:end_time)),'Color',[0.1 0.1 0.6],'LineWidth',2);
plot(time_scale_G(1:end_time),(mHe/eV)*(Xpos_outputG(P5,1:end_time)+R0).*(vphi_outputG(P5,1:end_time))-ZHe*(psi_value_outputG(P5,1:end_time)),'Color',[0.2 0.8 0.2],'LineWidth',2);
plot(time_scale_G(1:end_time),(mHe/eV)*(Xpos_outputG(P6,1:end_time)+R0).*(vphi_outputG(P6,1:end_time))-ZHe*(psi_value_outputG(P6,1:end_time)),'Color',[0.8 0.2 0.2],'LineWidth',2);

legend(lP1,lP2,lP5,lP6);

xlim([time_scale_G(1) time_scale_G(end-1)])
plot(time_scale_G(1:end_time),(mHe/eV)*(Xpos_outputG(P1,1:end_time)+R0).*(vphi_outputG(P1,1:end_time))-ZHe*(psi_value_outputG(P1,1:end_time)),'b','LineWidth',2);
plot(time_scale_G(1:end_time),pphi_outputG(P1,1:end_time),'k--','LineWidth',1);
plot(time_scale_G(1:end_time),(mHe/eV)*(Xpos_outputG(P2,1:end_time)+R0).*(vphi_outputG(P2,1:end_time))-ZHe*(psi_value_outputG(P2,1:end_time)),'Color',[0.1 0.4 0.6],'LineWidth',2);
plot(time_scale_G(1:end_time),pphi_outputG(P2,1:end_time),'k--','LineWidth',1);
plot(time_scale_G(1:end_time),(mHe/eV)*(Xpos_outputG(P5,1:end_time)+R0).*(vphi_outputG(P5,1:end_time))-ZHe*(psi_value_outputG(P5,1:end_time)),'Color',[0.2 0.9 0.2],'LineWidth',2);
plot(time_scale_G(1:end_time),pphi_outputG(P5,1:end_time),'k--','LineWidth',1);
plot(time_scale_G(1:end_time),(mHe/eV)*(Xpos_outputG(P6,1:end_time)+R0).*(vphi_outputG(P6,1:end_time))-ZHe*(psi_value_outputG(P6,1:end_time)),'Color',[0.9 0.2 0.2],'LineWidth',2);
plot(time_scale_G(1:end_time),pphi_outputG(P6,1:end_time),'k--','LineWidth',1);
xlabel('time (s)');
ylabel('p_\phi');
xlim([0 time_end]);


subplot(2,1,2);
set(gca,'FontSize',16);
grid on;
hold on
plot(time_scale_G(time0:end_time),vphi_outputG(P1,time0:end_time),'b','LineWidth',1.5);
plot(time_scale_G(time0:end_time),vphi_outputG(P2,time0:end_time),'Color',[0.1 0.4 0.6],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),vphi_outputG(P5,time0:end_time),'--','Color',[0.2 0.9 0.2],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),vphi_outputG(P6,time0:end_time),'--','Color',[0.9 0.2 0.2],'LineWidth',1.5);
xlabel('time (s)')
ylabel('v_\phi (m/s)');
% xlim([time_scale_G(1) time_scale_G(end-1)])
xlim([0 time_end]);



figure(6)

subplot(2,1,1);
set(gca,'FontSize',16);

grid on;
hold on
xlim([time_scale_G(1) time_scale_G(end-1)])
% plot(time_scale_G(1:end_time),Eperp_outputG(P1,1:end_time),'r');
plot(time_scale_G(1:end_time),Eperp_outputG(P1,1:end_time),'b','LineWidth',2);
plot(time_scale_G(1:end_time),Eperp_outputG(P2,1:end_time),'Color',[0.1 0.1 0.6],'LineWidth',2);
plot(time_scale_G(1:end_time),Eperp_outputG(P5,1:end_time),'Color',[0.2 0.8 0.2],'LineWidth',2);
plot(time_scale_G(1:end_time),Eperp_outputG(P6,1:end_time),'Color',[0.8 0.2 0.2],'LineWidth',2);
xlabel('time (s)');
ylabel('Eperp (eV)');
legend(lP1,lP2,lP5,lP6);

subplot(2,1,2);
set(gca,'FontSize',16);

grid on;
hold on
xlim([time_scale_G(1) time_scale_G(end-1)])
% plot(time_scale_G(1:end_time),vparallel_outputG(P1,1:end_time),'r');
plot(time_scale_G(1:end_time),vparallel_outputG(P1,1:end_time),'b','LineWidth',2);
plot(time_scale_G(1:end_time),vparallel_outputG(P2,1:end_time),'Color',[0.1 0.1 0.6],'LineWidth',2);
plot(time_scale_G(1:end_time),vparallel_outputG(P5,1:end_time),'Color',[0.2 0.8 0.2],'LineWidth',2);
plot(time_scale_G(1:end_time),vparallel_outputG(P6,1:end_time),'Color',[0.8 0.2 0.2],'LineWidth',2);
xlabel('time (s)');
ylabel('v_{||} (m/s)');





figure(7)

subplot(2,1,1);
set(gca,'FontSize',16);
grid on;
hold on

plot(time_scale_G(time0:end_time),mm_outputG(P1,time0:end_time),'b','LineWidth',1.5);
plot(time_scale_G(time0:end_time),mm_outputG(P2,time0:end_time),'Color',[0.1 0.1 0.6],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),mm_outputG(P5,time0:end_time),'--','Color',[0.2 0.8 0.2],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),mm_outputG(P6,time0:end_time),'--','Color',[0.8 0.2 0.2],'LineWidth',1.5);
xlabel('time (s)');
ylabel('\mu (eV T^{-1})');
% xlim([time_scale_G(1) time_scale_G(end-1)])
xlim([0 time_end]);
legend(lP1,lP2,lP5,lP6);

subplot(2,1,2);
set(gca,'FontSize',16);
grid on;
hold on
plot(time_scale_G(time0:end_time),psipos_outputG(P1,time0:end_time),'b','LineWidth',1.5);
plot(time_scale_G(time0:end_time),psipos_outputG(P2,time0:end_time),'Color',[0.1 0.1 0.6],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),psipos_outputG(P5,time0:end_time),'--','Color',[0.2 0.8 0.2],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),psipos_outputG(P6,time0:end_time),'--','Color',[0.8 0.2 0.2],'LineWidth',1.5);
plot([time_scale_G(time0) time_scale_G(end_time)],[133 133],'k--','LineWidth',2)
xlabel('time (s)')
ylabel('\psi (a.u.)');
% xlim([time_scale_G(1) time_scale_G(end-1)])
xlim([0 time_end]);



figure(8)

subplot(2,1,1);
set(gca,'FontSize',16);
grid on;
hold on

plot(time_scale_G(time0:end_time),omega_outputG(P1,time0:end_time),'b','LineWidth',1.5);
plot(time_scale_G(time0:end_time),omega_outputG(P2,time0:end_time),'Color',[0.1 0.1 0.6],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),omega_outputG(P5,time0:end_time),'--','Color',[0.2 0.8 0.2],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),omega_outputG(P6,time0:end_time),'--','Color',[0.8 0.2 0.2],'LineWidth',1.5);
xlabel('time (s)');
ylabel('\omega (rad)');
% xlim([time_scale_G(1) time_scale_G(end-1)])
xlim([0 time_end]);

subplot(2,1,2);
set(gca,'FontSize',16);
grid on;
hold on
plot(time_scale_G(time0:end_time),psi_star_outputG(P1,time0:end_time),'b','LineWidth',1.5);
plot(time_scale_G(time0:end_time),psi_star_outputG(P2,time0:end_time),'Color',[0.1 0.1 0.6],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),psi_star_outputG(P5,time0:end_time),'--','Color',[0.2 0.8 0.2],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),psi_star_outputG(P6,time0:end_time),'--','Color',[0.8 0.2 0.2],'LineWidth',1.5);
xlabel('time (s)')
ylabel('\psi_* (T/m^2)');
% xlim([time_scale_G(1) time_scale_G(end-1)])
xlim([0 time_end]);

legend(lP1,lP2,lP5,lP6);



figure(9)

subplot(2,1,1);
set(gca,'FontSize',16);
grid on;
hold on

plot(time_scale_G(time0:end_time),psi_value_outputG(P1,time0:end_time),'b','LineWidth',1.5);
plot(time_scale_G(time0:end_time),psi_value_outputG(P2,time0:end_time),'Color',[0.1 0.1 0.6],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),psi_value_outputG(P5,time0:end_time),'Color',[0.2 0.8 0.2],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),psi_value_outputG(P6,time0:end_time),'Color',[0.8 0.2 0.2],'LineWidth',1.5);
xlabel('time (s)');
ylabel('\psi (T.m^{-2})');
% xlim([time_scale_G(1) time_scale_G(end-1)])
xlim([0 time_end]);

subplot(2,1,2);
set(gca,'FontSize',16);
grid on;
hold on
plot(time_scale_G(time0:end_time),(vEradial_outputG(P1,time0:end_time)),'b','LineWidth',1.5);
plot(time_scale_G(time0:end_time),(vEradial_outputG(P2,time0:end_time)),'Color',[0.1 0.1 0.6],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),(vEradial_outputG(P5,time0:end_time)),'Color',[0.2 0.8 0.2],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),(vEradial_outputG(P6,time0:end_time)),'Color',[0.8 0.2 0.2],'LineWidth',1.5);
xlabel('time (s)')
ylabel('v_E (radial) (m/s)');
% xlim([time_scale_G(1) time_scale_G(end-1)])
xlim([0 time_end]);

legend(lP1,lP2,lP5,lP6);



figure(10)

subplot(2,1,1);
set(gca,'FontSize',16);
grid on;
hold on
xlim([time_scale_G(1) time_scale_G(end-1)])
% plot(time_scale_G(time0:end_time),psi_star_outputG(P1,time0:end_time),'b');
% plot(time_scale_G(time0:end_time),psi_star_outputG(P2,time0:end_time),'Color',[0.1 0.1 0.6],'LineWidth',1.5);
% plot(time_scale_G(time0:end_time),psi_star_outputG(P5,time0:end_time),'Color',[0.2 0.8 0.2],'LineWidth',1.5);
% plot(time_scale_G(time0:end_time),psi_star_outputG(P6,time0:end_time),'Color',[0.8 0.2 0.2],'LineWidth',1.5);
% xlabel('time (s)');
% ylabel('\psi*');
plot(time_scale_G(time0:end_time),Epot_outputG(P1,time0:end_time),'b');
plot(time_scale_G(time0:end_time),Epot_outputG(P2,time0:end_time),'Color',[0.1 0.1 0.6],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),Epot_outputG(P5,time0:end_time),'Color',[0.2 0.8 0.2],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),Epot_outputG(P6,time0:end_time),'Color',[0.8 0.2 0.2],'LineWidth',1.5);
xlabel('time (s)');
ylabel('Epot (eV)');
legend(lP1,lP2,lP5,lP6);

subplot(2,1,2);
set(gca,'FontSize',16);
grid on;
hold on
plot(time_scale_G(1:end_time),ZHe*Epot_outputG(P1,1:end_time)+0.5*(mHe/eV)*(vparallel_outputG(P1,1:end_time).^2)+Eperp_outputG(P1,1:end_time),'b','LineWidth',2);
plot(time_scale_G(1:end_time),Etot_outputG(P1,1:end_time),'k--','LineWidth',2);
plot(time_scale_G(1:end_time),ZHe*Epot_outputG(P2,1:end_time)+0.5*(mHe/eV)*(vparallel_outputG(P2,1:end_time).^2)+Eperp_outputG(P2,1:end_time),'Color',[0.1 0.1 0.6],'LineWidth',2);
plot(time_scale_G(1:end_time),Etot_outputG(P2,1:end_time),'k--','LineWidth',2);
plot(time_scale_G(1:end_time),ZHe*Epot_outputG(P5,1:end_time)+0.5*(mHe/eV)*(vparallel_outputG(P5,1:end_time).^2)+Eperp_outputG(P5,1:end_time),'Color',[0.2 1.0 0.2],'LineWidth',2);
plot(time_scale_G(1:end_time),Etot_outputG(P5,1:end_time),'k--','LineWidth',2);
plot(time_scale_G(1:end_time),ZHe*Epot_outputG(P6,1:end_time)+0.5*(mHe/eV)*(vparallel_outputG(P6,1:end_time).^2)+Eperp_outputG(P6,1:end_time),'Color',[0.8 0.2 0.2],'LineWidth',2);
plot(time_scale_G(1:end_time),Etot_outputG(P6,1:end_time),'k--','LineWidth',2);
xlabel('time (s)');
ylabel('Etot (eV)');

% plot(time_scale_G(1:end_time),vparallel_outputG(P1,1:end_time),'b','LineWidth',2);


figure(12)

subplot(2,1,1);
set(gca,'FontSize',16);
grid on;
hold on
xlim([time_scale_G(1) time_scale_G(end-1)])
plot(time_scale(time0:end_time),theta_outputG(P1,time0:end_time),'b');
plot(time_scale(time0:end_time),theta_outputG(P2,time0:end_time),'Color',[0.1 0.1 0.6],'LineWidth',1.5);
plot(time_scale(time0:end_time),theta_outputG(P5,time0:end_time),'Color',[0.2 0.8 0.2],'LineWidth',1.5);
plot(time_scale(time0:end_time),theta_outputG(P6,time0:end_time),'Color',[0.8 0.2 0.2],'LineWidth',1.5);
xlabel('time (s)');
ylabel('\theta');
subplot(2,1,2);
grid on;
hold on
plot(time_scale_G(time0:end_time),psipos_outputG(P1,time0:end_time),'b');
plot(time_scale_G(time0:end_time),psipos_outputG(P2,time0:end_time),'Color',[0.1 0.1 0.6],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),psipos_outputG(P5,time0:end_time),'Color',[0.2 0.8 0.2],'LineWidth',1.5);
plot(time_scale_G(time0:end_time),psipos_outputG(P6,time0:end_time),'Color',[0.8 0.2 0.2],'LineWidth',1.5);
xlabel('time (s)');
ylabel('\psi');
xlim([0 time_end]);
% 
% dv_corrG=(0.5*(mHe/eV)*dv_outputG.^2)./Ekin_outputG;
% subplot(2,1,2);
% set(gca,'FontSize',16);
% grid on;
% hold on
% plot(time_scale_G(1:end_time),dv_corrG(P1,1:end_time),'b','LineWidth',2);
% plot(time_scale_G(1:end_time),dv_corrG(P2,1:end_time),'Color',[0.1 0.1 0.6],'LineWidth',2);
% plot(time_scale_G(1:end_time),dv_corrG(P5,1:end_time),'Color',[0.2 0.8 0.2],'LineWidth',2);
% plot(time_scale_G(1:end_time),dv_corrG(P6,1:end_time),'Color',[0.8 0.2 0.2],'LineWidth',2);
% 
% xlabel('time (s)');
% ylabel('dv corr');
% xlim([0 time_end]);
% legend(EP1,EP2,EP5,EP6);
