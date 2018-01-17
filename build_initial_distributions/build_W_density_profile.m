initialize_folder_names;
close all;

filename=strcat(DATA_FOLDER,'physics_constants.mat');
load(filename);
filename=strcat(DATA_FOLDER,'pressure_profile.mat');
load(filename);
filename=strcat(DATA_FOLDER,'flux_geometry.mat');
load(filename);
filename=strcat('../METIS_profiles.mat');
load(filename);
filename=strcat(DATA_FOLDER,'q_profile.mat');
load(filename);

if ~exist('rho_tor_scale')
    tor_flux_scale=q_initial_profile*0;
    for n=2:size_r
        tor_flux_scale(n)=trapz(psi_scale(1:n)',q_initial_profile(1:n));
    end
    rho_tor_scale=sqrt(tor_flux_scale/max(tor_flux_scale));
end

mW=183.84*1.660538921*1e-27
mHe=mW;
ZHe=40


if exist('METISdata')
    NIMP_profile_radial_ini=interp1(METISdata.rho_tor_metis,METISdata.nW_profile,rho_tor_scale);
    NWCORE=NIMP_profile_radial_ini(1)
    ROTATION_profile_radial_ini=interp1(METISdata.rho_tor_metis,METISdata.Omega_profile,rho_tor_scale);
    CORE_ROTATION=ROTATION_profile_radial_ini(1)  %rad/s
    MEAN_Q1_ROTATION=-mean(ROTATION_profile_radial_ini(1:size_r));
    W_density_profile=NIMP_profile_radial_ini;

 else
    NWCORE=2e16;
    CORE_ROTATION=1.2e5;
    MEAN_Q1_ROTATION=1e5;
    W_density_profile=(Ne_profile/Ne_profile(1)).^3;
end


plot(radial_r_value_flux,W_density_profile)

filename=strcat(DATA_FOLDER,'W_profile.mat');
save (filename,'W_density_profile','NWCORE','mHe','mW','ZHe','ROTATION_profile_radial_ini','CORE_ROTATION','MEAN_Q1_ROTATION');
