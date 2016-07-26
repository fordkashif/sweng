<edgelegend>
  <style scoped>
      :scope { 
        transition: left 1.25s ease-out .25s; 
        position: fixed;  
        top: 50%;
        left: 100px; 
        width: 200px;
        z-index: 500;
        transform: translatey(-50%);
      }
      :scope.hide {
        left: -450px;
        transition: left 1.25s ease-out;
        
      }
      #zoomholder {
        opacity: 1; 
        background-color: rgba(251,251,251,.85);
        padding: 5px;
        padding-bottom: 25px;
        border-radius: 10px;
      }
      #zoomholder.show {
        
        opacity: 1;
        transition: opacity .8s ease-out;
      }

     
      
  </style>
<div class="w3-card-2">
  <div id="zoomholder"  >
    <div id="legend-header">
      <span style="float: left"><h5 style="margin:5px">Legend</h5></span>
      <span style="float: right;">
      <button class="mdl-button mdl-js-button mdl-button--icon" onclick={ zzzz.hideLegend }>
        <i class="material-icons">close</i>
      </button></span>
    </div>
    <br>
    <hr>
    <div style="margin:10px">
      <div><img src="images/square.png">Poles</div>
      <div><img src="images/Transformer.png">Transformer</div>
      <div><img src="images/Streetlight.png">Streetlight</div>
      <div><img src="images/Substation.png">Substation</div>
    </div>
  </div>
</div>

<script type="coffeescript">
  zzzz.hideLegend = -> zzzz.trigger("hideLegend")
  #zzzz
</script>

</edgelegend>