@echo off
if NOT EXIST "C:\users\WDAGUtilityAccount\Downloads\VSCode.zip" (
  curl -L "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-archive" --output C:\users\WDAGUtilityAccount\Downloads\vscode.zip
)


if NOT EXIST "C:\users\WDAGUtilityAccount\Downloads\arm-none-eabi.zip" (
  curl -L "https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-mingw-w64-i686-arm-none-eabi.zip" --output C:\users\WDAGUtilityAccount\Downloads\arm-none-eabi.zip
)

REM get make
if NOT EXIST "C:\users\WDAGUtilityAccount\Downloads\make-bin.zip" (
  curl -L https://gnuwin32.sourceforge.net/downlinks/make-bin-zip.php --output C:\users\WDAGUtilityAccount\Downloads\make-bin.zip
)

if NOT EXIST "C:\users\WDAGUtilityAccount\Downloads\make-dep.zip" (
  curl -L https://gnuwin32.sourceforge.net/downlinks/make-dep-zip.php --output C:\users\WDAGUtilityAccount\Downloads\make-dep.zip
)

REM get utils
if NOT EXIST "C:\users\WDAGUtilityAccount\Downloads\utils-bin.zip" (
  curl -L https://gnuwin32.sourceforge.net/downlinks/coreutils-bin-zip.php --output C:\users\WDAGUtilityAccount\Downloads\utils-bin.zip
)

if NOT EXIST "C:\users\WDAGUtilityAccount\Downloads\utils-dep.zip" (
  curl -L https://gnuwin32.sourceforge.net/downlinks/coreutils-dep-zip.php --output C:\users\WDAGUtilityAccount\Downloads\utils-dep.zip
)


REM get git
if NOT EXIST "C:\users\WDAGUtilityAccount\Downloads\MinGit.zip" (
  curl -L https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/MinGit-2.38.1-64-bit.zip --output C:\users\WDAGUtilityAccount\Downloads\MinGit.zip
)

REM get commandline unzip
if NOT EXIST "C:\users\WDAGUtilityAccount\Downloads\unzip-bin.zip" (
  curl -L https://gnuwin32.sourceforge.net/downlinks/unzip-bin-zip.php --output C:\users\WDAGUtilityAccount\Downloads\unzip-bin.zip
)

if NOT EXIST "C:\bin\unzip" (
  REM unzip unzip
  PowerShell -Command "Expand-Archive -LiteralPath C:\users\WDAGUtilityAccount\Downloads\unzip-bin.zip -DestinationPath C:\bin\unzip"
)

REM add unzip path
where /Q unzip.exe
IF ERRORLEVEL 1 set PATH=c:\bin\unzip\bin;%PATH%

if NOT EXIST "C:\bin\make" (
  unzip -o C:\users\WDAGUtilityAccount\Downloads\make-bin.zip -d C:\bin\make
  unzip -o C:\users\WDAGUtilityAccount\Downloads\make-dep.zip -d C:\bin\make
)

REM add make to path
where /Q make.exe
IF ERRORLEVEL 1 set PATH=c:\bin\make\bin;%PATH%

if NOT EXIST "C:\bin\utils" (
  unzip -o C:\users\WDAGUtilityAccount\Downloads\utils-bin.zip -d C:\bin\utils
  unzip -o C:\users\WDAGUtilityAccount\Downloads\utils-dep.zip -d C:\bin\utils
)

REM add make to path
where /Q gmkdir.exe
IF ERRORLEVEL 1 set PATH=c:\bin\utils\bin;%PATH%

if NOT EXIST "C:\bin\git" (
  REM unzip git
  unzip -o C:\users\WDAGUtilityAccount\Downloads\MinGit.zip -d C:\bin\git
)


REM add git to path
where /Q git.exe
IF ERRORLEVEL 1 set PATH=c:\bin\git\cmd;%PATH%

REM add rm to path
where /Q rm.exe
IF ERRORLEVEL 1 set PATH=c:\bin\git\usr\bin;%PATH%

if NOT EXIST "c:\bin\arm-gnu-toolchain" (
  REM unzip toolchain
  unzip -o C:\users\WDAGUtilityAccount\Downloads\arm-none-eabi.zip -d c:\bin\
  REM rename tools-Path
  move c:\bin\arm-gnu-* c:\bin\arm-gnu-toolchain
)

REM add toolchain to path
where /Q arm-none-eabi-gcc.exe
IF ERRORLEVEL 1 set PATH=c:\bin\arm-gnu-toolchain\bin;%PATH%

if NOT EXIST "C:\bin\vscode" (
  REM extract VSCODE
  unzip -o C:\users\WDAGUtilityAccount\Downloads\vscode.zip -d C:\bin\vscode
)

if NOT EXIST "%AppData%\Roaming\Code\User\settings.json" (
  REM No Welcome Display
  mkdir %AppData%\Code\User
  echo { "workbench.startupEditor": "none" } > %AppData%\Code\User\settings.json
)

REM add vscode to path
where /Q code.exe
IF ERRORLEVEL 1 set path=c:\bin\vscode;%PATH%

cd C:\Users\WDAGUtilityAccount\Documents\Projects\

if NOT EXIST "STM32-Template" (
  git.exe clone --recurse-submodules https://github.com/SWosnik/STM32-Template.git
)

cd STM32-Template\Demo

cmd.exe /K dir