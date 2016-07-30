all: createmakedir getLeaflet getProj4Leaflet npmPull

createmakedir:
	mkdir make_modules
	
getLeaflet:
	rm -rf make_modules/leaflet/
	mkdir make_modules/leaflet
	wget http://cdn.leafletjs.com/leaflet/v1.0.0-rc.2/leaflet.zip
	unzip leaflet.zip -d make_modules/leaflet
	rm leaflet.zip
  
getProj4Leaflet:
	mkdir make_modules/proj4leaflet
	wget https://raw.githubusercontent.com/kartena/Proj4Leaflet/leaflet-proj-refactor/src/proj4leaflet.js 
	mv proj4leaflet.js make_modules/proj4leaflet/proj4leaflet.js

getLeafletHeat:
	mkdir make_modules/leafletHeat
	wget https://raw.githubusercontent.com/Leaflet/Leaflet.heat/gh-pages/src/HeatLayer.js 
	mv HeatLayer.js  make_modules/leafletHeat

npmPull:
	npm install