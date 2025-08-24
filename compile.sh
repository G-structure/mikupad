#!/bin/bash

if ! command -v node > /dev/null 2>&1; then
    echo "Node.js is not installed."
    exit 1
fi

if ! command -v npm > /dev/null 2>&1; then
    echo "npm is not installed."
    exit 1
fi

rm -f project/mikupad.html project/mikupad.css project/*.js project/importmap.json project/mikupad.importmap.json
cp -f mikupad.html mikupad.css importmap.json *.js project

cd project
npm install
npm run build
IMPORTMAP_JS=$(grep -l 'module.exports=JSON.parse' ./dist/mikupad*.js 2>/dev/null)
[ -n "$IMPORTMAP_JS" ] && rm -f "$IMPORTMAP_JS" "${IMPORTMAP_JS}.map"
cp -f ./dist/mikupad.html ../mikupad_compiled.html
cp -f ./dist/mikupad*.css ../mikupad_compiled.css
cp -f ./dist/mikupad*.js ../mikupad_compiled.js
cd ..
