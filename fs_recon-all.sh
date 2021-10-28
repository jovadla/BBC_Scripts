You might need to start the docker daemon: sudo docker
```bash
#!/bin/bash

# set pwd = cd /mnt/data/jyothi/fmriprep/
## freesurfer licence
sudo systemctl start docker
freesurfer_license=~/Documents/fs_license/license.txt

### PARTICIPANTS

## for one participant
   #participants_labels=blndTRE028

## for several subjects filter according to a pattern
   #pattern=inputs/raw/sub-*COP[01][0123456789]
   #participants_labels=ls -d $pattern | sed s@inputs/raw/sub-@@g

## adapted from advice given here https://github.com/nipreps/fmriprep/issues/1199
## Best to run fmriprep on subjects 1 by 1
  for sub in $(find ./inputs/raw/ -maxdepth 2 -name  'sub-*HOL*' -type d); do
    participants_labels=$( basename $sub)

# This will run fMRIprep anat mode only
bids_dir='pwd'/inputs/raw
output_dir='pwd'/derivatives
mkdir -p $output_dir
docker run -it --rm \
  -v $freesurfer_license:/license.txt \
  -v $bids_dir:/data:ro \
  -v $output_dir:/out \
  nipreps/fmriprep:20.2.3 /data/ /out/ \
  participant --participant_label $participants_labels \
  --fs-license-file /license.txt \
  --nprocs 12 --nthreads 12 --n_cpus 12 --n-cpus 12 \
  --output-spaces T1w:res-native MNI152NLin2009cAsym:res-native fsaverage\
  --anat-only
