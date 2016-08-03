<edgelegend>
  <style scoped>
      :scope { 
        transition: left .25s ease-out .25s; 
        position: fixed;  
        display:inline-block;
        top: 50%;
        left: 100px; 
<<<<<<< HEAD
        
=======
        display: inline-block;
>>>>>>> c004ad602b86d31fb42d2142dbb4de6f2e477cf1
        z-index: 500;
        transform: translatey(-50%);
      }
      :scope.hide {
        left: -500px;
        transition: left .25s ease-out;
        
      }
      #zoomholder {
        opacity: 1; 
<<<<<<< HEAD
        background-color:rgba(251,251,251,.99);
=======
        background-color: rgba(251,251,251,.99);
>>>>>>> c004ad602b86d31fb42d2142dbb4de6f2e477cf1
        padding: 0px;
        padding-bottom: 0px;
        border-radius: 5px;
      }
      
      #zoomholder.show {
        
        opacity: 1;
        transition: opacity .1s ease-out;
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

      .left-div {
          width: 40%;
          height: 200px;
          float: left;
      }
      .right-div {
          margin-left: 60%;
          height: 200px;
      }
      
      #primaryshape{
        width:32px;
        height:5px;
        background:#80115f;
      }
      #primaryshape2{
        width:32px;
        height:2px;
        background:#80115f;
      }
      #primaryshape3{
        border: 0 none;
        border-top: 1px dashed #80115f;
        background: none;
        height:0;
      }
      #secondaryshape{
        width:32px;
        height:1px;
        background:blue;
      }
     img {filter: grayscale(0);}
     .noshow{filter: grayscale(1);}
      
  </style>
    <div class="modal">
      <div id="zoomholder"  >
        <div id="legend-header">
<<<<<<< HEAD
          <span style="float: left"><h5 style="margin:10px">Legend</h5></span>
=======
          <span style="float: left"><h5 style="margin:10px">Layers</h5></span>
>>>>>>> c004ad602b86d31fb42d2142dbb4de6f2e477cf1
          <span style="float: right;">
          <button class="mdl-button mdl-js-button mdl-button--icon" onclick={ zzzz.hideLegend }>
            <i class="material-icons">close</i>
          </button></span>
        </div>
        <br>
        <div>
        
<<<<<<< HEAD
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
=======
  <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable" id="legend">
   <tr each={name, i in zzzz.legend_items } >
      <td>
        <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-{ i }">
        <input type="checkbox" id="switch-{i}" class="mdl-switch__input" onclick={ layerselect  } checked={ name.show }>
        <span class="mdl-switch__label">{ name.title }</span>
        
        </label>
      </td>
      <td>
        <img if={ name.imgurl } src={ name.imgurl }>
        <div if={ name.divclas } id="{ name.divclas }"></div>
      </td>
   </tr>
   </tbody>
  </table>
  
</material-checkbox>
      
  <!--<ul class="mdl-list">-->
  <!--  <li each={ name, i in zzzz.legend_items } class="mdl-list__item" onclick={ layerselect  }>-->
  <!--    <span class="mdl-list__item-primary-content">-->
  <!--    <img if={ name.imgurl } src={ name.imgurl } class={ noshow: name.noshow }>-->
  <!--    <div if={ name.divclas } id="{ name.divclas }"></div>-->
  <!--    </span>    -->
  <!--    { name.title } -->
  
  <!--  </li>-->
    
  <!--</ul>-->
      
   
>>>>>>> c004ad602b86d31fb42d2142dbb4de6f2e477cf1
          
        </div>
      </div>
    </div>
<<<<<<< HEAD
=======

>>>>>>> c004ad602b86d31fb42d2142dbb4de6f2e477cf1

<script type="coffeescript">
  zzzz.hideLegend = -> zzzz.trigger("hideLegend")
  
  zzzz.legend_items = [
    {alpha: 'A',maxZoom: 14, show: yes, title: 'Primary Lines', divclas: "primaryshape" }
    {alpha: 'B',maxZoom: 14, show: yes, title: 'Secondary Lines', divclas: "secondaryshape" }
    {alpha: 'C',maxZoom: 14, show: yes, title: 'Transformers (Pole Mounted)', imgurl: "images/Transformer.png" }
    {alpha: 'D',maxZoom: 14, show: yes, title: 'Transformers (Pad Mounted)', imgurl: "images/TransformerPad.png" }
    {alpha: 'E',maxZoom: 14, show: yes, title: 'Interphase Transformers', imgurl: "images/Interphase_Transformer.png" }
    {alpha: 'F',maxZoom: 14, show: yes, title: 'Remotely Operated Switch - Closed', imgurl: "images/Isolator_Remotely_Operated_Closed.png" }
    {alpha: 'G',maxZoom: 14, show: yes, title: 'Remotely Operated Switch - Open', imgurl: "images/Isolator_Remotely_Operated_Open.png" }
    {alpha: 'H',maxZoom: 14, show: yes, title: 'Field Operated Switch - Closed', imgurl: "images/Isolator_Field_Operated_Closed.png" }
    {alpha: 'I',maxZoom: 14, show: yes, title: 'Field Operated Switch - Open', imgurl: "images/Isolator_Field_Operated_Open.png" }
    {alpha: 'J',maxZoom: 14, show: yes, title: 'Fuses', imgurl: "images/Isolator_Fuse.png" }
    {alpha: 'K',maxZoom: 14, show: yes, title: 'Feeder Recloser', imgurl: "images/Substation.png" }
    {alpha: 'L',maxZoom: 14, show: yes, title: 'Streetlights', imgurl: "images/Streetlight.png" }
    {alpha: 'M',maxZoom: 14, show: yes, title: 'Poles', imgurl: "images/Pole.png" }
    ]
  @layerselect = (e) =>
   console.log e.item
   #e.preventDefault()
   zzzz.legend_items[e.item.i].show = not zzzz.legend_items[e.item.i].show
   #riot.update()
   #console.log zzzz.legend_items
   zzzz.trigger('mapRefresh')
   
  

</script>

</edgelegend>