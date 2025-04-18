% script for generating effect sizes for categorical and dichotomous
% demographics variables

% Data Needed:
% demoTable: table of demographic variables

% data is available upon request via a formal data
% sharing agreement

% Used for results shown in Table 1 in Tubiolo, Williams et al. 2025

% NOTE: this script uses the following publicly available MATLAB package:
% (https://github.com/hhentschke/measures-of-effect-size-toolbox)

sczVar = logical(demoTable.SCZorSAD);

% sex
allSex = demoTable.Gender_Male;
maleSCZ = sum(allSex(sczVar));
maleHC = sum(allSex(~sczVar));
femaleSCZ = sum(sczVar) - maleSCZ;
femaleHC = sum(~sczVar) - maleHC;

sexTable = [maleHC femaleHC; maleSCZ femaleSCZ];

sexV = mestab(sexTable);

% smoker
allSmoker = demoTable.Smoker;
smokeSCZ = nansum(allSmoker(sczVar));
smokeHC = nansum(allSmoker(~sczVar));
nosmokeSCZ = sum(sczVar(~isnan(allSmoker(sczVar)))) - smokeSCZ;
nosmokeHC = sum(~sczVar(~isnan(allSmoker(~sczVar)))) - smokeHC;

smokeTable = [smokeHC nosmokeHC; smokeSCZ nosmokeSCZ];

smokeV = mestab(smokeTable);

% smoker
allEth = demoTable.Ethnicity_Hispanic;
ethSCZ = nansum(allEth(sczVar));
ethHC = nansum(allEth(~sczVar));
noEthSCZ = sum(sczVar(~isnan(allEth(sczVar)))) - ethSCZ;
noEthHC = sum(~sczVar(~isnan(allEth(~sczVar)))) - ethHC;

ethTable = [ethHC noEthHC; ethSCZ noEthSCZ];

ethV = mestab(ethTable);

% handedness
allHand = demoTable.Handedness_Right;
leftSCZ = sum(allHand(sczVar)==0);
rightSCZ = sum(allHand(sczVar)==1);
ambiSCZ = sum(allHand(sczVar)==0.5);
leftHC = sum(allHand(~sczVar)==0);
rightHC = sum(allHand(~sczVar)==1);
ambiHC = sum(allHand(~sczVar)==0.5);

handTable = [leftHC rightHC ambiHC; leftSCZ rightSCZ ambiSCZ];



handV = mestab(handTable);

% race
caucSCZ = sum(demoTable.Caucasian(sczVar));
caucHC = sum(demoTable.Caucasian(~sczVar));
afroSCZ = sum(demoTable.African_American(sczVar));
afroHC = sum(demoTable.African_American(~sczVar));
asiaSCZ = sum(demoTable.Asian(sczVar));
asiaHC = sum(demoTable.Asian(~sczVar));
otherSCZ = sum(demoTable.Other_Unknown(sczVar));
otherHC = sum(demoTable.Other_Unknown(~sczVar));
multiSCZ = sum(demoTable.More_than_one_race(sczVar));
multiHC = sum(demoTable.More_than_one_race(~sczVar));

raceTable = [caucHC afroHC asiaHC otherHC multiHC; caucSCZ afroSCZ asiaSCZ otherSCZ multiSCZ];

raceV = mestab(raceTable);
