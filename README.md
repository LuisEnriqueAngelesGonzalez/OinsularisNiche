# OinsularisNiche
Code to replicate the paper "Global climate changes over time shape the environmental niche distribution of Octopus insularis in the Atlantic Ocean"


In order to replicate the results, open the OinsularisNiche.Rproj and you have to follow the order provided in the code folder:

        0_auxiliar_functions.R (You do not need to run this code. It will be called from the following scripts).
        1_niche_model_maxent.R
        2_binary_maps.R

All the scripts have comments for an easy understanding of the process.

Nevertheless, you need to download maxent sofware from https://biodiversityinformatics.amnh.org/open_source/maxent/. After that you have to create a folder named maxent, inside this folder there will be: maxent.bat, maxent.jar, maxent.sh, readme.txt.

Also, you need to install kuenm package. Please follow the instructions provided in this link: https://github.com/marlonecobos/kuenm
If you want to replicate the maps or other plots of the paper contact to Luis Enrique Angeles-González (luis.angeles0612@gmail.com).
If you find any problem in the code, please add this at the Issues section of the github.


For Mac users:
Before install the kuenm package, follow these instructions to install Xcode on your Mac: https://clanfear.github.io/CSSS508/docs/compiling.html  
Xcode will replace RTools.
