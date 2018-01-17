
close all

REINIT_ALL_TOKAMAK_DATA=1;


if REINIT_ALL_TOKAMAK_DATA==1
    clear all
    load('../data_tokamak/motions_map_dimensions.mat')
    load('../data_tokamak/XZsmall_fields_tokamak_pre_collapse.mat')
    scale_X_small=scale_X;
    scale_Z_small=scale_Z;
    theta_map=theta_XZsmall_map;
    psi_norm_map=psi_norm_XZsmall_map;
    psi_map=psi_XZsmall_map;


    initialize_folder_names;
    initialize_collapse_map_calculation_context
    rescaling_to_XZsmall_maps
    mask_XZ_small=(psi_XZsmall_map<(psi_scale(size_r)-0.01));
    %mask_XZ_small(:,:)=mask_XZ(Xinf:Xsup,Zinf:Zsup);
    DT_INTERPOLATION_METHOD='quadratic'     % by default
    CALCULATE_VD_DATA_FILE=0;
end
CALCULATE_VD_DATA_FILE=1;

% load('../B_maps/B0311.mat');
% load('../E_maps/E0311.mat');
%

frame_rank=32


% for (frame_rank=2:8:86)
    
    
    % for frame_rank=1:101
    disp('----------------------------------------');
    
    reference_frame=min((frame_rank-1)*10+1,size(rx_evol_interp,2))
    
    f=reference_frame;
    
    if (f<10)
        frame_name='00';
    elseif (f<100)
        frame_name='0';
    else
        frame_name='';
    end
    
    frame_name=strcat(frame_name,num2str(f));
    filename_B='../B_maps/B0';
    filename_B=strcat(filename_B,frame_name,'.mat');
    load(filename_B);
    filename_E='../E_maps/E0';
    filename_E=strcat(filename_E,frame_name,'.mat');
    load(filename_E);
    
    
   phi_index=1
   calculate_Epot_map_phi_index;
   
   Epot_XZ_map1=Epot_XZ_map;
   lap_Phi_PR_map1=lap_Phi_PR_map;
   lap_Phi_XZ_map1=lap_Phi_XZ_map;
   
   phi_index=round(0.5*NB_PHI)
   calculate_Epot_map_phi_index
   

   Epot_XZ_map2=Epot_XZ_map;
   lap_Phi_PR_map2=lap_Phi_PR_map;
   lap_Phi_XZ_map2=lap_Phi_XZ_map;

   
%%

figure(2)
% setappdata(gcf, 'SubplotDefaultAxesLocation', [0,0,1,1])
subplot_tight(2,2,1)
set(gca,'FontSize',26);
hold on
imagesc(scale_X,scale_Z ,(Epot_XZ_map1)',[-3.9 3.9]*1e3);
contour(scale_X_small,scale_Z_small,theta_map',20,'k')
contour(scale_X_small,scale_Z_small,psi_norm_map',20,'k')
% colormap(flipud(gray))
axis xy
% axis square

% xlabel('X')
ylabel('Z')
t_h=title('$$\Phi (\varphi=0)$$','interpreter','latex');
set(t_h,'Interpreter','latex');
colorbar('North')


subplot_tight(2,2,2)
set(gca,'FontSize',26);
hold on
imagesc(scale_X,scale_Z , (Epot_XZ_map2)',[-3.9 3.9]*1e3);
contour(scale_X_small,scale_Z_small,theta_map',20,'k')
contour(scale_X_small,scale_Z_small,psi_norm_map',20,'k')
% colormap(flipud(gray))
axis xy
% axis square

% xlabel('X')
ylabel('Z')
t_h=title('$$\Phi (\varphi=\pi)$$','interpreter','latex');
set(t_h,'Interpreter','latex');
colorbar('North')




% figure(3)
subplot_tight(2,2,3)
set(gca,'FontSize',26);
hold on
% imagesc(scale_X,scale_Z ,abs(EZ_map1)',[0 5]*1e4);
imagesc(scale_X,scale_Z , lap_Phi_XZ_map1');
colormap(jet)
axis xy
% axis square

xlabel('X')
ylabel('Z')
xlim([-0.35 0.5])
ylim([-0.45 0.45])

% t_h=title('$$|E_Z| (\varphi=0)$$','interpreter','latex')
t_h=title('$$v_{E}.\nabla_r\psi (\varphi=0)$$','interpreter','latex');
set(t_h,'Interpreter','latex');
colorbar('North')


subplot_tight(2,2,4)
hold on
set(gca,'FontSize',26);
% imagesc(scale_X,scale_Z , abs(EZ_map2)',[0 5]*1e4);
imagesc(scale_X,scale_Z , lap_Phi_XZ_map2');
colormap(jet)
axis xy
% axis square

xlabel('X')
ylabel('Z')
xlim([-0.35 0.5])
ylim([-0.45 0.45])
% t_h=title('$$|E_Z| (\varphi=\pi)$$','interpreter','latex')
t_h=title('$$v_{E}.\nabla_r\psi (\varphi=\pi)$$','interpreter','latex');
set(t_h,'Interpreter','latex');
colorbar('North')

