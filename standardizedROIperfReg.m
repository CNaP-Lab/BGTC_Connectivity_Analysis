function [fitmdl] = standardizedROIperfReg(connVar,demoTable)
% function for generating standardized regression coefficients for a
% multiple linear regression predicting WM task performance from
% task-state functional connectivity .

% connVar: vector of ROI pair connectivity values
% demoTable: table of demographics containing task performance and covariates
% (available upon request via formal data sharing agreement)

% Used for results shown in Figure 4 in Tubiolo, Williams et al. 2025


sczVar = logical(demoTable.SCZorSAD);
perfVar = demoTable.SOT_K;
ageVar = zscore(demoTable.Age);
sexVar = zscore(demoTable.Gender_Male);


zscored_conn = (connVar - nanmean(connVar))./nanstd(connVar);


zscoredSCZ = zscore(sczVar);

DM = [ageVar sexVar zscoredSCZ zscored_conn];


fitmdl = fitlm(DM,zscore(perfVar),'RobustOpts','on','VarNames',{'age','gender','SCZ','FC','K'});

end

