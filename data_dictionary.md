# Data Dictionary — `cats_parasite_dataset.csv`

87 rows, one per free-roaming cat sampled in the Long Island University TNR program (New York City, May–July 2023).

| Variable | Type | Units / Coding | Description |
|---|---|---|---|
| `animal_id` | string | F1, F2, … F99 | Unique within-study identifier (no PHI). |
| `latitude_2dp` | numeric | decimal degrees, 2 dp | Trap latitude rounded to ~1 km grid (privacy). |
| `longitude_2dp` | numeric | decimal degrees, 2 dp | Trap longitude rounded to ~1 km grid (privacy). |
| `sex` | factor | M / F / blank | Sex (M = male, F = female). Blank = not recorded in field. |
| `age_class` | factor | K / J / A / blank | K = kitten (<6 mo), J = juvenile (6–12 mo), A = adult (≥12 mo). |
| `lactating` | factor | Y / N / blank | Lactation status (females only). |
| `pregnant` | factor | Y / N / blank | Pregnancy status (females only). |
| `fecal_weight_g` | numeric | grams | Mass of fecal aliquot processed by Wisconsin double centrifugation. |
| `toxocara_count` | integer | eggs | Total Toxocara cati eggs counted on entire coverslip. |
| `toxocara_epg` | numeric | eggs/g | toxocara_count / fecal_weight_g. |
| `ancylostoma_count` | integer | eggs | Total Ancylostoma spp. eggs counted on entire coverslip. |
| `ancylostoma_epg` | numeric | eggs/g | ancylostoma_count / fecal_weight_g. |
| `coccidia_count` | integer | oocysts | Total coccidia oocysts counted on entire coverslip. |
| `coccidia_epg` | numeric | oocysts/g | coccidia_count / fecal_weight_g. |
| `trichuris_count` | integer | eggs | Trichuris spp. egg count (all 0 in this study). |
| `giardia_antigen` | factor | Y / blank | ProSpecT Giardia coproantigen ELISA, n = 43 tested. Blank = not tested. |
| `cryptosporidium_antigen` | factor | Y / blank | ProSpecT Cryptosporidium coproantigen ELISA, n = 43 tested. Blank = not tested. |
| `toxoplasma_serology` | factor | Y / blank | Modified agglutination test (MAT) ≥ 1:25, n = 45 tested. Blank = not tested. |

## Missing-data conventions

- For fecal flotation parasites (`toxocara_*`, `ancylostoma_*`, `coccidia_*`, `trichuris_*`), an empty cell denotes a **negative result** for that parasite (no eggs detected on the coverslip).
- For antigen and serology variables, an empty cell denotes **not tested** (sample volume insufficient or assay not run on that subset).
- Demographic blanks denote **not recorded in the field**.

## Denominators used in the manuscript

| Diagnostic method | n |
|---|---|
| Wisconsin double-centrifugation flotation | 87 |
| Coproantigen ELISA (Giardia, Cryptosporidium) | 43 |
| Modified agglutination test (Toxoplasma gondii) | 45 |
| Heartworm antigen ELISA | 45 |
| Cytauxzoon felis qPCR (whole blood) | 45 |

## Analytical age grouping

The R analysis collapses age class into a binary variable for risk-factor models:

- **Young** = K + J (i.e., < 1 year old).
- **Adult** = A (≥ 1 year old).

Reference levels for modelling: Adult (age) and Female (sex).
