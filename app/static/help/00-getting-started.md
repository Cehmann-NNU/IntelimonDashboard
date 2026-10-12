# Getting started

> Draft: parts of this page have not been written yet.

The IntELiMon Decision Support Tool provides access to data from the
**Interagency Ecosystem Lidar Monitoring Program (IntELiMon)**. Its purpose is
to translate the complex structural data produced by terrestrial laser
scanning (TLS) into actionable intelligence: metrics, graphs and model inputs
that support treatment planning, the evaluation of treatment effects and fire
behavior modeling. Beyond visualizing data, the tool provides pathways to
deeper analysis and to integration with other tools, including landscape
files for fire modeling, treelists for forest growth simulation and fire
behavior calculations for tracking change and treatment success.

<p class="help-warning"><strong>The fire models in the rothRmel tab should be
used for change tracking and treatment success purposes only. These models
have not been verified for use with custom fuel beds generated from
TLS.</strong></p>

## Rationale for TLS monitoring

Long-term monitoring records the outcomes of management actions, measures
progress toward objectives and indicates which long-term goals are attainable.
Conventional field methods rely on trained crews and rigorous protocols, and
their data quality and repeatability are frequently limited (Murphy et al.,
2024). TLS complements these methods by capturing the three-dimensional
structure of a plot at high resolution. A portable, push-button scanner,
calibrated with initial transect sampling, records forestry, fuels and
ecological features in under five minutes per plot. Because every scan is
collected and processed with the same protocol, the resulting data, terms and
methods are consistent across sites, agencies and jurisdictions.

IntELiMon processes each scan into hundreds of forestry, fuels and ecological
metrics. The Decision Support Tool brings these metrics together for selected
plots, places scans in time relative to treatments, and derives trends, fuel
loadings, stand data and fire behavior estimates without direct handling of
point clouds.

## Typical workflow

1. **Load Data** _(local installations only)_. Loading of IntELiMon output
   files from a local folder.
2. **Selection Map.** Plot selection and download of scan data.
3. **Set Treatments.** Entry of treatment dates, which separate pre- and
   post-treatment scans.
4. **Standard outputs.** Core structural metrics by plot and over time.
5. **Custom models.** Comparison of field-calibrated predictive model
   outputs.
6. **Fuels exports.** Review of scanned fuels, landscape files for fire
   modeling and submission of fuels to rothRmel.
7. **Forestry exports.** Stand metrics, thinning prescriptions and export to
   the Forest Vegetation Simulator (FVS).
8. **rothRmel.** Surface and crown fire behavior estimates for each scan over
   time.

## Notes

- Loaded data persist only for the current session. Reloading the page or
  navigating away clears them, so downloads and exports should be completed
  beforehand.
- The help pages are searchable from the box above the topic list.

## Contact

_Contact details go here._

## Reference

Murphy, M. C., Loudermilk, E. L., Pokswinski, S., et al. (2024). Terrestrial
3D laser scanning for ecosystem and fire effects monitoring. Gen. Tech. Rep.
SRS-277. Asheville, NC: U.S. Department of Agriculture, Forest Service,
Southern Research Station. 19 p. <https://doi.org/10.2737/SRS-GTR-277>
