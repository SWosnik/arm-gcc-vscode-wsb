# arm gcc toolchain with VSCode

1) Replace "E:\Temp\arm-gcc-vscode-wsb" in arm-gcc-vscode.wsb with the path where you copied the repository to. Windows sandbox expects absolute paths in the wsb file
2) Start windows sandbox by double-clicking on arm-gcc-vscode.wsb
3) When the sandbox is running, an explorer with the path of the batch file VSCodeEnvironment.cmd is automatically started.
4) Start VSCodeEnvironment.cmd. Get a coffee or two, the first start takes a long time as the complete arm toolchain
   including some utilities and VSCode as well as a sample repository have to be downloaded and installed.
   After this has been done, a command window appears.
   On subsequent runs of the sandbox, the files no longer need to be downloaded and the prompt appears more quickly.
5) In the command shell execute "code ." to start VSCode.