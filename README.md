# NYC Free-Roaming Cats Parasite Dataset

This repository contains the de-identified data and analysis code accompanying:

> Nguyen V-L, Gurtowski E, Chen J, Rosen M, Kafle P. *Zoonotic endoparasites and Toxoplasma gondii seropositivity in free-roaming cats (Felis catus) from New York City, USA*. PLOS ONE (in revision, 2026). Manuscript ID PONE-D-26-00846.

Corresponding author: Pratap Kafle (kafle@rowan.edu), Shreiber School of Veterinary Medicine, Rowan University.

## Contents

| File | Description |
|---|---|
| `cats_parasite_dataset.csv` | Per-animal de-identified dataset (n = 87) used in all analyses. |
| `analysis.R` | R script that reproduces every prevalence estimate, risk-factor result, and intensity model in the paper (Tables 1 and 2). |
| `data_dictionary.md` | Variable definitions, units, allowed values, and missing-data conventions. |
| `LICENSE` | CC-BY 4.0 (data) / MIT (code). |

Figure 1 (sampling map) was prepared in **QGIS 3.34** from public-domain shapefiles (NYC borough/county boundaries — New York State GIS Clearinghouse; state boundaries — U.S. Census TIGER/Line 2022) overlaid with OpenStreetMap Standard and CARTO Positron XYZ tiles for context. The QGIS project file (`Fig1_PLOS.qgz`) and the input shapefiles live in the manuscript's `gis/QGIS_new/` folder and are *not* part of this data deposit; the figure itself (`Fig01_PLOS.tiff`) is uploaded as a manuscript figure file with the PLOS ONE submission.

## Reproducing the analysis

```r
# In R (>= 4.3):
install.packages(c("MASS", "dplyr", "broom", "here", "binom"))
setwd("path/to/this/folder")
source("analysis.R")
```

Outputs (Table 1, Table 2) are written to `output/tables/`.

## Notes on data

- **Trap coordinates** have been rounded to two decimal places (~1 km) to protect colony locations and prevent targeted disturbance of free-roaming cat colonies. The full-precision coordinates are retained by the corresponding author and are available on reasonable request, subject to a data-use agreement.
- **Demographic missingness** is real, not redacted: 28 cats had incomplete demographic records due to field-trapping conditions and are denoted by empty cells in `sex`, `age_class`, `lactating`, and `pregnant`.
- **Diagnostic-method denominators** are not 87 for every parasite. Coproantigen ELISA (Giardia, Cryptosporidium) was performed on n = 43; serology (Toxoplasma gondii) on n = 45; PCR (Cytauxzoon felis) on n = 45. The remaining cells are NA, not negative.

## Citation

If you use this dataset or code, please cite the published paper and this archive (DOI to be inserted upon Zenodo deposition).

## License

- Data: Creative Commons Attribution 4.0 International (CC BY 4.0).
- Code: MIT License.
