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

# Overleaf may compile a copy of the example under a user-chosen main-file
# name (for example output.tex).  biblatex then asks for output.bbl rather
# than paper-example.bbl.  Provide that job-name alias before XeLaTeX starts;
# never overwrite a user's existing bibliography file.
my $csee_jobname = $root_filename || '';
if (!$csee_jobname) {
  for my $csee_arg (@ARGV) {
    next if $csee_arg =~ /^-/;
    if ($csee_arg =~ m{(?:^|[\\/])([^\\/]+)\.tex\z}i) {
      $csee_jobname = $1;
      last;
    }
  }
}
if (!$csee_run_biber && $csee_jobname && $csee_jobname ne 'paper-example') {
  my $csee_preview_bbl = 'paper-example.bbl';
  my $csee_job_bbl = "$csee_jobname.bbl";
  if (-e $csee_preview_bbl && !-e $csee_job_bbl) {
    require File::Copy;
    File::Copy::copy($csee_preview_bbl, $csee_job_bbl)
      or warn "csee: cannot copy $csee_preview_bbl to $csee_job_bbl: $!\n";
  }
}
