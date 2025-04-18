% script for generating standardized regression coefficients for a
% multiple linear regression predicting neuromelanin contrast ratio in psychosis-associated voxels
% within the substantia nigra from task-state functional connectivity .

% Data Needed:
%
% avg_psych_vox: vector of average NM contrast ratio values within
% psychosis-associated voxels for each subject
%
% scan_key: table of demographics and ROI pair connectivity values

% data is available upon request via a formal data
% sharing agreement

% Used for results shown in Figure 3 in Tubiolo, Williams et al. 2025

connVar = scan_key.LATERAL__DCa_GPe;
connDat = zscore(connVar);


SCZorSAD = zscore(scan_key.SCZorSAD);

age = zscore(scan_key.Age);
sex = zscore(scan_key.Gender_Male);


DM = [SCZorSAD age sex connDat];

NMfitMdl = fitlm(DM,zscore(avg_psych_vox),'RobustOpts','on','VarNames',{'SCZ','age','sex','FC','NMsignal'});
