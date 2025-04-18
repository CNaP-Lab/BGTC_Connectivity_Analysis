% script for generating standardized regression coefficients for 
% multiple linear regressions predicting baseline and delta BPND in dorsal caudate from
% task-state functional connectivity .

% Data Needed:
% petConnTable: Table of ROI pair correlations for subjects who completed
% PET

% baselineTable: Table containing demographics and baseline BPND values
% deltaBPNtable: Table containing demographics and delta BPND values

% data is available upon request via a formal data
% sharing agreement

% Used for results shown in Figure 3 in Tubiolo, Williams et al. 2025

connVar = petConnTable.LATERAL__DCa_GPe;
connDat = zscore(connVar);


SCZorSAD = zscore(baselineTable.SCZorSAD);

baselineBPND = baselineTable.dca;

deltaBPND = deltaBPNDtable.dca; 

age = zscore(deltaBPNDtable.Age);
sex = zscore(demoTable.Gender_Male);


DM = [SCZorSAD age sex connDat];



baseMdl = fitlm(DM,zscore(baselineBPND),'RobustOpts','on','VarNames',{'SCZ','age','sex','FC','Baseline'});


deltaMdl = fitlm(DM,zscore(deltaBPND),'RobustOpts','on','VarNames',{'SCZ','age','sex','FC','DeltaBPND'});





 