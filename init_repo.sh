#!/usr/bin/env bash
###############################################################################
# init_repo.sh
# One-shot script to initialise the GitHub + Zenodo deposit for
# PONE-D-26-00846 (NYC free-roaming cats parasitology, Nguyen et al. 2026)
#
# Prerequisites
#   - git installed
#   - GitHub CLI (`gh`) installed and authenticated:  brew install gh && gh auth login
#   - You have a Zenodo account at https://zenodo.org and have linked it to
#     GitHub:  Zenodo → Settings → GitHub → toggle ON for the new repo
#
# Run from inside data_and_code/:
#   chmod +x init_repo.sh
#   ./init_repo.sh
###############################################################################

set -euo pipefail

REPO_NAME="nyc-cat-parasites"
REPO_DESC="Data and analysis code for Nguyen, Gurtowski, Chen, Rosen & Kafle (2026), PLOS ONE"
GH_USER="$(gh api user --jq .login 2>/dev/null || echo YOUR-GITHUB-USERNAME)"

echo "==> Initialising local git repository in $(pwd)"
git init -q
git checkout -q -b main

echo "==> Writing .gitignore"
cat > .gitignore <<'EOF'
# R
.Rhistory
.RData
.Rproj.user/
*.Rproj

# OS
.DS_Store
Thumbs.db

# Outputs
output/
*.tif
*.png
*.pdf
EOF

echo "==> Writing CITATION.cff (so GitHub shows a 'Cite this repository' button)"
cat > CITATION.cff <<EOF
cff-version: 1.2.0
message: "If you use these data or code, please cite the associated publication and the dataset."
title: "Zoonotic endoparasites and Toxoplasma gondii seropositivity in free-roaming cats from New York City, USA — data and code"
authors:
  - family-names: Nguyen
    given-names: Van-Lan
  - family-names: Gurtowski
    given-names: Emily
  - family-names: Chen
    given-names: Joyce
  - family-names: Rosen
    given-names: Maria
  - family-names: Kafle
    given-names: Pratap
    orcid: "https://orcid.org/0000-0000-0000-0000"   # <-- replace with your ORCID
date-released: 2026-04-28
license: CC-BY-4.0
license-url: "https://creativecommons.org/licenses/by/4.0/"
url: "https://github.com/${GH_USER}/${REPO_NAME}"
preferred-citation:
  type: article
  title: "Zoonotic endoparasites and Toxoplasma gondii seropositivity in free-roaming cats (Felis catus) from New York City, USA"
  authors:
    - family-names: Nguyen
      given-names: Van-Lan
    - family-names: Gurtowski
      given-names: Emily
    - family-names: Chen
      given-names: Joyce
    - family-names: Rosen
      given-names: Maria
    - family-names: Kafle
      given-names: Pratap
  journal: "PLOS ONE"
  year: 2026
EOF

echo "==> Staging and committing"
git add .
git commit -q -m "Initial deposit: data and analysis code for PONE-D-26-00846

- cats_parasite_dataset.csv  (n = 87 free-roaming cats, NYC, 2023-2024)
- analysis.R                 (reproduces Tables 1-2 and all statistical tests)
- data_dictionary.md         (column-by-column variable definitions)
- README.md                  (usage instructions and reproducibility notes)
- LICENSE                    (CC BY 4.0 for data; MIT for code)
- CITATION.cff               (machine-readable citation)

Figure 1 was prepared in QGIS 3.34 (OpenStreetMap Standard + CARTO Positron
basemap tiles over public-domain shapefiles) and is uploaded with the
manuscript; the QGIS project file and shapefiles are not redistributed here."

echo
echo "==> Creating GitHub repository and pushing"
gh repo create "${REPO_NAME}" --public --description "${REPO_DESC}" --source=. --remote=origin --push

echo
echo "==> Tagging v1.0.0 (this triggers the Zenodo DOI mint, if linked)"
git tag -a v1.0.0 -m "Initial public release accompanying PLOS ONE submission PONE-D-26-00846"
git push origin v1.0.0

cat <<'EOF'

==============================================================================
DONE.

Next manual steps:
  1. Go to https://zenodo.org/account/settings/github/  and confirm the
     ${REPO_NAME} repo is toggled ON.
  2. Refresh the Zenodo dashboard — a draft deposit will appear under
     "Upload" with the v1.0.0 release. Open it.
  3. Fill in any missing metadata (orcid, funders, keywords) and click
     "Publish".  A DOI of the form 10.5281/zenodo.XXXXXXX is minted.
  4. Paste that DOI into:
        - Revision_2026/Data_Availability_Statement.md  (replace <DOI>)
        - The PLOS ONE submission form, "Data Availability" field
        - The Acknowledgments / Data Availability section of the manuscript
  5. (Optional) Add the Zenodo DOI badge to README.md:
        [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXXXXX.svg)](https://doi.org/10.5281/zenodo.XXXXXXX)
==============================================================================
EOF
