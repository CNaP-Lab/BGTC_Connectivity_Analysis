function [fitmdl] = patients_standardPANSSreg(connVar,demoTable)
% function for generating standardized regression coefficients for a
% multiple linear regression predicting PANSS PS and NS scores from
% functional connectivity in patients with schizophrenia, only.

% connVar: vector of ROI pair connectivity values
% demoTable: table of demographics containing PANSS scores and covariates
% (available upon request via formal data sharing agreement)

% Used for results shown in Figure 4 in Tubiolo, Williams et al. 2025

    sczVar = logical(demoTable.SCZorSAD);
    nanSX = isnan(demoTable.PANSS_PS);
    

    PS = zscore(demoTable.PANSS_PS(~nanSX&sczVar));
    NS = zscore(demoTable.PANSS_NS(~nanSX&sczVar));

    meanCenterSCZ = zscore(sczVar(~nanSX));



    ageVar = zscore(demoTable.Age(~nanSX&sczVar));

    sexVar = zscore(demoTable.Gender_Male(~nanSX&sczVar));

    DM_predictSymptoms = [ageVar sexVar zscore(connVar(~nanSX&sczVar))];

    fitmdl.fitmdl_predictPS = fitlm(DM_predictSymptoms,PS,'RobustOpts','on','VarNames',{'Age','Sex','FC','PS'});
    fitmdl.fitmdl_predictNS = fitlm(DM_predictSymptoms,NS,'RobustOpts','on','VarNames',{'Age','Sex','FC','NS'});

end

