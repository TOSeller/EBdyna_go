
        % we only give them a new position (further away from magnetic axis)
        % and keep their initial energy
        alphas_pos_x(outcast)=max(min(X0(recast)-(Raxis-R0),scale_X(end-3)),scale_X(4));
        alphas_pos_z(outcast)=max(min(Z0(recast),scale_Z(end-200)),scale_Z(200));
        alphas_pos_phi(outcast)=rand(size(recast))*2*pi;
		alphas_pos_phi_TAE=wrapTAEangle(alphas_pos_phi,TAE_ANGLE);
        

        %alphas_Bfield(outcast)=interp2(scale_X,scale_Z,Btot_XZ_map',alphas_pos_x(outcast),alphas_pos_z(outcast),'*linear');
        evaluate_Bfield_collapse;
        alphas_Epll(outcast)=0.5*(mHe/eV)*(alphas_vpll(outcast)).^2;
        alphas_Eperp(outcast)=max(alphas_Ekin(outcast)-alphas_Epll(outcast),0);
        alphas_mm_part(outcast)=alphas_Eperp(outcast)./alphas_Bfield(outcast);
        alphas_vperp(outcast)=sqrt(2*alphas_Eperp(outcast)*eV/mHe);


        % normal vector N = (cos) u + (sin) w
        % from reused initial positions
        NX(outcast)=cos(norm_angle(recast)).*uX(recast)+sin(norm_angle(recast)).*wX(recast);
        NZ(outcast)=cos(norm_angle(recast)).*uZ(recast)+sin(norm_angle(recast)).*wZ(recast);
        Nphi(outcast)=cos(norm_angle(recast)).*uphi(recast)+sin(norm_angle(recast)).*wphi(recast);

        v_X(outcast)=alphas_vpll(outcast).*bX(outcast)+alphas_vperp(outcast).*NX(outcast);
        v_Z(outcast)=alphas_vpll(outcast).*bZ(outcast)+alphas_vperp(outcast).*NZ(outcast);
        v_phi(outcast)=alphas_vpll(outcast).*bphi(outcast)+alphas_vperp(outcast).*Nphi(outcast);
        
        % taking the previous speed as initial speed
        v_X_prev(outcast)=v_X(outcast);
        v_Z_prev(outcast)=v_Z(outcast);
        v_phi_prev(outcast)=v_phi(outcast);

        % for energy evolution
        alphas_Epot_prev(outcast)=alphas_Epot(outcast);
        alphas_psi_star_prev(outcast)=alphas_psi_star(outcast);

    interpolate_theta_psi_fromXZ;
% 	alphas_omega=wrap2pi(alphas_theta-alphas_pos_phi_wrapped);
    INNER_PART=find((alphas_psi<=(pTAE_sup-1)).*(alphas_psi>=(pTAE_inf+1)));
    OUTER_PART=find((alphas_psi>(pTAE_sup-1))+(alphas_psi<(pTAE_inf+1))>0);
    [IL3D_1 IL3D_2 IL3D_3 IL3D_4 IL3D_5 IL3D_6 IL3D_7 IL3D_8 slopex slopey slopez] = ...
        build_3Dinterp_indexarrays(scale_phi, scale_theta, scale_psi, DPHI,DTHETA,1,alphas_pos_phi_TAE(INNER_PART), alphas_theta(INNER_PART), alphas_psi(INNER_PART));


    alphas_Rpos=alphas_pos_x+R0;
    calculate_potentials;
    alphas_psi_value=interp2_XZ(interp_x,interp_z,psi_XZsmall_map,INDEX_LIST_1,INDEX_LIST_2,INDEX_LIST_3,INDEX_LIST_4);
    
    alphas_psi_star=-bphi.*alphas_Apll_value.*alphas_Rpos;
    
    if ~isempty(OUTER_PART)
        alphas_psi_value_corr(OUTER_PART)=alphas_psi_value(OUTER_PART);
    end
    alphas_psi_value_corr(INNER_PART)=alphas_psi_value(INNER_PART)+alphas_psi_star(INNER_PART);

    alphas_pphi0(outcast)=(mHe/eV)*(alphas_pos_x(outcast)+R0).*v_phi(outcast)-(ZHe)*alphas_psi_value_corr(outcast);

    if ~isempty(OUTER_PART)
%         alphas_psi_star_prev(OUTER_PART)=zeros(size(OUTER_PART,1),1);
        alphas_Epot(OUTER_PART)=zeros(size(OUTER_PART,1),1);
    end



    if ~isempty(OUTER_PART)
%         alphas_grad_Phi(OUTER_PART)=zeros(size(OUTER_PART,1),1);
%         alphas_grad_psi_star(OUTER_PART)=zeros(size(OUTER_PART,1),1);
%         delta_ps(OUTER_PART)=zeros(size(OUTER_PART,1),1);
        delta_E(OUTER_PART)=zeros(size(OUTER_PART,1),1);
    end
%     alphas_grad_Phi(INNER_PART)=lininterp3( grad_Phi_tor_map_phi,IL3D_1,IL3D_2,IL3D_3,IL3D_4,IL3D_5,IL3D_6,IL3D_7,IL3D_8, slopex,slopey,slopez);
