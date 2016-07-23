<edgebar>
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
    .searchresult {
      border-bottom-width: 1px;
      border-bottom-color: rgba(51,51,51,.05);
      border-bottom-style: solid;
      width: 450px;
      display: block;
      margin-top: 9px;
      padding-left: 10px;
      text-align: left;
      cursor: pointer;
      opacity: .5;
      transition: opacity .8s ease-out, padding-left .2s ease-out;
      color: black;
      font-weight: bold
    }  
    
    .searchresult:hover {
      opacity: 1;
      padding-left: 12px;
      
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
  
  <span class="hidebar">
  <button class="mdl-button mdl-js-button mdl-button--icon" onclick={zzzz.hideedgebar}>
    <i class="material-icons">close</i>
  </button>
  </span>
  <!-- input Text Box -->
  <div class="mdl-textfield mdl-js-textfield" style="width:100%">
    <!--<input class="mdl-textfield__input" type="text" id="searchbox" -->
    <!--onkeyup={results} placeholder="  Search for a polenumber, deviceid or feedername">-->
    <input class="mdl-textfield__input" type="text" id="searchbox" 
    onkeyup={ results } placeholder="  Search for a polenumber, deviceid or feedername">
    <label class="mdl-textfield__label" for="sample1"></label>
  </div>
  
  <div if={ searchitems.length > 0 }>
  <answer-box class="searchresult" info={ name } each={ name, i in searchitems }></answer-box>
  </div>
  
  <div class="noresults" if={ searchbox.value.length > 0 &&  searchitems.length == 0 } >
    No results
    
  </div>
  
  <!-- Checking if searchbox length is greater than five and searches for feedername -->
  
  <!--
  <div if="{ searchbox.value.length > 0 }">
  
   <span class="searchresult" each={ searchitems } onclick={ zzzz.showitem }>{ layer }</span>
  </div>
-->  
  <script type="coffeescript">

    @searchitems = []
    
    
    @results = =>
      
      if @searchbox.value is 0
        return @searchitems = []
      #if @searchbox.value.length in [1..3]
      #  return @searchitems = (q for q in feeders.features when q.properties.Name.match(new RegExp(@searchbox.value, 'i')))
      url = "search/#{@searchbox.value}"
      req = new XMLHttpRequest()
      req.onload = =>
        @searchitems = []
        @searchitems = JSON.parse(req.responseText) if req.responseText.length > 0
        @.update()
      req.open("get", url, true)
      req.send()
      if @searchbox.value.length is 0
        @searchitems = [] 
        @update()
      
    @showitem = -> 
      zzzz.trigger('hideedgebar')
      zzzz.trigger('showobject',event.item)
      
    
    
    @hideedgebar = -> zzzz.trigger('hideedgebar')
    @on('mount', -> console.log('edgebar'))
    zzzz.on('hideedgebar', => 
      @searchbox.value = ''
      @searchitems = []
      ) 
    zzzz.on('showEdgeBar', =>  @searchbox.focus())
    
    
      
  </script>

</edgebar>

<!--@filteredList = (pit for pit in opts.search_data when  pit.word.match(new RegExp(@searchtxt.value, 'i')))-->