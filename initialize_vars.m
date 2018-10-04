function [b] = initialize_vars(subjects,i)

% SPM info
b.spmDir = fileparts(which('spm'));         % filepath to SPM installation

% directory and nifti information
dataDir = '/mnt/keoki/experiments2/rachael/data/distext/';
session = '/ses-day1';
b.curSubj = subjects{i};
b.subjDir = strcat(dataDir,b.curSubj,session);
b.funcDir = strcat(dataDir,b.curSubj,session,'/func','/');  % subject specific functional directory
b.anatDir = strcat(dataDir,b.curSubj,session,'/anat','/');  % sbuject specific anatomical directory
b.funcFilename = dir(strcat(b.funcDir,'sub*rest_run-01_bold.nii'));
b.anatFilename = dir(strcat(b.anatDir,'*ses-day1_T1w.nii'));
b.funcFullpath = strcat(b.funcDir, { b.funcFilename.name }); % full filepath of resting state scan
b.anatFullpath = strcat(b.anatDir, { b.anatFilename.name }); % full fielpath of T1 anatomical scan
b.raFilename = {strcat(b.funcDir,'ra',b.funcFilename.name)}; % realigned/resliced images (for some reason deformations for func does not work with the dependency)

end
 
