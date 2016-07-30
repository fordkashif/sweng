<edgemap>
  <style scoped>
    :scope {
      /*position:absolute;*/
      /*left: 0;*/
      /*right:0;*/
      /*height: 400px;*/
      display: block;
      background-color: grey;
      transition: left .05s ease-in-out .05s;
      position: fixed; left:0; right:0; top:0;bottom:0;
    }
    :scope.disp {left: 450px; transition: left .05s ease-in-out .05s}
    #edgemapdiv {
      left: 0px;
      right: 0px;
      height: 100%;
      opacity: 1;
    }
     
  </style>
  
  <div id="edgemapdiv" onkeypress={ kp }></div>

  <script type="coffeescript">
  jad2k1 = '+proj=lcc +lat_1=18 +lat_0=18 +lon_0=-77 +k_0=1 +x_0=750000 +y_0=650000 +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'
  xform = proj4(jad2k1)
  proj4.defs("EPSG:3448", "+proj=lcc +lat_1=18 +lat_0=18 +lon_0=-77 +k_0=1 +x_0=750000 +y_0=650000 +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");
  mapoptions = 
    maxBounds: L.latLngBounds({lon: -78.5, lat: 17.15},{lon: -76.0, lat: 18.70})
    center: lon: -77, lat: 18.15
    zoom: 5 
    minZoom: 9
    maxZoom: 20
    attributionControl: no
    zoomControl: no
  L.Icon.Default.imagePath = '/images'
  
  base = {
    'osm': L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",{opacity: .85, maxZoom: 19})
    'out': L.tileLayer("https://{s}.tile.thunderforest.com/outdoors/{z}/{x}/{y}.png")
    'cdb': L.tileLayer("http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png")
    }
  @map = L.map(@edgemapdiv,mapoptions)
  fix = (inob) ->
    qq = 
      "type" : "Feature"
      "crs": 
        "type": "name"
        "properties": 
          "name": "urn:ogc:def:crs:EPSG::3448"
      "properties": 
        "gid": inob["GID"].toString()
      "geometry":
        "type": inob["type"]
        "coordinates": inob["coordinates"]
        
  holder = {
    "type": "Feature",
    "properties": {"gid": "holder" },
    "geometry": {"type": "Point","coordinates": [100, 100]}
    'crs': {
    'type': 'name',
    'properties': {
        'name': 'urn:ogc:def:crs:EPSG::3448'
      }
    }
  }
  
  @map.addLayer(base.osm)
  # the highlight
  h = L.marker([0, 0], {icon: L.icon({
        iconUrl: 'images/TargetBW.png',
        iconSize: [32, 32],
        })}).addTo(@map)
  
  # c holds customers geojson
  c =  L.Proj.geoJson(holder, {
    onEachFeature: (feature, layer) ->
      layer.on({click: -> 
        console.log feature.properties
        
      })
    pointToLayer: (feat, latlng) ->
      serviceLocation = L.icon({
        iconUrl: 'images/ServiceLocation.png',
        iconSize: [32, 32],
        })
      streetLight = L.icon({
        iconUrl: 'images/Streetlight.png',
        iconSize: [32, 32],
        })
      return L.marker(latlng,{icon: streetLight}) if feat.properties.gid is 1
      return L.marker(latlng,{icon: serviceLocation}) if feat.properties.gid is -1
      
     
  }).addTo(@map)
  
  
  # v is the variable that will hold the geojson object for all the livewiredata
  v = L.Proj.geoJson(holder, {
    style: (feat) ->
      if feat.properties.gid.startsWith('33') 
        return {"color": "#80115f","weight": 3,"opacity": 1}
      if feat.properties.gid.startsWith('32') 
        return {"color": "#80115f","weight": 2,"opacity": 1,"dashArray":"5, 2"}
      if feat.properties.gid.startsWith('31') 
        return {"color": "#80115f","weight": 1,"opacity": 1,"dashArray":"2, 2" }
      if feat.properties.gid.startsWith('39') 
        return {"color": "blue","weight": .5,"opacity": 1,"dashArray":"2, 1" }
    onEachFeature: (feature, layer) ->
      layer.on({click: (e) -> 
        console.log feature.properties
        console.log e
        zzzz.trigger('infoFeature', feature.properties)
        zzzz.trigger('showTarget', e)
        zzzz.trigger('featureData', feature.properties)
        zzzz.trigger('clearCustomers')
      })
    pointToLayer: (feat, latlng) ->
      pole = L.icon({
        iconUrl: 'images/Pole.png',
        iconSize: [32, 32],
        })
      streetLight = L.icon({
        iconUrl: 'images/Streetlight.png',
        iconSize: [32, 32],
        })
      isolator_FC = L.icon({
        iconUrl: 'images/Isolator_Field_Operated_Closed.png',
        iconSize: [32, 32],
        })
      isolator_FO = L.icon({
        iconUrl: 'images/Isolator_Field_Operated_Open.png',
        iconSize: [32, 32],
        })
      isolator_RO = L.icon({
        iconUrl: 'images/Isolator_Remotely_Operated_Open.png',
        iconSize: [32, 32],
        })
      isolator_RC = L.icon({
        iconUrl: 'images/Isolator_Remotely_Operated_Closed.png',
        iconSize: [32, 32],
        })
      isolator_fuse = L.icon({
        iconUrl: 'images/Isolator_Fuse.png',
        iconSize: [32, 32],
        })
      transformer = L.icon({
        iconUrl: 'images/Transformer.png',
        iconSize: [32, 32],
        })
      transformerpad = L.icon({
        iconUrl: 'images/TransformerPad.png',
        iconSize: [32, 32],
        })
      substation = L.icon({
        iconUrl: 'images/Substation.png',
        iconSize: [32, 32],
        })
      if feat.properties.gid.startsWith('22') 
        return L.marker(latlng,{icon: transformer, zIndexOffset: 99}) 
      if feat.properties.gid.startsWith('21') 
        return L.marker(latlng,{icon: transformerpad, zIndexOffset: 99}) 
      if feat.properties.gid.startsWith('94') 
        return L.marker(latlng,{icon: substation})
      if feat.properties.gid.startsWith('99') 
        return L.marker(latlng,{icon: isolator_fuse})
      if feat.properties.gid.startsWith('97') 
        return L.marker(latlng,{icon: isolator_fuse})
      if feat.properties.gid.startsWith('98') 
        return L.marker(latlng,{icon: isolator_FC})
      if feat.properties.gid.startsWith('96') 
        return L.marker(latlng,{icon: isolator_RO})
      if feat.properties.gid.startsWith('95') 
        return L.marker(latlng,{icon: isolator_RC})
      if feat.properties.gid.startsWith('88') 
        return L.marker(latlng,{icon: pole, zIndexOffset: -99})
      if feat.properties.gid.startsWith('44') 
        return L.marker(latlng,{icon: streetLight, zIndexOffset: 10})
      return L.marker(latlng)
  }).addTo(@map)
  
  mapmoved = =>
    console.log('***')
    if @map.getZoom() > 13
      bounds =  @map.getBounds()
      console.log bounds
      nw = xform.forward([bounds.getNorthWest().lng,bounds.getNorthWest().lat])
      se = xform.forward([bounds.getSouthEast().lng,bounds.getSouthEast().lat])
      url = "/bounds/ABCDEFGH/#{nw[0].toFixed(0)}/#{nw[1].toFixed(0)}/#{se[0].toFixed(0)}/#{se[1].toFixed(0)}/#{@map.getZoom()}"
      #console.log(url)
      req = new XMLHttpRequest()
      req.onload = -> 
        #console.log req.responseText
        feat = JSON.parse(req.responseText)
        v.clearLayers()
        r = (fix(m) for m in feat)
        v.addData(r)
        
      req.open("GET", url, true)
      req.send()
      console.log '----'
    else
      v.clearLayers()
      console.log("no joy at #{@map.getZoom()}")
    zzzz.trigger('zoomStatus',{zoom:@map.getZoom()})
  
  
  @map.on('moveend', mapmoved)
  
  zzzz.on('mapZoomIn', => @map.zoomIn())
  zzzz.on('mapZoomOut', => @map.zoomOut())
  zzzz.on('flyTo', (indata) => @map.flyToBounds(L.geoJson(indata.geometry)))
  zzzz.on('showTarget', (indata) => 
    zoom = if @map.getZoom() < 17 then 17 else  @map.getZoom()
    
    if 'latlng' of indata
      h.setLatLng(indata.latlng)
      @map.flyTo(indata.latlng,zoom)
    else
      coords = xform.inverse(indata)
      h.setLatLng([coords[1],coords[0]])
      @map.flyTo([coords[1],coords[0]],zoom)
    )
  
  zzzz.on('hideTarget', (indata) -> h.setLatLng([0, 0]))
  zzzz.on('customersOnMap', (indata) ->
    console.log indata
    fix2 = (inob) ->
      qq = 
        "type" : "Feature"
        "crs": 
          "type": "name"
          "properties": 
            "name": "urn:ogc:def:crs:EPSG::3448"
        "properties": 
          #"gid": inob["premises"].toString() if inob.watta
          "gid": if "premises" of inob then -1 else 1
        "geometry":inob["coords"]
    
    r = (fix2(m) for m in indata)
    c.addData(r)
    
    )
  zzzz.on('clearCustomers', -> c.clearLayers())
  
  
  @on('mount', -> 
      @map.invalidateSize()
      
      )
  
  </script>

</edgemap>
