disp('---------------------------------------------');
disp('-- GROUPS OF PARTICLE ORBITS (PERCENTAGES) --');
disp('---------------------------------------------');
% disp('EXOTIC_LIST=');
% disp(100*length(EXOTIC_LIST)/Nalphas_simulated);
disp('POTATOES_LIST=');
disp(100*length(POTATOES)/Nalphas_simulated);
disp('STAGNATION_LIST=');
disp(100*length(STAGNATION)/Nalphas_simulated);

disp('TRAPPED_MINUS=');
disp(100*length(TRAPPED_MINUS)/Nalphas_simulated);
disp('TRAPPED_PLUS=');
disp(100*length(TRAPPED_PLUS)/Nalphas_simulated);

disp('CO_PASSING=');
disp(100*length(CO_PASSING)/Nalphas_simulated);
disp('COUNTER_PASSING=');
disp(100*length(COUNTER_PASSING)/Nalphas_simulated);

disp('TOTAL=');
disp(100*(length(COUNTER_PASSING)+length(CO_PASSING)+length(TRAPPED_PLUS)+length(TRAPPED_MINUS)+...
    length(STAGNATION)+length(POTATOES))/Nalphas_simulated);
