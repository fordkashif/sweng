<edgebuttons>
  <style scoped>
    :scope { 
      transition: left 1.25s ease-out .25s; 
      position: fixed;  top: 50%;left: 20px; 
      width: 25px;z-index: 500;
      transform: translatey(-50%);
          width: 25px;z-index: 500;
      transform: translatey(-50%);
    }
    :scope.hide {
      left: -450px;
      transition: left 1.25s ease-out;
      
    }
    #zoomholder {opacity: 1;}
    #zoomholder.show {
      
      opacity: 1;
      transition: opacity .8s ease-out;
    }
    
  </style>
  <div id="zoomholder">
  
   <button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored" onclick={ search }>
    <i class="material-icons">search</i>  
  </button>
   <div style="height:85px"></div>
  <button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored" disabled={ maxZoom } onclick={zoomin}>
    <i class="material-icons">add</i>
  </button>
  <div style="height:10px"></div>
  <button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored" disabled={ minZoom } onclick={zoomout}>
    <i class="material-icons">remove</i>
  </button>
  <div style="height:50px"></div>
  
  
  <button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored" onclick={ layers }>
    <i class="material-icons">layers</i>  
  </button>
 
  
  </div>
  
  

  <script type="coffeescript">
  
  @search = -> zzzz.trigger('showEdgeBar')
  @layers = -> zzzz.trigger('showLegend')
  @maxZoom = no
  @minZoom = yes
  @zoomin = -> zzzz.trigger('mapZoomIn')
  @zoomout = -> zzzz.trigger('mapZoomOut')
  @help = -> 
    alert 'boom'
    zzzz.help.isvisible = yes
    riot.update()
  zzzz.on('zoomStatus', (indata) => 
    if indata.zoom is 20 then @maxZoom = yes else @maxZoom = no
    if indata.zoom is 9 then @minZoom = yes else @minZoom = no
    riot.update()
    )
    
  #zzzz.on('go', =>@going = yes)  
  
  
  @on('mount', -> console.log 'thiszooms')
        
  </script>

</edgebuttons>
