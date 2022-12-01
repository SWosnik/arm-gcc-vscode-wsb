@echo off
echo build arm-gcc-vscode.wsb
SET mypath=%~dp0
powershell -Command "(gc arm-gcc-vscode.template) -replace '<WORKDIR/>', '%~dp0' | Out-File -encoding ASCII arm-gcc-vscode.wsb"