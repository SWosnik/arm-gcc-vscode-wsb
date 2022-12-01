![License](https://img.shields.io/github/license/SWosnik/MyApplicationTest)

# arm gcc toolchain with VSCode

1) Run build-arm-gcc-vscode-wsb.bat to create arm-gcc-vscode.wsb from
   arm-gcc-vscode.template. This replaces a placeholder in the template with the
   actual working path and writes the file as sandbox configuration
   arm-gcc-vscode.wsb. This is necessary because the windows
   sandbox only accepts absolute paths in the configuration file.
2) Start windows sandbox by double-clicking on arm-gcc-vscode.wsb
3) When the sandbox is running, an explorer with the path of the batch file
   VSCodeEnvironment.cmd is automatically started.
4) Start VSCodeEnvironment.cmd. Get a coffee or two, the first start takes a
   long time as the complete arm toolchain including some utilities and VSCode
   as well as a sample repository have to be downloaded and installed.
   After this has been done, a command window appears.
   On subsequent runs of the sandbox, the files no longer need to be downloaded
   and the prompt appears more quickly.
5) In the command shell execute "code ." to start VSCode.
