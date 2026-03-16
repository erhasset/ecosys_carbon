# Ecosys Modeling of Carbon Fluxes at Old Woman Creek NERR

## Overview

This project uses the **process-based ecosystem model Ecosys** to simulate carbon gas fluxes (CO₂ and CH₄) in a temperate freshwater marsh at **Old Woman Creek National Estuarine Research Reserve (OWC NERR), Huron, Ohio, USA**.  

Wetland heterogeneity in hydrology and vegetation strongly influences biogeochemical processes. Since wetlands store significant global organic carbon and contribute substantially to methane emissions, accurately modeling these dynamics across space and time is critical.  

The study focused on **two hydrologically distinct areas** of the marsh:

1. **Main pool** – deeper, frequently flooded  
2. **Cove** – shallower, intermittently drying  

Multiple grid cells were used to represent heterogeneity and capture site-specific processes.

---

## Research Goals

The project aims to:

- Simulate ecosystem carbon gas fluxes (CO₂ and CH₄) using **Ecosys** from **2015–2023**, updated from previous evaluations that only observed the main pool from 2015 and 2016.
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
  ESS-DIVE Dataset  
  https://doi.org/10.15485/2229438

- Hassett E ; Villa J ; Bohrer G ; Kinsman-Costello L ; Eberhard E ; Carnevali J ; Brown M ; Martin S ; Morin T (2025)  
  Carbon flux measurements from chambers collected between April–October 2023 at Old Woman Creek, Huron, Ohio.  
  ESS-DIVE Dataset  
  https://doi.org/10.15485/3003419

### Eddy Covariance Data

- Bohrer, G., & Kerns, J. (2024)  
  AmeriFlux BASE US-OWC Old Woman Creek, Ver. 5-5  
  AmeriFlux AMP Dataset  
  https://doi.org/10.17190/AMF/1418679

### Supporting Publication

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

