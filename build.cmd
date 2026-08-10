@echo off
REM Copyright 2026 Chen Jiaqi (GitHub: @H15teve)
REM Distributed under LPPL 1.3c or later; maintenance status: maintained.
REM Current Maintainer: Chen Jiaqi (GitHub: @H15teve).
REM This work consists of the files listed in LPPL-MANIFEST.txt.
setlocal enabledelayedexpansion
REM build.cmd - parameterized build entry
REM usage: build [target], e.g. build paper-example or build paper
REM use %~dp0 to locate script dir (project root), works from any cwd
set "SCRIPTDIR=%~dp0"
cd /d "%SCRIPTDIR%"

set "TARGET=%~1"
if "%TARGET%"=="" set "TARGET=paper-example"

if not exist "%TARGET%.tex" (
  echo FAIL: missing source "%TARGET%.tex"
  goto :err
)

echo Building %TARGET% ...
xelatex -interaction=nonstopmode -file-line-error -halt-on-error "%TARGET%.tex"
if errorlevel 1 goto :err

REM Any target that loads biblatex produces a .bcf and needs Biber.
REM This also supports copies renamed from paper-example.tex, e.g. build paper.
if exist "%TARGET%.bcf" (
  biber "%TARGET%"
  if errorlevel 1 goto :err
)

xelatex -interaction=nonstopmode -file-line-error -halt-on-error "%TARGET%.tex"
if errorlevel 1 goto :err
xelatex -interaction=nonstopmode -file-line-error -halt-on-error "%TARGET%.tex"
if errorlevel 1 goto :err

echo Build OK: %TARGET%.pdf
exit /b 0

:err
echo Build FAILED for %TARGET%
exit /b 1
