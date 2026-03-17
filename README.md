# Ecosys Modeling of Carbon Fluxes at Old Woman Creek NERR, Huron, Ohio, USA

## Overview
This manuscript has been accepted in Science of the Total Environment; Februrary 2026. 

This project uses the **process-based ecosystem model Ecosys** to simulate carbon gas fluxes (CO₂ and CH₄) in a temperate freshwater marsh at **Old Woman Creek National Estuarine Research Reserve (OWC NERR), Huron, Ohio, USA**.  

Wetland heterogeneity in hydrology and vegetation strongly influences biogeochemical processes. Since wetlands store significant global organic carbon and contribute substantially to methane emissions, accurately modeling these dynamics across space and time is critical.  

The study focused on **two hydrologically distinct areas** of the marsh:

1. **Main pool** – deeper, predominantly flooded  
2. **Cove** – shallower, intermittently dried  

Multiple grid cells were used to represent heterogeneity and capture site-specific processes in each area.

---

## Research Goals

The project aims to:

- Simulate ecosystem carbon gas fluxes (CO₂ and CH₄) using **ecosys** from **2015–2023**, updated from previous evaluations that only observed the main pool from 2015 and 2016.
- Evaluate model performance against **eddy covariance data** from the main pool (2015–2023) and **chamber flux measurements** from the cove (2022–2023).
- Use **Bayesian Optimization for Anything (BOA)** to derive optimized parameters for CO₂ and CH₄ processes in each zone.
- Assess the importance of **site-specific parameterization** and **multi-grid cell modeling** in reproducing observed flux patterns.

---

## Methods

- **Multiple grid cells** were used to account for spatial heterogeneity:
  - Main pool cells captured consistently flooded conditions and had a plant functional type similar to Typha spp.
  - Cove cells represented intermittently exposed sediments and had a plant functional type similar to a sedge-type grass.
- **Sequential Bayesian optimization runs** (4 in total) were conducted to refine model parameters for CO₂ and CH₄.
- Model outputs were compared with:
  - **Eddy covariance data** from the main pool  
  - **Chamber flux measurements** from the cove  

---

## Key Findings

- After parameter optimization, ecosys adequately reproduced hourly diurnal flux patterns in the main pool (**R² = 0.34 for CO₂, R² = 0.58 for CH₄**).  
- Applying main pool parameters directly to the cove resulted in poor predictions, overestimating CO₂ uptake and CH₄ release.  
- Site-specific parameterization for the cove improved model alignment with chamber measurements, though non-vegetated cell fluxes were less variable than vegetated cells.  
- Accurate modeling of carbon fluxes in heterogeneous wetlands requires a **multi-grid cell approach** and **localized parameterization**.

---

## Data Sources

### Chamber Flux Measurements

- Hassett E ; Villa J ; Onyango Y ; Eberhard E ; Bohrer G ; Kinsman-Costello L ; Morin T (2023)  
  Carbon flux measurements from chambers collected between July–October 2022 at Old Woman Creek, Huron, Ohio.  
  ESS-DIVE Dataset https://doi.org/10.15485/2229438

- Hassett E ; Villa J ; Bohrer G ; Kinsman-Costello L ; Eberhard E ; Carnevali J ; Brown M ; Martin S ; Morin T (2025)  
  Carbon flux measurements from chambers collected between April–October 2023 at Old Woman Creek, Huron, Ohio.  
  ESS-DIVE Dataset https://doi.org/10.15485/3003419

### Eddy Covariance Data from Ameriflux Site- OWC

- Bohrer, G., & Kerns, J. (2024)  
  AmeriFlux BASE US-OWC Old Woman Creek, Ver. 5-5  
  AmeriFlux AMP Dataset  
  https://doi.org/10.17190/AMF/1418679

### Supporting Publications

