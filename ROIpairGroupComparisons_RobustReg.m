% script for generating standardized regression coefficients for a
% multiple linear regression predicting ROI pair functional connectivity 
% from diagnosis and covariates.

% Data Needed: 
% demoTable: table of demographics including diagnosis
% dataTable: table of ROI pair correlations

% data is available upon request via a formal data
% sharing agreement

% Used for results shown in Table S1 in Tubiolo, Williams et al. 2025

sczVar = logical(demoTable.SCZorSAD);

connVar = dataTable.LATERAL__DCa_GPe;
ageVar = demoTable.Age;
sexVar = demoTable.Gender_Male;


DM = [zscore(sczVar) zscore(ageVar) zscore(sexVar)];

zscored_conn = (connVar - nanmean(connVar))./nanstd(connVar);

fitmdl = fitlm(DM,zscored_conn,'RobustOpts','on','VarNames',{'SCZ','age','sex','FC'});

