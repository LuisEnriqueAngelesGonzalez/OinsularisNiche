# To install kuenm following the next steps
# install_packages("devtools")
# library(devtools)
# devtools::install_github("marlonecobos/kuenm")

library(kuenm)

# -------------------------------------------------------------------------
# Model calibration -------------------------------------------------------
# -------------------------------------------------------------------------

# Input files
occ_joint   <- "dataset/Oct_ins_joint.csv" # Joint data 
occ_tra     <- "dataset/Oct_ins_train.csv" # Training dafa
M_var_dir   <- "M_variables"      #follow the structure file (environmental variables)
batch_cal   <- "Candidate_models"
out_dir     <- "Candidate_Models"
reg_mult    <- c(seq(0.5, 4, 0.5)) # Regularization multiplier 
f_clas      <- c("l","lq","lqp", 'lqph')   # Features (linear, quadratic, product, hinge)
maxent_path <-  "maxent"
wait        <- FALSE
run         <- TRUE

kuenm_cal(occ.joint   = occ_joint, 
          occ.tra     = occ_tra, 
          M.var.dir   = M_var_dir, 
          batch       = batch_cal,
          out.dir     = out_dir, 
          reg.mult    = reg_mult, 
          f.clas      = f_clas, 
          maxent.path = maxent_path, 
          wait        = wait, run = run)

# After run the code above, select and open the file Candidate_models.bat in order to generate all the models that
# will be saved in the Candidate_Models folder.


# -------------------------------------------------------------------------
# Model selection ---------------------------------------------------------
# -------------------------------------------------------------------------

occ_test     <- "dataset/Oct_ins_test.csv"
out_eval     <- "Calibration_results"
threshold    <- 5         # omission rate
rand_percent <- 50        # related to partial ROC
iterations   <- 100       # number of iterations
kept         <- FALSE     # to keep (TRUE) or delete (FALSE) the candidate models 
selection    <- "OR_AICc"      # Omission rate and Delta Akaike
paral_proc   <- FALSE # make this true to perform pROC calculations in parallel, recommended
# only if a powerfull computer is used (see function's help)
# Note, some of the variables used here as arguments were already created for previous function

cal_eval <- kuenm_ceval(path          = out_dir, 
                        occ.joint     = occ_joint, 
                        occ.tra       = occ_tra, 
                        occ.test      = occ_test, 
                        batch         = batch_cal,
                        out.eval      = out_eval, 
                        threshold     = threshold, 
                        rand.percent  = rand_percent, 
                        iterations    = iterations,
                        kept          = FALSE, 
                        selection     = selection, 
                        parallel.proc = paral_proc)


### For replicate the results select only the model wirh lowest Delta Akaike
### value

# -------------------------------------------------------------------------
# Model Projections -------------------------------------------------------
# -------------------------------------------------------------------------

batch_fin   <- "Final_models"
mod_dir     <- "Final_Models"
rep_n       <- 1            #change the number of runs if you wish
rep_type    <- "Bootstrap"
jackknife   <- TRUE #Jacknife analysis
out_format  <- "logistic" # Type of output of the model
project     <- TRUE # Project model to scenarios
G_var_dir   <- "G_variables"   #here is the RCP scenarios (.asc)
ext_type    <- "ext"# We allow our model to extrapolate. See ext_type help
write_mess  <- TRUE # Generate MESS maps (extrapolation risk)
write_clamp <- TRUE
wait1       <- FALSE
run1        <- TRUE
args        <- NULL 


kuenm_mod(occ.joint   = occ_joint, 
          M.var.dir   = M_var_dir, 
          out.eval    = out_eval, 
          batch       = batch_fin, 
          rep.n       = rep_n,
          rep.type    = rep_type, 
          jackknife   = jackknife, 
          out.dir     = mod_dir, 
          out.format  = out_format, 
          project     = project,
          G.var.dir   = G_var_dir, 
          ext.type    = ext_type, 
          write.mess  = write_mess, 
          write.clamp = write_clamp, 
          maxent.path = maxent_path, 
          args        = args, 
          wait        = wait1, 
          run         = run1)