- Hassett, Erin, Gil Bohrer, Lauren Kinsman-Costello, Yvette Onyango, Talia Pope, Chelsea Smith, Justine Missik et al. "Changes in inundation drive carbon dioxide and methane fluxes in a temperate wetland." Science of the Total Environment 915 (2024): 170089.
- Morin, Timothy H., William J. Riley, Robert F. Grant, Zelalem Mekonnen, Kay C. Stefanik, A. Camilo Rey Sanchez, Molly A. Mulhare, Jorge Villa, Kelly Wrighton, and Gil Bohrer. "Water level changes in Lake Erie drive 21st century CO2 and CH4 fluxes from a coastal temperate wetland." Science of the Total Environment 821 (2022): 153087.

---

## Tools and Software

- **Ecosys** – process-based ecosystem model for carbon flux simulations  
  Source code: [Ecosys GitHub Repository](https://github.com/jinyun1tang/ECOSYS)

- **Bayesian Optimization for Anything (BOA)** – used for parameter optimization  
  Scyphers, M., Missik, J., Paulson, J., & Bohrer, G. (2024)  
  BOA scripts: [Zenodo Repository](https://doi.org/10.5281/zenodo.12797033)

---

## Repository Structure
```
ecosys_carbon/
├── README.md
├── cove/
│   ├── 020102022hc
│   ├── 020102023hc
│   ├── 030102022hc
│   ├── 030102023hc
│   ├── before_parameterization/
│   │   ├── 020102022hc
│   │   ├── 020102023hc
│   │   ├── 030102022hc
│   │   └── 030102023hc
│   ├── cove.Rmd
│   ├── open_obs_ecosys2.csv
│   ├── open_obs_ecosys2_CHANNEL.csv
│   ├── plant_obs_ecosys2.csv
│   ├── plant_obs_ecosys2_CHANNEL.csv
│   ├── soilrespiration_data22.csv
│   ├── soilrespiration_data23.csv
│   ├── trial_params_cove_CH4.csv
│   └── trial_params_cove_CO2.csv
├── flux_processing/
│   ├── Chamber_Timing_Check_ERIN.m
│   ├── ImportMetaDataSheet.m
│   ├── ProcessLI7810Chamber.m
│   ├── ReadLI7810.m
│   └── main.m
└── main_pool/
    ├── channel_ch4.Rmd
    ├── footprint_all.csv
    ├── obs_data.csv
    ├── trial_parameters_ch4.csv
    └── trial_parameters_co2.csv
```
## File descriptions

`Cove`: Run files from modeling carbon fluxes from the cove area at Old Woman Creek
- hourly carbon fles produced from ecosys in the plant (02010) and non-plant (03010) cells in 2022 and 2023.
- cove.rmd: R markdown file for processing and comparing ecosys model carbon fluxes and observed carbon fluxes (from eddy covariance flux tower on Ameriflux and chamber data). Note: files loaded into R but not present here are too large to upload to GitHub. Contact erhasset@syr.edu to acquire any missing datasets. 
- soilrespiration22 and soilrespiration23: final carbon fluxes from chambers collected in 2022 and 2023, with datasets published on ESS-DIVE
- trial_params_cove_CH4 and CO2: BOA output trials with RMSE
- before_parameterization`: hourly carbon text files from the plant cells (02010) and from the non-plant celss (03010) in 2022 and 2023, using final parameter values generated from BOA based on the main pool paramterization

`Main Pool`: Run files from modeling carbon fluxes from the main pool area at Old Woman Creek
- channel_ch4.Rmd: code for comparing ecosys model carbon fluxes to observed eddy covariance data 
- footprint_all.csv: footprint model output results for understanding the fetch of the eddy covariance tower
- obs_data.csv: observed data from Ameriflux
- trial_parameters_ch4.csv; trial_parameters_co2.csv: BOA output trials with RMSE

`Flux Processing`: Chamber flux processing in Matlab
- Data sheets for calculating carbon fluxes from the chambers colleted from OWC in 2023.
