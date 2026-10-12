# About

> Draft: parts of this page have not been written yet.

## IntELiMon

The Interagency Ecosystem Lidar Monitoring Program (IntELiMon) is a framework
for monitoring forests, shrublands and grasslands with terrestrial laser
scanning (TLS). A portable lidar scanner records the three-dimensional
structure of a plot in under five minutes, and an automated pipeline converts
each scan into standardized forestry, fuels, ecological and fire metrics.
Because every plot is scanned and processed with the same protocol, results
are comparable across sites, agencies and years, and before and after
treatments such as prescribed fire or thinning (Murphy et al., 2024).

The IntELiMon Decision Support Tool is the dashboard for these results. It
retrieves processed metrics from the IntELiMon API or from local files,
groups scans into time steps around treatment dates, and derives graphs, fuel
loadings, landscape files and fire behavior estimates from them.

Project website: [intelimon.xyz](https://intelimon.xyz)

## Field data collection

Each plot is recorded with **a single scan from plot center**, taken with a
Leica BLK360 mounted on a tripod approximately 1.5 m above the ground. A
reflective target on a pole approximately 12 m north of plot center records
the orientation of the scan. Scanning requires less than five minutes.

Scans are paired with transect sampling, which is used to calibrate and
validate the models that predict fuels and vegetation from the point cloud:

| Measurement | Method |
|---|---|
| Plot | 10 m radius, with two perpendicular 20 m transects through plot center (N-S and E-W) |
| Ground cover | Point intercept at 1 m intervals, 40 points per plot (each point = 2.5% cover) |
| Woody debris | Planar intercept tallies of 1, 10, 100 and 1000 hour fuels along the transects |
| Fuel bed, litter and duff depth | Four points, 4.5 m from plot center on each transect arm |
| Overstory | Trees of 10 cm DBH and larger, tallied by species in four quadrants |

Transect sampling requires approximately 30 to 60 minutes per plot. The full
protocol is described in Pokswinski et al. (2021).

## Processing and analysis

Scans are named by site, plot, date and scanner, checked for completeness,
and transferred to the USGS Earth Resources Observation and Science (EROS)
Center, where the processing pipeline runs (Pokswinski et al., 2026). The
pipeline performs the following steps for each scan:

1. **Point cloud preparation.** The cloud is cropped to a 15 m radius around
   the scanner, ground points are classified, noise is removed and heights
   are normalized to height above ground.
2. **Structure by height stratum.** Vegetation volume and leaf area are
   calculated for four strata: ground cover (0-1 m), understory (1-3 m),
   midstory (3-9 m) and overstory (above 9 m).
3. **Occlusion analysis.** Empty space is distinguished from space hidden
   behind vegetation, so that occluded areas are not interpreted as open
   canopy.
4. **Tree inventory.** Stems are detected and fitted to estimate DBH and
   height. Plot basal area, stems per acre and tree counts are corrected for
   trees obscured from the scanner.
5. **Canopy description.** Canopy base height, canopy cover and gap fraction
   are calculated.
6. **Surface fuel classification.** Shrubs, fine fuels and fine and coarse
   woody debris are classified.
7. **Predictive modeling.** Models trained on paired field and TLS data
   estimate quantities such as fuel cover, time-lag fuel counts, fuel and duff
   depths and hardwood and pine basal area. These outputs appear in the
   **Custom models** tab.

## Data access

Processed results are available through an online viewer and a programmatic
API; the Decision Support Tool uses the API. Related resources include
LANDFIRE layers queried by plot footprint, integration with FastFuels and
BurnPro3D for fire and fuel modeling, and **Points2Pano** panoramas of each
plot for comparison before and after treatment. IntELiMon open data are
released under the CC0-1.0 license.

## Supported by

- U.S. Geological Survey (USGS)
- U.S. Fish & Wildlife Service
- USDA Forest Service
- Bureau of Indian Affairs
- National Park Service
- SERDP / ESTCP

## Development team

_Names and organizations go here._

## Version

_Version number and release date go here._

## References

Murphy, M. C., Loudermilk, E. L., Pokswinski, S., et al. (2024). Terrestrial
3D laser scanning for ecosystem and fire effects monitoring. Gen. Tech. Rep.
SRS-277. Asheville, NC: U.S. Department of Agriculture, Forest Service,
Southern Research Station. 19 p. <https://doi.org/10.2737/SRS-GTR-277>

Pokswinski, S., Nelson, K., Maxwell, A., et al. (2026). IntELiMon: an
automated framework for standardized terrestrial lidar processing in
multi-disciplinary ecosystem monitoring. *Forestry: An International Journal
of Forest Research*, 99(5), cpag083.
<https://doi.org/10.1093/forestry/cpag083>

Pokswinski, S., Gallagher, M. R., Skowronski, N. S., et al. (2021). A
simplified and affordable approach to forest monitoring using single
terrestrial laser scans and transect sampling. *MethodsX*, 8, 101484.
<https://doi.org/10.1016/j.mex.2021.101484>

## Contact

_Contact details go here._
