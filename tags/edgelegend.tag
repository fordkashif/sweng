<edgelegend>
  <style scoped>
      :scope { 
        transition: left .25s ease-out .25s; 
        position: fixed;  
        top: 50%;
        left: 100px; 
        display: inline-block;
        z-index: 500;
        transform: translatey(-50%);
      }
      :scope.hide {
        left: -500px;
        transition: left .25s ease-out;
        
      }
      #zoomholder {
        opacity: 1; 
        background-color: rgba(251,251,251,.99);
        padding: 0px;
        padding-bottom: 0px;
        border-radius: 5px;
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
          <span style="float: left"><h5 style="margin:10px">Layers</h5></span>
          <span style="float: right;">
          <button class="mdl-button mdl-js-button mdl-button--icon" onclick={ zzzz.hideLegend }>
            <i class="material-icons">close</i>
          </button></span>
        </div>
        <br>
        <div>
        
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
      
   
          
        </div>
      </div>
    </div>


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