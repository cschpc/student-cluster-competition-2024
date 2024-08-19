---
title: Introduction to ICON climate model
author: Jussi Enkovaara, CSC - IT Center for Science
date:   SCC 24
lang:   en
---

# Introduction to ICON

- Icosahedral Nonhydrostatic Weather and Climate Model
- Next generation modeling system capable of global simulations down to 1km resolutions
- Rewrite of earlier weather model in in the early 2000s
    - 1 600 000 lines of modern Fortran
- Developed my several meteorology institutes
    - DWD, MPI-M, MeteoSwiss, ...
    - ~200 developers
- Operational weather forecasts since 2015

# Climate and weather modeling

<div class="column" style=width:62%>
- Behaviour of the earth system (atmosphere and ocean) can in
principle be determined from Navier-Stokes equations driven by the
radiation from sun
- Chaotic nature of equations makes weather prediction difficult for
more than few days.
- In climate modeling one is interested in statistics, which makes
multidecadal simulations feasible.
</div>

<div class="column" style=width:35%>
<center>
![](/home/jenkovaa/Documents/DestinE/PASC24/presentation/img/clouds_sfcwind1.png){width=70%}
<br>
<small> 
Simulation by ICON
<br>
Visualization Niklas Röber, NVIDIA 
</small>
</center>
</div>

# Climate modeling

- Differential equations are discretized in a grid
- Even though simulation is started from specific initial conditions,
  climate modeling is fundamentally a boundary value problem
    - same stable climate will develop during the "spin-up" phase.
- In addition to fundamental physical laws, climate and weather models
  contain parametrizations for physical processes that cannot be
  presented on the grid resolution
- Prognostic variable: directly integrated from basic equations
- Diagnostic variable: derived from prognostic ones


# Model setup

<div class="column" style=width:60%>
- The most important simulation parameter is the horizontal grid
    - Determines the accuracy of simulation
    - Most variables are also presented in vertical levels
- ICON includes models for atmosphere, land, and ocean, and coupling
between them
    - In this exercise we will use only atmosphere and land components.
</div>
<div class="column" style=width:35%>
![](/home/jenkovaa/Documents/DestinE/PASC24/presentation/img/ICON-ESM-model.png){.center width=90%}
</div>

# Grid nomenclature in ICON

- R2B4: 160 km resolution
- R2B5: 80 km resolution
- ...
- R2B11: 1.2 km resolution

- Model performance is often measured as simulated days per day (SDPD)
    - "holy grail" is 365 SDPD or better
- Stable time step is directly proportional to grid resolution, R2B5
  requires two times smaller time step than R2B4
    - limits severely weak scaling

# Input data in ICON

- Various model parameters
- Initial weather conditions
- Horizontal grid and number of vertical levels
- Ozone content, aerosols, and greenhouse gases in the atmosphere
- Sea surface temperatures and sea ice (especially without ocean)
- Various land related boundary conditions

# Building and running ICON

- ICON has some dependencies that may need to be installed separately
  (eccodes, netcdf, ...)
- Build settings are determined in "config" scripts.
- ICON is normally run via "runscripts", i.e. shell scripts which
  contain both the batch job settings and the whole model setup
- ICON can perform I/O asynchronously
    - set of MPI processes is reserved for I/O so that output can be
      written to disk concurrently to computing
    - Maybe tuning parameter in the competition?  