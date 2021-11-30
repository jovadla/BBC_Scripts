```bash

# singularity build fmriprep
cd /mnt/data/jyothi/fmriprep/
singularity build /my_images/fmriprep-latest.simg docker://poldracklab/fmriprep:latest
singularity build $cd /mnt/data/jyothi/fmriprep/my_images/fmriprep-latest.simg docker://poldracklab/fmriprep:latest
singularity build fmriprep-20.2.3.simg docker://poldracklab/fmriprep:20.2.3

sudo singularity build fmriprep-20.2.3.simg docker://nipreps/fmriprep:20.2.3
datalad containers-add -d . fmriprep --url docker://nipreps/fmriprep:20.2.3
#set pwd = cd /mnt/data/jyothi/fmriprep/
bids_dir=`pwd`/inputs/raw
output_dir=`pwd`/derivatives
mkdir -p $output_dir
participants_labels=blndTRE037

datalad containers-run \
-m "fMRIprep on 1 $participants_labels" \
--explicit \
-i $bids_dir \
-o $output_dir \
-n .datalad/environments/fmriprep/image \
--participant_label $participants_labels \
--n_cpus 2 \
--output-spaces MNI152NLin6Asym \
--anat-only


-n .datalad/environments/fmriprep/image \
