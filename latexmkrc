# Copyright 2026 Chen Jiaqi (GitHub: @H15teve)
# Distributed under LPPL 1.3c or later; maintenance status: maintained.
# Current Maintainer: Chen Jiaqi (GitHub: @H15teve).
# This work consists of the files listed in LPPL-MANIFEST.txt.

# biblatex/logreq changes only this status flag after the PDF is already
# stable. Ignoring that one line prevents an unnecessary final XeLaTeX run
# while all auxiliary, citation, cross-reference, and other XML changes remain
# tracked by latexmk.
$hash_calc_ignore_pattern{'xml'} =
  '^\s*<internal package="biblatex" priority="9" active="[01]">';

# Overleaf Free preview mode. Keep this at 0 for normal writing so latexmk
# reuses the bundled paper-example.bbl and stays below the 10-second limit.
# Temporarily change it to 1 after editing refs.bib, or set the
# CSEE_RUN_BIBER=1 environment variable in CI, to refresh the bibliography.
$csee_run_biber = 0;
$csee_run_biber = 1 if $ENV{'CSEE_RUN_BIBER'};
$bibtex_use = $csee_run_biber ? 1 : 0;
