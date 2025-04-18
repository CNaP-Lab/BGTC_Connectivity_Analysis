% Script for assessing group differences in ROI pair connectivity
% Data Needed: 
% demoTable: table of demographics including diagnosis
% dataTable: table of ROI pair correlations

% data for both variables is available upon request via a formal data
% sharing agreement

% Used for results shown in Figures 2, S5,and S6 in Tubiolo, Williams et al. 2025

sczVar = logical(demoTable.SCZorSAD);

dataStruct = table2struct(dataTable);

pairNames = fieldnames(dataStruct);
pairNames(1) = [];

statsStruct = struct();

for i = 1:length(pairNames)
    thisData = [dataStruct.(pairNames{i})];

    thisHCdat = thisData(~sczVar);
    thisSCZdat = thisData(sczVar);

    HClilly = lillietest(thisHCdat);
    SCZlilly = lillietest(thisSCZdat);


    if HClilly + SCZlilly >= 1
        test = 'Ranksum';
        p = ranksum(thisHCdat,thisSCZdat);
    else
        test = 'ttest';
        [~,p,~] = ttest2(thisHCdat,thisSCZdat,'vartype','unequal');
    end

    effectSize = meanEffectSize(thisHCdat,thisSCZdat,'Effect','cohen');

    if p<0.05
        disp([pairNames{i} ' --- p = ' num2str(p)])
    end


    statsStruct.(pairNames{i}).test = test;
    statsStruct.(pairNames{i}).p = p;
    statsStruct.(pairNames{i}).HCmean = nanmean(thisHCdat);
    statsStruct.(pairNames{i}).SCZmean = nanmean(thisSCZdat);
    statsStruct.(pairNames{i}).effectSize = effectSize;

    
end
