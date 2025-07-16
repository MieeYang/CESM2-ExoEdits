# CESM2-ExoEdits
This document discribes how to tune planetary parameters for exoplanets in CESM2. Specifically, it is tested under CESM version 2.1.1.

Different versions of CESM2 can be found at https://github.com/ESCOMP/CESM.git.

ExoCAM (https://github.com/storyofthewolf/ExoCAM.git) is a complete and widely tested package based on CESM1 and CAM4 designed for exoplanet simulations. This repo applies the features from ExoCAM to tune CESM2. It is still under construction. The current verison is only tested for different rotation periods of exoplanets.

Below are the steps:
1. Create a new case: Here we want to run a slab-ocean model with Earth's continents, so we choose compset ETEST and grid f19_g17.
<pre>
  ./create_newcase --compset ETEST --res f19_g17 --mach YOUR_MACHINE --compiler gnu --case CASEROOT --run-unsupported 
  cd CASEROOT
</pre>
2. Copy the folder `SourceMods` and the `user_nl_xxx` into CASEROOT.

In `user_nl_xxx`, CASEROOT should be the folder where inputfiles are located. The inputfiles can be found from NCAR sources. The inputfile used in the example case can be found from ExoCAM repo (https://github.com/storyofthewolf/ExoCAM.git).
