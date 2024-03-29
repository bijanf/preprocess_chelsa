#!/bin/bash 
#=============================================
#code to prepare the obs_hist,sim_hist,sim_fut
# and cut the domain for the Target
#=============================================
#SBATCH --qos=short
#SBATCH --partition=standard
#SBATCH --account=gvca
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --job-name=gvcabasd
#SBATCH --output=slogs/out.%j
#SBATCH --error=slogs/out.%j
module load nco 
module load cdo 

set -ex 

# header of the chelsa
#header="chelsa-w5e5v1.0_obsclim_"
header="2m_dewpoint_temperature_ERA5-Land_"
# suffix: 
#suffix="_30arcsec_global_daily_"
#suffix="_300arcsec_global_daily_"
#suffix="_90arcsec_global_daily_"
suffix=""
res_obs="300" # in arcsecond
#chelsa_dir="/p/projects/proclias/1km/data/chelsa_w5e5/nc/"
#chelsa_dir="/p/projects/proclias/1km/data/chelsa_w5e5/aggregate/300arcsec/"
chelsa_dir="/p/projects/climate_data_central/reanalysis/ERA5-Land/2m_dewpoint_temperature/"
out_dir_intermediate="./data/"

lat0=33.25 #first lat
lat1=56.75 #second lat
lon0=45.25 #first lon
lon1=90.75 #second lon
#var="tas"
for var in pr rsds tasmax tasmin 
do 
 echo "variable is "$var
for year in {1981..2014}
do 
        echo "The year is "$year
        for mon in {01..12}
        do 
            echo "The month is "$mon
            #ncks -O -d lat,${lat0},${lat1} -d lon,${lon0},${lon1} ${chelsa_dir}${header}${var}${suffix}${year}${mon}.nc ${out_dir_intermediate}${header}${var}${suffix}${year}${mon}_lat${lat0}_${lat1}_lon${lon0}_${lon1}_cut.nc
	    ncks -O -d lat,${lat0},${lat1} -d lon,${lon0},${lon1} ${chelsa_dir}${header}${var}${suffix}${year}${mon}.nc ${out_dir\
_intermediate}${header}${var}${suffix}${year}${mon}_lat${lat0}_${lat1}_lon${lon0}_${lon1}_cut.nc

        done
 done #year
done #var
#####################################################################
# now cut the domain from ISIMIP biaes adjusted and downscaled data : 
######################################################################
isimip_data="/p/projects/isimip/isimip/ISIMIP3b/InputData/climate/atmosphere/bias-adjusted/global/daily/"




