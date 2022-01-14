EXTRACT AREAL PRECIPITACION OF RAIN4PE GRIDED DATA 
================

[![GitHub
commit](https://img.shields.io/github/last-commit/cCornejoR/RAIN4PE_Extract)](https://github.com/cCornejoR/RAIN4PE_Extract/comits/master)


Repository to download the daily information of the RAIN4PE gridded product in an areal way and plot monthly and annual information
with the HydroTSM library.

## RAIN4PE DATA

RAIN4PE is a novel daily gridded precipitation dataset obtained by merging multi-source precipitation data (satellite-based Climate Hazards Group InfraRed Precipitation, CHIRP (Funk et al. 2015), reanalysis ERA5 (Hersbach et al. 2020), and ground-based precipitation) with terrain elevation using the random forest regression method. Furthermore, RAIN4PE is hydrologically corrected using streamflow data in catchments with precipitation underestimation through reverse hydrology. Hence, RAIN4PE is the only gridded precipitation product for Peru and Ecuador, which benefits from maximum available in-situ observations, multiple precipitation sources, elevation data, and is supplemented by streamflow data to correct the precipitation underestimation over páramos and montane catchments.

# Download data
- RAIN4PE daily data [(RAIN4PE_daily_0.1d_1981_2015_v1.0.nc)](https://doi.org/10.5880/pik.2020.010)

# Plot 1 - data of year 1981
![RAIN4PE_1981](https://user-images.githubusercontent.com/94501911/149381091-dd3aa0f9-b67d-424e-94e1-8f5319e31346.png)

# Plot 2 - Information extraction by basin geometry
![plot1](https://user-images.githubusercontent.com/94501911/149381006-7a3cdd94-ad6b-4e18-9038-afd44e322a3a.png)

# Plot 3 - Daily to monthly and anual time series
![Daily_to_Mensual_and_Anual](https://user-images.githubusercontent.com/94501911/149381129-d7f991b5-151a-4a3f-a270-1bbf3957207c.png)

# Plot 4 - Anual precipitacion on basin
![Anual_pp_tumbes_basin](https://user-images.githubusercontent.com/94501911/149456724-a1f402ea-696c-4c67-9be2-d7304ccff1fd.png)


# Plot 5 - Anomalies index of multianual precipitacion data
![Anomalias_anuales_Tumbes_basin_1981_2015](https://user-images.githubusercontent.com/94501911/149427169-64db8cef-86c4-4541-92dd-714943c9fbd5.png)


## REFERENCES
- [A novel high-resolution gridded precipitation dataset for Peruvian and Ecuadorian watersheds – development and hydrological evaluation](https://doi.org/10.1175/JHM-D-20-0285.1)

