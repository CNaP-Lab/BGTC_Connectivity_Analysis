% script for generating effect sizes and p-values for continuous
% demographics variables

% Data Needed:
% demoTable: table of demographic variables

% data is available upon request via a formal data
% sharing agreement

% Used for results shown in Table 1 in Tubiolo, Williams et al. 2025

sczVar = logical(demoTable.SCZorSAD);

dataStruct = table2struct(demoTable);

pairNames = fieldnames(dataStruct);
pairNames(1) = [];

statsStruct = struct();

for i = 1:length(pairNames)
    thisData = [dataStruct.(pairNames{i})];

    thisHCdat = thisData(~sczVar);
    thisSCZdat = thisData(sczVar);


    test = 'Ranksum';
    p = ranksum(thisHCdat,thisSCZdat);


    effectSize = meanEffectSize(thisHCdat,thisSCZdat,'Effect','cohen');

    if p<0.05
        disp([pairNames{i} ' --- p = ' num2str(p)])
    end


    statsStruct.(pairNames{i}).test = test;
    statsStruct.(pairNames{i}).p = p;
    statsStruct.(pairNames{i}).HCmean = nanmean(thisHCdat);
    statsStruct.(pairNames{i}).SCZmean = nanmean(thisSCZdat);
    statsStruct.(pairNames{i}).HCstd = nanstd(thisHCdat);
    statsStruct.(pairNames{i}).SCZstd = nanstd(thisSCZdat);
    statsStruct.(pairNames{i}).effectSize = effectSize;



end
