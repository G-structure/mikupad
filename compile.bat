@echo off

where node >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is not installed.
    exit /b 1
)
where npm >nul 2>&1
if %errorlevel% neq 0 (
    echo npm is not installed.
    exit /b 1
)

xcopy /y mikupad.html project >NUL
xcopy /y mikupad.css project >NUL

cd project
call npm install
call npm start build
copy /y .\dist\mikupad.html ..\mikupad_compiled.html
copy /y .\dist\mikupad*.css ..\mikupad_compiled.css
cd ..
