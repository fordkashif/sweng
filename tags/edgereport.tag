<edgereport>
  <style scoped>
    :scope {
        text-align:center;
        transition: left .65s ease-in-out .05s; 
        position: fixed; 
        top:0; bottom:0;
        left:-500px; width:450px; 
        background-color: rgba(51,51,51,.05);
        background: linear-gradient( rgba(251,251,251,.99), rgba(51,51,51,.05));
    }
    
    :scope.disp {
        left: 0px;
        transition: left .65s ease-in-out .05s;
        text-align:center;
    }  
    
    
    .hidebar {
      position: absolute;
      right: 5px;
      top:-5px;
      padding-top: 20px;
      padding-bottom:20px;
      font-size: 14px;
      margin: 0px;
      z-index: 500
    }
    .noresults  {
    font-size: xx-large;
    font-stretch: ultra-expanded;
    color: red;
}  
  </style>
  
  <div id="err" >
  <!--<div id="err" class={disp: errup}>-->
    <h4>Report Error/Innacuracy</h4>
    <div style="text-align: left;margin: 25px;">
      Using the mouse, draw around the area where the error is. Click once on the map to start drawing, click a second time to complete the shape. Describe the errors in the text box below. When finished, hit the save button, or hit cancel to cancel this action.
  
      <div style="height: 100%; width:100%">
  <div class="mdl-textfield mdl-js-textfield" style="width:100%">
    <input class="mdl-textfield__input" type="text" id="whoami" onkeyup={checkSave} placeholder="Who are you?">
    <label class="mdl-textfield__label" for="sample1"></label>
  </div>
  <div class="mdl-textfield mdl-js-textfield" style="width:100%">
    <input class="mdl-textfield__input" type="text" id="contact" onkeyup={checkSave} placeholder="How can we contact you? (phone# or email)">
    <label class="mdl-textfield__label" for="sample1"></label>
  </div>
        <div class="mdl-textfield mdl-js-textfield" style="width: 400px">
          <textarea style="height: 100%" class="mdl-textfield__input" type="text" rows="15" id="sample5" onkeyup={checkSave} placeholder="Describe the error/innacuracy here."></textarea>
          <label class="mdl-textfield__label" for="sample5">
            
          </label>
        </div>
  
      </div>
      <div>
        <button class="mdl-button mdl-js-button mdl-js-ripple-effect" onclick={ saveReport } disabled={ saveDisabled }>Save</button>
        <button class="mdl-button mdl-js-button mdl-js-ripple-effect" onclick={ cancelReport }>Cancel</button>
        
        <button style="float: right" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" onclick={clearShape}>Clear Shape</button>
      </div>
    </div>
  
  </div>
  
 
  <script type="coffeescript">

    @cancelReport = -> zzzz.trigger('reportHide')
    @on('mount', -> console.log('edgereport'))
   
    
    
      
  </script>

</edgereport>

<!--@filteredList = (pit for pit in opts.search_data when  pit.word.match(new RegExp(@searchtxt.value, 'i')))-->