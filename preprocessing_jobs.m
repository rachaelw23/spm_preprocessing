function [matlabbatch] = preprocessing_jobs(b)
%% check for structural preprocessed outputs; if struct has been preprocessed, run func only;

if exist(b.finalAnat, 'file') == 2
    
    disp('structural preprocessed, running functional only...')
    
    %% expand frames
    matlabbatch{1}.spm.util.exp_frames.files = b.funcFullpath;
    matlabbatch{1}.spm.util.exp_frames.frames = Inf;
    %% slice timing correction
    matlabbatch{2}.spm.temporal.st.scans{1}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
    matlabbatch{2}.spm.temporal.st.nslices = 34;
    matlabbatch{2}.spm.temporal.st.tr = 2;
    matlabbatch{2}.spm.temporal.st.ta = 1.94117647058824;
    matlabbatch{2}.spm.temporal.st.so = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34];
    matlabbatch{2}.spm.temporal.st.refslice = 33;
    matlabbatch{2}.spm.temporal.st.prefix = 'a';
    %% motion correction: realign - estimate and reslice
    matlabbatch{3}.spm.spatial.realign.estwrite.data{1}(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 1)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.sep = 4;
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.rtm = 0;
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.interp = 2;
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.weight = '';
    matlabbatch{3}.spm.spatial.realign.estwrite.roptions.which = [2 1];
    matlabbatch{3}.spm.spatial.realign.estwrite.roptions.interp = 4;
    matlabbatch{3}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{3}.spm.spatial.realign.estwrite.roptions.mask = 1;
    matlabbatch{3}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
     %% coregistration of functional to structural
    matlabbatch{4}.spm.spatial.coreg.estimate.ref(1) = b.anatSkullStrippedNative;
    matlabbatch{4}.spm.spatial.coreg.estimate.source(1) = cfg_dep('Realign: Estimate & Reslice: Mean Image', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','rmean'));
    matlabbatch{4}.spm.spatial.coreg.estimate.other(1) = cfg_dep('Realign: Estimate & Reslice: Resliced Images (Sess 1)', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','rfiles'));
    matlabbatch{4}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
    matlabbatch{4}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
    matlabbatch{4}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{4}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7]; 
    %% normalize functional
    matlabbatch{5}.spm.util.defs.comp{1}.def(1) = b.deformationField;
    matlabbatch{5}.spm.util.defs.comp{2}.id.space = {'/mnt/keoki/experiments2/Graner/Data/SPM_Preprocessing_Things/SPM_batch_templates/EPI_resamp.nii'};
    matlabbatch{5}.spm.util.defs.out{1}.pull.fnames(1) = b.raFilename;
    matlabbatch{5}.spm.util.defs.out{1}.pull.savedir.saveusr = {b.funcDir};
    matlabbatch{5}.spm.util.defs.out{1}.pull.interp = 4;
    matlabbatch{5}.spm.util.defs.out{1}.pull.mask = 1;
    matlabbatch{5}.spm.util.defs.out{1}.pull.fwhm = [0 0 0];
    matlabbatch{5}.spm.util.defs.out{1}.pull.prefix = '';
else
    
    disp('preprocessing structural and functional...')
    
    %% expand frames
    matlabbatch{1}.spm.util.exp_frames.files = b.funcFullpath;
    matlabbatch{1}.spm.util.exp_frames.frames = Inf;
    %% slice timing correction
    matlabbatch{2}.spm.temporal.st.scans{1}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
    matlabbatch{2}.spm.temporal.st.nslices = 34;
    matlabbatch{2}.spm.temporal.st.tr = 2;
    matlabbatch{2}.spm.temporal.st.ta = 1.94117647058824;
    matlabbatch{2}.spm.temporal.st.so = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34];
    matlabbatch{2}.spm.temporal.st.refslice = 33;
    matlabbatch{2}.spm.temporal.st.prefix = 'a';
    %% motion correction: realign - estimate and reslice
    matlabbatch{3}.spm.spatial.realign.estwrite.data{1}(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 1)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.sep = 4;
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.rtm = 0;
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.interp = 2;
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
    matlabbatch{3}.spm.spatial.realign.estwrite.eoptions.weight = '';
    matlabbatch{3}.spm.spatial.realign.estwrite.roptions.which = [2 1];
    matlabbatch{3}.spm.spatial.realign.estwrite.roptions.interp = 4;
    matlabbatch{3}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{3}.spm.spatial.realign.estwrite.roptions.mask = 1;
    matlabbatch{3}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
    %% CAT12 - segmentation, create deformation fields
    matlabbatch{4}.spm.tools.cat.estwrite.data = b.anatFullpath;
    matlabbatch{4}.spm.tools.cat.estwrite.nproc = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.opts.tpm = {'/usr/local/MATLAB/spm12/tpm/TPM.nii'};
    matlabbatch{4}.spm.tools.cat.estwrite.opts.affreg = 'mni';
    matlabbatch{4}.spm.tools.cat.estwrite.opts.biasstr = 0.5;
    matlabbatch{4}.spm.tools.cat.estwrite.opts.samp = 3;
    matlabbatch{4}.spm.tools.cat.estwrite.opts.redspmres = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.segmentation.APP = 1070;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.segmentation.NCstr = -Inf;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.segmentation.LASstr = 0.5;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.segmentation.gcutstr = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.segmentation.cleanupstr = 0.5;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.segmentation.WMHC = 1;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.segmentation.SLC = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.segmentation.restypes.fixed = [1 0.1];
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.registration.darteltpm = {'/usr/local/MATLAB/spm12/toolbox/cat12/templates_1.50mm/Template_1_IXI555_MNI152.nii'};
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.registration.shootingtpm = {'/usr/local/MATLAB/spm12/toolbox/cat12/templates_1.50mm/Template_0_IXI555_MNI152_GS.nii'};
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.registration.regstr = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.vox = 1.5;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.surface.pbtres = 0.5;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.surface.scale_cortex = 0.7;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.surface.add_parahipp = 0.1;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.surface.close_parahipp = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.admin.ignoreErrors = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.admin.verb = 2;
    matlabbatch{4}.spm.tools.cat.estwrite.extopts.admin.print = 2;
    matlabbatch{4}.spm.tools.cat.estwrite.output.surface = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.ROImenu.atlases.neuromorphometrics = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.ROImenu.atlases.lpba40 = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.ROImenu.atlases.cobra = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.ROImenu.atlases.hammers = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.ROImenu.atlases.ibsr = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.ROImenu.atlases.aal = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.ROImenu.atlases.mori = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.ROImenu.atlases.anatomy = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.GM.native = 1;
    matlabbatch{4}.spm.tools.cat.estwrite.output.GM.warped = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.GM.mod = 1;
    matlabbatch{4}.spm.tools.cat.estwrite.output.GM.dartel = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.WM.native = 1;
    matlabbatch{4}.spm.tools.cat.estwrite.output.WM.warped = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.WM.mod = 1;
    matlabbatch{4}.spm.tools.cat.estwrite.output.WM.dartel = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.CSF.native = 1;
    matlabbatch{4}.spm.tools.cat.estwrite.output.CSF.warped = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.CSF.mod = 1;
    matlabbatch{4}.spm.tools.cat.estwrite.output.CSF.dartel = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.WMH.native = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.WMH.warped = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.WMH.mod = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.WMH.dartel = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.SL.native = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.SL.warped = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.SL.mod = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.SL.dartel = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.atlas.native = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.atlas.dartel = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.label.native = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.label.warped = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.label.dartel = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.bias.native = 1;
    matlabbatch{4}.spm.tools.cat.estwrite.output.bias.warped = 1;
    matlabbatch{4}.spm.tools.cat.estwrite.output.bias.dartel = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.las.native = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.las.warped = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.las.dartel = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.jacobian.warped = 0;
    matlabbatch{4}.spm.tools.cat.estwrite.output.warps = [1 1];
    %% image calculator - combine GM,WM,CSF masks into native brain mask
    matlabbatch{5}.spm.util.imcalc.input(1) = cfg_dep('CAT12: Segmentation: p1 Image', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{1}, '.','p', '()',{':'}));
    matlabbatch{5}.spm.util.imcalc.input(2) = cfg_dep('CAT12: Segmentation: p2 Image', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{2}, '.','p', '()',{':'}));
    matlabbatch{5}.spm.util.imcalc.input(3) = cfg_dep('CAT12: Segmentation: p3 Image', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{3}, '.','p', '()',{':'}));
    matlabbatch{5}.spm.util.imcalc.output = 'skullstrip_masking.img';
    matlabbatch{5}.spm.util.imcalc.outdir = {b.anatDir};
    matlabbatch{5}.spm.util.imcalc.expression = 'i1+ i2 + i3';
    matlabbatch{5}.spm.util.imcalc.var = struct('name', {}, 'value', {});
    matlabbatch{5}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{5}.spm.util.imcalc.options.mask = 0;
    matlabbatch{5}.spm.util.imcalc.options.interp = 1;
    matlabbatch{5}.spm.util.imcalc.options.dtype = 4;
    %% image calculator - apply brain mask to native anatomical T1 image for skull stripping
    matlabbatch{6}.spm.util.imcalc.input(1) = cfg_dep('CAT12: Segmentation: Native Bias Corr. Image', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','biascorr', '()',{':'}));
    matlabbatch{6}.spm.util.imcalc.input(2) = cfg_dep('Image Calculator: ImCalc Computed Image: skullstrip_masking.img', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
    matlabbatch{6}.spm.util.imcalc.output = 'anat_skullstripped.img';
    matlabbatch{6}.spm.util.imcalc.outdir = {b.anatDir};
    matlabbatch{6}.spm.util.imcalc.expression = 'i1.*(i2>0)';
    matlabbatch{6}.spm.util.imcalc.var = struct('name', {}, 'value', {});
    matlabbatch{6}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{6}.spm.util.imcalc.options.mask = 0;
    matlabbatch{6}.spm.util.imcalc.options.interp = 1;
    matlabbatch{6}.spm.util.imcalc.options.dtype = 4;
    %% coregistration of functional to anatomical
    matlabbatch{7}.spm.spatial.coreg.estimate.ref(1) = cfg_dep('Image Calculator: ImCalc Computed Image: anat_skullstripped.img', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
    matlabbatch{7}.spm.spatial.coreg.estimate.source(1) = cfg_dep('Realign: Estimate & Reslice: Mean Image', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','rmean'));
    matlabbatch{7}.spm.spatial.coreg.estimate.other(1) = cfg_dep('Realign: Estimate & Reslice: Resliced Images (Sess 1)', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','rfiles'));
    matlabbatch{7}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
    matlabbatch{7}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
    matlabbatch{7}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{7}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
    %% normalize functional
    matlabbatch{8}.spm.util.defs.comp{1}.def(1) = cfg_dep('CAT12: Segmentation: Deformation Field', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','fordef', '()',{':'}));
    matlabbatch{8}.spm.util.defs.comp{2}.id.space = {'/mnt/keoki/experiments2/Graner/Data/SPM_Preprocessing_Things/SPM_batch_templates/EPI_resamp.nii'};
    matlabbatch{8}.spm.util.defs.out{1}.pull.fnames(1) = b.raFilename;
    matlabbatch{8}.spm.util.defs.out{1}.pull.savedir.saveusr = {b.funcDir};
    matlabbatch{8}.spm.util.defs.out{1}.pull.interp = 4;
    matlabbatch{8}.spm.util.defs.out{1}.pull.mask = 1;
    matlabbatch{8}.spm.util.defs.out{1}.pull.fwhm = [0 0 0];
    matlabbatch{8}.spm.util.defs.out{1}.pull.prefix = 'w';
    %% normalize anatomical
    matlabbatch{9}.spm.util.defs.comp{1}.def(1) = cfg_dep('CAT12: Segmentation: Deformation Field', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','fordef', '()',{':'}));
    matlabbatch{9}.spm.util.defs.out{1}.pull.fnames(1) = cfg_dep('Image Calculator: ImCalc Computed Image: anat_skullstripped.img', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
    matlabbatch{9}.spm.util.defs.out{1}.pull.savedir.saveusr = {b.anatDir};
    matlabbatch{9}.spm.util.defs.out{1}.pull.interp = 4;
    matlabbatch{9}.spm.util.defs.out{1}.pull.mask = 1;
    matlabbatch{9}.spm.util.defs.out{1}.pull.fwhm = [0 0 0];
    matlabbatch{9}.spm.util.defs.out{1}.pull.prefix = 'w';
end
%% run batch

spm('defaults','fmri')
spm_jobman('initcfg')
spm_jobman('run',matlabbatch)

end

