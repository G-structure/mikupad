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

del /q project\mikupad.html project\mikupad.css project\*.js project\importmap.json project\mikupad.importmap.json 2>nul
xcopy /y mikupad.html project >NUL
xcopy /y mikupad.css project >NUL
xcopy /y *.js project >NUL
xcopy /y importmap.json project >NUL

cd project
call npm install
call npm run build
for %%f in (dist\mikupad*.js) do (
    findstr /C:"module.exports=JSON.parse" "%%f" >nul && (
        del "%%f"
        del "%%f.map" 2>nul
    )
)
copy /y .\dist\mikupad.html ..\mikupad_compiled.html
copy /y .\dist\mikupad*.css ..\mikupad_compiled.css
copy /y .\dist\mikupad*.js ..\mikupad_compiled.js
cd ..
