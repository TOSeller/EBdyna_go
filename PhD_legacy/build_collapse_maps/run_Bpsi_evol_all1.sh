#PBS -lwalltime=48:00:00
                         # 48 hours wall-clock 
                         # time allowed for this job 
#PBS -lnodes=1:ppn=2
                         # 1 node for this job 
module load mcr 
# create unique mcr cache directory on /scratch:
export MCR_CACHE_ROOT=`mktemp -d /scratch/mcr.XXXXXXXXXX` 
( 
cd $HOME/MATLAB/AUG_32324_2p46/build_collapse_maps
taskset -c 0 ./calculate_Bfield_psi_complete_phi_evol1
) &
(
cd $HOME/MATLAB/AUG_32324_2p46/build_collapse_maps
taskset -c 1 ./calculate_Bfield_psi_complete_phi_evol2
) &
(
cd $HOME/MATLAB/AUG_32324_2p46/build_collapse_maps
taskset -c 2 ./calculate_Bfield_psi_complete_phi_evol3
) &
(
cd $HOME/MATLAB/AUG_32324_2p46/build_collapse_maps
taskset -c 3 ./calculate_Bfield_psi_complete_phi_evol4
) &
( 
cd $HOME/MATLAB/AUG_32324_2p46/build_collapse_maps
taskset -c 4 ./calculate_Bfield_psi_complete_phi_evol5
) &
(
cd $HOME/MATLAB/AUG_32324_2p46/build_collapse_maps
taskset -c 5 ./calculate_Bfield_psi_complete_phi_evol6
) &
(
cd $HOME/MATLAB/AUG_32324_2p46/build_collapse_maps
taskset -c 6 ./calculate_Bfield_psi_complete_phi_evol7
) &
(
cd $HOME/MATLAB/AUG_32324_2p46/build_collapse_maps
taskset -c 7 ./calculate_Bfield_psi_complete_phi_evol8
) &
wait


