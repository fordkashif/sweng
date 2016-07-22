zzzz = riot.observable()

zzzz.searchitems = []
zzzz.searchNum = []
zzzz.mapstats = {"livewire_version": .75}
zzzz.results = ->
    zzzz.searchNum = (x for x in url_for(errbodylook) when x.premises.match(new RegExp(@searchbox.value, 'i'))) 
    zzzz.searchitems = (q for q in feeders.features when q.properties.Name.match(new RegExp(@searchbox.value, 'i')))
    zzzz.searchitems = [] if @searchbox.value.length = 0

zzzz.showitem = -> 
    zzzz.trigger('hideedgebar')
    zzzz.trigger('showobject',event.item)
    
zzzz.base = {
    'osm': L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png")
    'out': L.tileLayer("https://{s}.tile.thunderforest.com/outdoors/{z}/{x}/{y}.png")
    'cdb': L.tileLayer("http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png")
    'trs': L.tileLayer("https://{s}.tile.thunderforest.com/transport/{z}/{x}/{y}.png")
  }


zzzz.on('showobject', (indata) ->
    console.log L.version
    zzzz.trigger('flyTo', indata)
    )
zzzz.on('zoomIn', -> zzzz.map.zoomIn())
zzzz.on('zoomOut', -> zzzz.map.zoomOut())
zzzz.on('showEdgeBar', ->
    document.getElementsByTagName("edgebar")[0].className = "disp"
    document.getElementsByTagName("edgebuttons")[0].className = "hide"
    riot.route('search')
   
    console.log('meet')
    )

zzzz.hideedgebar = -> zzzz.trigger('hideedgebar')

zzzz.on('hideedgebar', ->
    document.getElementsByTagName("edgebar")[0].className = ""
    document.getElementsByTagName("edgebuttons")[0].className = ""
    zzzz.searchitems = []
    riot.route('')
    )

@kp = -> alert('boom2')

    
    
riot.mount('edgebuttons')
riot.mount('edgemap')
riot.mount('edgeinfo')
riot.mount('edgebar')
riot.mount('edgebug')
riot.mount('edgeghost')






