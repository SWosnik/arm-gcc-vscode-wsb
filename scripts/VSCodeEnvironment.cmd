@echo off
REM This batch installs the arm-gcc toolchain, including several tools like make, git and rm
REM under windows 10. The tools ar only installed if they are not found in the path.

set DOWNLOAD_DIR=C:\users\WDAGUtilityAccount\Downloads
set BIN_DIR=C:\bin
set WORKSPACE_DIR=C:\Users\WDAGUtilityAccount\Documents\Projects

REM check if unzip is in the path
where /Q unzip.exe
IF ERRORLEVEL 1 (
  REM check if rm dir exists
  if NOT EXIST "%BIN_DIR%\unzip" (
    REM download commandline unzip if needed
    if NOT EXIST "%DOWNLOAD_DIR%\unzip-bin.zip" (
      echo Download unzip
      curl -L https://gnuwin32.sourceforge.net/downlinks/unzip-bin-zip.php --output %DOWNLOAD_DIR%\unzip-bin.zip
    )
    REM unzip unzip
    echo unzip unzip
    PowerShell -Command "Expand-Archive -LiteralPath %DOWNLOAD_DIR%\unzip-bin.zip -DestinationPath %BIN_DIR%\unzip"
  )
  REM add unzip path
  echo Add unzip to path
  set PATH=%BIN_DIR%\unzip\bin;%PATH%
)

REM check if vcode is in the path
where /Q code.exe
IF ERRORLEVEL 1 (
  REM check if vcode dir exists
  if NOT EXIST "%BIN_DIR%\vscode" (
    REM Download vcode if needed
    if NOT EXIST "%DOWNLOAD_DIR%\VSCode.zip" (
      echo Download Visual Studio Code
      curl -L "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-archive" --output %DOWNLOAD_DIR%\vscode.zip
    )

    REM extract VSCODE
    echo unzip Visual Studio Code
    unzip -o %DOWNLOAD_DIR%\vscode.zip -d %BIN_DIR%\vscode
    REM check if vcode settings exist and if not: generate a default
    if NOT EXIST "%AppData%\Roaming\Code\User\settings.json" (
      REM No Welcome Display
      mkdir %AppData%\Code\User
      echo { "workbench.startupEditor": "none" } > %AppData%\Code\User\settings.json
    )
  )
  REM add VSCode to path
  echo Add Visual Studio Code to path
  set path=%BIN_DIR%\vscode;%PATH%
)

REM check if arm-none-eabi-gcc is in the path
where /Q arm-none-eabi-gcc.exe
IF ERRORLEVEL 1 (
  REM check if arm-gnu-toolchain dir exists
  if NOT EXIST "%BIN_DIR%\arm-gnu-toolchain" (
    REM Download toolchain if needed
    if NOT EXIST "%DOWNLOAD_DIR%\arm-none-eabi.zip" (
      echo arm gcc compiler toolchain
      curl -L "https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-mingw-w64-i686-arm-none-eabi.zip" --output %DOWNLOAD_DIR%\arm-none-eabi.zip
    )
    echo unzip toolchain
    REM unzip toolchain
    unzip -o %DOWNLOAD_DIR%\arm-none-eabi.zip -d %BIN_DIR%\
    REM rename tools-Path
    move %BIN_DIR%\arm-gnu-* %BIN_DIR%\arm-gnu-toolchain
  )

  REM add toolchain to path
  echo Add toolchain to path
  set PATH=%BIN_DIR%\arm-gnu-toolchain\bin;%PATH%
)

where /Q make.exe
REM check if make is in the path
IF ERRORLEVEL 1 (
  REM check if make dir exists
  if NOT EXIST "%BIN_DIR%\make" (
    REM get make if needed
    if NOT EXIST "%DOWNLOAD_DIR%\make-bin.zip" (
      echo Download make
      curl -L https://gnuwin32.sourceforge.net/downlinks/make-bin-zip.php --output %DOWNLOAD_DIR%\make-bin.zip
    )
    if NOT EXIST "%DOWNLOAD_DIR%\make-dep.zip" (
      curl -L https://gnuwin32.sourceforge.net/downlinks/make-dep-zip.php --output %DOWNLOAD_DIR%\make-dep.zip
    )
    REM and unzip
    echo unzip make
    unzip -o %DOWNLOAD_DIR%\make-bin.zip -d %BIN_DIR%\make
    unzip -o %DOWNLOAD_DIR%\make-dep.zip -d %BIN_DIR%\make
  )
  REM add make to path
  echo Add make to path
  set PATH=%BIN_DIR%\make\bin;%PATH%
)

where /Q gmkdir.exe
REM check if utils are in the path
IF ERRORLEVEL 1 (
  if NOT EXIST "%BIN_DIR%\utils" (
    REM get utils
    if NOT EXIST "%DOWNLOAD_DIR%\utils-bin.zip" (
      echo Download ultilities
      curl -L https://gnuwin32.sourceforge.net/downlinks/coreutils-bin-zip.php --output %DOWNLOAD_DIR%\utils-bin.zip
    )

    if NOT EXIST "%DOWNLOAD_DIR%\utils-dep.zip" (
      curl -L https://gnuwin32.sourceforge.net/downlinks/coreutils-dep-zip.php --output %DOWNLOAD_DIR%\utils-dep.zip
    )

    echo unzip utils
    unzip -o %DOWNLOAD_DIR%\utils-bin.zip -d %BIN_DIR%\utils
    unzip -o %DOWNLOAD_DIR%\utils-dep.zip -d %BIN_DIR%\utils
  )
  REM add utils to path
  echo Add utils to path
  set PATH=%BIN_DIR%\utils\bin;%PATH%
)

REM add git to path
where /Q git.exe
IF ERRORLEVEL 1 set (
  if NOT EXIST "%BIN_DIR%\git" (
    REM get git
    if NOT EXIST "%DOWNLOAD_DIR%\MinGit.zip" (
      echo Download git
      curl -L https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/MinGit-2.38.1-64-bit.zip --output %DOWNLOAD_DIR%\MinGit.zip
    )
    echo unzip git
    REM unzip git
    unzip -o %DOWNLOAD_DIR%\MinGit.zip -d %BIN_DIR%\git
  )
  echo Add git to path
  PATH=%BIN_DIR%\git\cmd;%PATH%
)

REM get the Demo-Project
echo goto %WORKSPACE_DIR%
cd %WORKSPACE_DIR%

if NOT EXIST "STM32-Template\Demo" (
  echo Get the Demo Code
  git.exe clone --recurse-submodules https://github.com/SWosnik/STM32-Template.git
)

cd STM32-Template\Demo
echo You may call make to build or "code ." to edit
cmd /C code . ../../Readme.md
cmd.exe /K dir