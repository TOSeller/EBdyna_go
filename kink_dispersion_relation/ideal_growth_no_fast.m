reset_data_analysis_environment
P_initial_profile=PTOT_profile_interp_ini;

Bphi0=Bavg;
r_value_q1_mean=interp1(q_initial_profile,radial_r_value_flux,1)



%
Te_profile=TE_profile_interp_ini*eV;
Ne_profile=NE_profile_interp_ini;
Ne0=NE_profile_interp_ini(1)
Te0=TE_profile_interp_ini(1)*eV

%
Pbulk_profile=(NI_profile_interp_ini.*TI_profile_interp_ini*eV+NE_profile_interp_ini.*TE_profile_interp_ini*eV);

Btot_PR_map=sqrt(BX_PR_map.^2+BZ_PR_map.^2+Btor_PR_map.^2);
derq=gradient(q_initial_profile,radial_r_value_flux);
derP=gradient(P_initial_profile,radial_r_value_flux);
derPi=gradient((NI_profile_interp_ini.*TI_profile_interp_ini*eV),radial_r_value_flux);
derPe=gradient((NE_profile_interp_ini.*TE_profile_interp_ini*eV),radial_r_value_flux);

derTe=gradient(Te_profile,radial_r_value_flux);
derne=gradient(Ne_profile,radial_r_value_flux);
derni=gradient(NI_profile_interp_ini,radial_r_value_flux);

B1=mean(Btot_PR_map(1:end-1,psi_rank_q1))
Ti1=TI_profile_interp_ini(psi_rank_q1)*eV;
Te1=Te_profile(psi_rank_q1);
ne1=Ne_profile(psi_rank_q1)
ni1=NI_profile_interp_ini(psi_rank_q1)
vA1=B1/sqrt(mu0*mD*ni1);
derq1=derq(psi_rank_q1);
omegaA1_tilde=vA1/(sqrt(3)*r_value_q1_mean*R0*derq1);
omegaA1=vA1/R0

omegaci=eV*B1/mD;
%be careful, Pi is half of the total pressure - NBI contribution
Pe0=Ne0*Te0
derPi1=derPi(psi_rank_q1);
derPe1=derPe(psi_rank_q1);
derTe1=derTe(psi_rank_q1);
wdia=(1/(mD*ni1*r_value_q1_mean*omegaci))*derPi1
% wdia=(T1/(mD*n1*r_value_q1_mean*omegaci))*dern1


C0=sqrt(1/(epsilon0*mu0));
omegape=sqrt((ne1*eV^2)/(epsilon0*me))
delta_e=C0/omegape

we=-((1/(mD*ne1*r_value_q1_mean*omegaci))*derPe1+0.71*(1/(mD*r_value_q1_mean*omegaci))*derTe1)

% we=-((T1/(mD*r_value_q1_mean*omegaci))*dern1/n1+0.71*(1/(mD*r_value_q1_mean*omegaci))*derT1)
% we=-((0.71*(1/(mD*r_value_q1_mean*omegaci))*derT1)
% we=-((T1/(mD*r_value_q1_mean*omegaci*n1))*dern1)

Bpol1sq=mean(Bpol_PR_map(1:end-1,psi_rank_q1).^2);
dr_avg=mean(dr_PR_map(1:end-1,:));
dr_avg(1:end-1)=radial_r_value_flux(2:end)-radial_r_value_flux(1:end-1);
integ1=0;
for r=2:psi_rank_q1
    integ1=integ1-radial_r_value_flux(r)^2*dr_avg(r)*(derP(r));
end
beta_pol1=(2*mu0/Bpol1sq)*integ1/r_value_q1_mean^2

%electron ion collision frequency
lambda_D=sqrt(epsilon0*Te_profile./(Ne_profile*eV^2));
Lambda_ei=9*(4*pi/3*Ne_profile.*lambda_D.^3);
log_lambda=log(Lambda_ei);
tau_ei=(3*(2*pi)^1.5)*(sqrt(me)*(Te_profile).^1.5)./(Ne_profile.*log_lambda*eV^2);
tau_ei=(epsilon0/eV)^2*tau_ei;
nu_ei_1=interp1(1:Nradial,1./tau_ei,psi_rank_q1);
Zeff=1.5;
eta1=0.51*Zeff*me*nu_ei_1/(ne1*eV^2)
tau_eta=mu0*r_value_q1_mean^2/eta1;
shear1=r_value_q1_mean*derq1
omegaA1_tilde=vA1/(sqrt(3)*R0*r_value_q1_mean*derq1);
omegaA1_hat=(vA1*r_value_q1_mean*derq1)/(sqrt(3)*R0);
omegaA1_wesson=(vA1*r_value_q1_mean*derq1)/(R0);
tau_H=1/omegaA1_hat;
epsilon_eta=tau_H/tau_eta;

%  gamma Bussac 
deltaq=1-q_initial_profile(1)
r2=interp1(q_initial_profile,radial_r_value_flux,2)
% r2=r_value_q1_mean*(1/deltaq+1)^(1/3)
% beta_coef=(1-(r_value_q1_mean/r2)^2)
% 
% gammaI_nominal=omegaA1*sqrt(3)*pi*(r_value_q1_mean^2/R0^3)*(1/derq1)*deltaq*(3*beta_coef*beta_pol1^2-13/112)
beta_coef=(1-(r_value_q1_mean/r2))
deltaW_ideal_hat=-(1-q_initial_profile(1))*(3*beta_coef*beta_pol1^2-13/112)

% gammaI_nominal=-omegaA1*sqrt(3)*pi*(r_value_q1_mean/R0^2)*(1/derq1)*deltaW_ideal_hat


xvalues=radial_r_value_flux/radial_r_value_flux(psi_rank_q1);
dx_avg=xvalues*0;
dx_avg(2:psi_rank_q1)=xvalues(2:psi_rank_q1)-xvalues(1:psi_rank_q1-1);

% PI_profile=(NI_profile_interp_ini.*TI_profile_interp_ini*eV);
PI_profile=(P_initial_profile-NE_profile_interp_ini.*TE_profile_interp_ini*eV);

cp_integ=0;
Pnorm=PI_profile/PI_profile(1);
for r=2:psi_rank_q1
    cp_integ=cp_integ+((xvalues(r)+xvalues(r-1))/2)^(3/2)*dx_avg(r)*(Pnorm(r));
end

betai0=2*mu0*PI_profile(1)/mean(Btor_PR_map(:,1))^2

deltaW_ko_hat=betai0*(1.5/(6*pi))*cp_integ*(r_value_q1_mean/R0)^(-3/2)

deltaW_el_hat=-3*(li_profile(psi_rank_q1)-0.5)^3*(0.5*(kappa1-1))^2

gammaI_nominal=-omegaA1*sqrt(3)*pi*(r_value_q1_mean/R0^2)*(1/derq1)*(deltaW_ideal_hat+deltaW_ko_hat)
deltaW_ideal_ksi0=(deltaW_ideal_hat+deltaW_ko_hat)*6*pi^2*r_value_q1_mean^4*Bavg^2/(mu0*R0^3)


gammaI_nominal_wdia=gammaI_nominal/abs(wdia)

