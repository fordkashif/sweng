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

      .left-div {
          width: 40%;
          height: 200px;
          float: left;
      }
      .right-div {
          margin-left: 60%;
          height: 200px;
      }

     
      
  </style>
    <div class="modal">
      <div id="zoomholder"  >
        <div id="legend-header">
          <span style="float: left"><h5 style="margin:10px">Legend</h5></span>
          <span style="float: right;">
          <button class="mdl-button mdl-js-button mdl-button--icon" onclick={ zzzz.hideLegend }>
            <i class="material-icons">close</i>
          </button></span>
        </div>
        <br>
        <div>
        
        <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable">
          <thead>
            <tr>
              <th class="mdl-data-table__cell--non-numeric">Element</th>
              <th>Icon</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="mdl-data-table__cell--non-numeric">Customers</td>
              <td><img src="images/square.png"></td>
            </tr>
            <tr>
              <td class="mdl-data-table__cell--non-numeric">Transformers</td>
              <td><img src="images/Transformer.png"></td>
            </tr>
            <tr>
              <td class="mdl-data-table__cell--non-numeric">Streetlight</td>
              <td><img src="images/Streetlight.png"></td>
            </tr>
            <tr>
              <td class="mdl-data-table__cell--non-numeric">Substation</td>
              <td><img src="images/Substation.png"></td>
            </tr>
            <tr>
              <td class="mdl-data-table__cell--non-numeric">Isolator Field Operated Close</td>
              <td><img src="images/Isolator_Field_Operated_Closed.png"></td>
            </tr>
            <tr>
              <td class="mdl-data-table__cell--non-numeric">Isolator Field Operated Open</td>
              <td><img src="images/Isolator_Field_Operated_Open.png"></td>
            </tr>
            <tr>
              <td class="mdl-data-table__cell--non-numeric">Open Switch</td>
              <td><img src="images/Open Switch.png"></td>
            </tr>
            <tr>
              <td class="mdl-data-table__cell--non-numeric">Transformer Pad</td>
              <td><img src="images/TransformerPad.png"></td>
            </tr>
          </tbody>
        </table>  
      
            
      
        <!--    <div><img src="images/square.png">Customers</div> -->
         <!--   <div><img src="images/Transformer.png">Transformer</div>
            <div><img src="images/Streetlight.png">Streetlight</div>
            <div><img src="images/Substation.png">Substation</div> -->
            
       <!--     <div><img src="images/Isolator_Field_Operated_Closed.png">Isolator Field Operated Closed  </div>
            <div><img src="images/Isolator_Field_Operated_Open.png">Isolator Field Operated Closed</div>
            <div><img src="images/Open Switch.png">Open Switch</div> 
            <div><img src="images/TransformerPad.png">Transformer Pad</div> -->
          
        </div>
      </div>
    </div>


<script type="coffeescript">
  zzzz.hideLegend = -> zzzz.trigger("hideLegend")
  #zzzz
</script>

</edgelegend>