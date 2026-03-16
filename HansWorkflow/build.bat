@echo off
chcp 65001 >nul
set SCRIPT_DIR=%~dp0
set PROJECT_DIR=%SCRIPT_DIR%..
set UNPACK_DIR=%SCRIPT_DIR%unpack_tool

echo ========================================
echo   Terraria Hans Build Tool
echo ========================================
echo.

echo [Step 1] Create and clean directories...
if not exist "%UNPACK_DIR%\work" mkdir "%UNPACK_DIR%\work"
if not exist "%UNPACK_DIR%\export" mkdir "%UNPACK_DIR%\export"
if not exist "%UNPACK_DIR%\import" mkdir "%UNPACK_DIR%\import"
if exist "%UNPACK_DIR%\export\*" del /q "%UNPACK_DIR%\export\*" 2>nul
if exist "%UNPACK_DIR%\import\*" del /q "%UNPACK_DIR%\import\*" 2>nul
if exist "%UNPACK_DIR%\work\*" del /q "%UNPACK_DIR%\work\*" 2>nul
echo [Done]

echo [Step 2] Copy JSON files...
copy /Y "%PROJECT_DIR%\zh-Hans*.json" "%UNPACK_DIR%\work\" 2>nul
echo [Done]

echo [Step 3] Copy Font files...
for %%d in (Combat_Crit Combat_Text Death_Text Item_Stack Mouse_Text) do (
    if exist "%PROJECT_DIR%\Font\%%d" for %%f in ("%PROJECT_DIR%\Font\%%d\*.*") do copy /Y "%%f" "%UNPACK_DIR%\work\" 2>nul
)
echo [Done]

echo [Step 4] Copy backup files...
if exist "%PROJECT_DIR%\backup_en" copy /Y "%PROJECT_DIR%\backup_en\*" "%UNPACK_DIR%\work\" 2>nul
if exist "%PROJECT_DIR%\backup_else" copy /Y "%PROJECT_DIR%\backup_else\*" "%UNPACK_DIR%\work\" 2>nul
echo [Done]

echo [Step 5] Copy config and origin...
copy /Y "%PROJECT_DIR%\backup_config\config.json" "%UNPACK_DIR%\" 2>nul
copy /Y "%SCRIPT_DIR%data.unity3d.origin" "%UNPACK_DIR%\" 2>nul
echo [Done]

echo.
echo [Step 6] Running unpack tool...
cd /d "%UNPACK_DIR%"
UnpackTerrariaTextAsset.exe -autowork

echo.
echo ========================================
echo   Build Complete
echo   Output: %UNPACK_DIR%\data.unity3d
echo ========================================
pause
