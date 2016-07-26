<edgelegend>
  <style scoped>
      :scope { 
        transition: left 1s ease-out .25s; 
        position: fixed;  
        top: 50%;
        left: 100px; 
        width: 450px;
        z-index: 500;
        transform: translatey(-50%);
      }
      :scope.hide {
        left: -450px;
        transition: left 1.25s ease-out;
        
      }
      #zoomholder {
        opacity: 1; 
        background-color:rgba(251,251,251,.99);
        padding: 5px;
        padding-bottom: 25px;
        border-radius: 5px;
      }
      #zoomholder.show {
        
        opacity: 1;
        transition: opacity .2s ease-out;
      }
      
      .left-div {
        float: left;
        margin-right: 40px;
      }
      .right-div {
        margin-left: 110px;
      }

     
      
  </style>
    <div class="modal">
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
          <div class = 'left-div'>
            <div><img src="images/square.png">Customers</div>
            <div><img src="images/Transformer.png">Transformer</div>
            <div><img src="images/Streetlight.png">Streetlight</div>
            <div><img src="images/Substation.png">Substation</div>
          </div>
          <div class='right-div'>
            <div><img src="images/Isolator_Field_Operated_Closed.png">Isolator Field Operated Closed</div>
            <div><img src="images/Isolator_Field_Operated_Open.png">Isolator Field Operated Closed</div>
            <div><img src="images/Open Switch.png">Open Switch</div> 
            <div><img src="images/TransformerPad.png">Transformer Pad</div>
          </div>
        </div>
      </div>
    </div>

<script type="coffeescript">
  zzzz.hideLegend = -> zzzz.trigger("hideLegend")
  #zzzz
</script>

</edgelegend>