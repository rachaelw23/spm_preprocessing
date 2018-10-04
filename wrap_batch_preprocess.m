%%adapted from https://github.com/ritcheym/fmri_misc/tree/master/batch_system

clear all;

%path setup
addpath(genpath('/usr/local/MATLAB/spm12/'))
scriptdir = '/mnt/keoki/experiments2/rachael/scripts/';
addpath(genpath('/mnt/keoki/experiments2/Graner/Data/SPM_Preprocessing_Things/Graner_Batch_Modules/'));
addpath(genpath(scriptdir)); 

% specify variables
outLabel = 'distext'; %output label
subjects = {'sub-01' 'sub-03' 'sub-06' 'sub-13' 'sub-16' 'sub-19' 'sub-26' 'sub-32' 'sub-34' 'sub-37' 'sub-43' 'sub-45' 'sub-48' 'sub-02' 'sub-05' 'sub-10' 'sub-14' 'sub-17' 'sub-20' 'sub-27' 'sub-33' 'sub-36' 'sub-38' 'sub-44' 'sub-46' 'sub-49'}; 
batch_functions = {'preprocessing_jobs'}; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% initialize error log
errorlog = {}; ctr=1;

% loop over subjects
    for i=1:length(subjects)
        fprintf('\nrunning subject %s...\n',subjects{i});

        % get subject-specific variables
        b = initialize_vars(subjects,i);

        % move to subject data folder
        cd(b.subjDir);

        %run matlabbatch job
        try

            %run current job function, passing along subject-specific inputs
            batch_output = eval(strcat(batch_functions{1},'(b)'));

            %save output (e.g., matlabbatch) for future reference
            outName = strcat(outLabel,'_',date,'_',batch_functions{1});
            save(outName, 'batch_output');

        catch err % if there's an error, take notes & move on
            errorlog{ctr,1} = subjects{i};
            errorlog{ctr,2} = batch_functions{1};
            errorlog{ctr,3} = err;
            ctr = ctr + 1;
            cd(scriptdir);
            continue;
        end

        cd(scriptdir);
    end


if ~isempty(errorlog)
    disp(errorlog) % print error log at end
else
    disp('no errors detected.');
end
