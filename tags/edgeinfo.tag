<edgeinfo>
  <style scoped>
   :scope { position: fixed; bottom: -100px; right: 25px; width: 400px; }
   
   #data {
    /*height: 350px;*/
    background-color: rgba(251,251,251,.85);
    padding: 5px;
    padding-bottom: 25px;
    border-radius: 10px;
    position: fixed;
    /*top: 1500px;*/
    transition:  bottom .52s ease-in-out .55s;
    bottom: -1000px;
    width: 400px;
    max-height: 725px;
    overflow-y: auto;
   }
   
   #data.show {bottom: 20px;  transition: bottom .12s ease-in-out .15s;}
   #data-body {
    margin-top: 50px; 
   }
   #showCustomerButton {    text-align: center;padding-bottom: 15px}
   p{
     margin:0;
     margin-left:10px;
   }
   #customerlist {   
    border-bottom-color: grey;
    border-bottom-width: 1px;
    border-bottom-style: solid;}
  </style>

  
  
  <div id="data" class={ show: shown }>
    <div id="data-header">
      <span style="float: left"><h5 style="margin: 5px">{ mydata.devicetype }</h5></span>
      <span style="float: right;">
      <button class="mdl-button mdl-js-button mdl-button--icon" onclick={ hideInfo }>
        <i class="material-icons">close</i>
      </button></span>
    </div>
    <!--Create Card to display Transformer and Information -->
    <div id="data-body"></div>
    
    <!--Display Transformer Information on Card-->
    <div if={ mydata.devicetype === 'Transformer' }>
      <p>Mounted: {mydata.mounted}</p>
      <p>Facility ID: {mydata.facilityid}</p>
      <p>Pole Number: {mydata.polenumber}</p>
      <p>Feeder Name: {mydata.feedername}</p>
      <p>Bank Desc: {mydata.bankdesc}</p>
      <!--<p if={ _.isNumber(mydata.aphasekva) || mydata.aphasekva > 0 }>Phase A: { mydata.aphasekva } KVA</p>-->
      <!--<p if={ _.isNumber(mydata.bphasekva) || mydata.aphasekva > 0 }>Phase B: { mydata.bphasekva } KVA</p>-->
      <!--<p if={ _.isNumber(mydata.cphasekva) || mydata.aphasekva > 0 }>Phase C: { mydata.cphasekva } KVA</p>-->
      <p if={ mydata.aphasekva > 0 }>Phase A: { mydata.aphasekva } KVA</p>
      <p if={ mydata.bphasekva > 0 }>Phase B: { mydata.bphasekva } KVA</p>
      <p if={ mydata.cphasekva > 0 }>Phase C: { mydata.cphasekva } KVA</p>
      
      <p>Coordinates: { mydata.st_x }mE, { mydata.st_y } mN</p>      
      <br>
      <div id="showCustomerButton">
        <button id="CustomersButton"  onclick={ showCustomers } class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">
        <span if={ shoeCust === 0}>Display Connected Customers</span>
        <span if={ shoeCust === 1}>Display Summary</span>
        </button>
      </div>
      <div  if={ shoeCust === 0}>
      <p>Customer Count: { mydata.customerCount } </p> 
      <p>Streetlight Count: { mydata.lampCount } </p> 
      </div>
      <div  if={ shoeCust === 1}>
          <div id="customerlist" each={ items } >
             <section if={ itemType == 'prem' }>
             { premises } | { service_name } 
             <br>
             { service_address } <br>
             Rate: { service_type } <br>
             </section>
             <section if={ itemType == 'lamp' }>
             Polenumber: { polenumber } 
             <br>
             Lamptype: { lamptype } <br>
             Wattage: { wattage } <br>
             </section>
          
          </div> 
      </div>
    </div>
    <!--Display Isolator Information on Card -->
    <div if={ mydata.isolator === 1 }>
      <p>{"Status: " + mydata.status}</p>
      <p>{"Pole Number: " + mydata.polenumber}</p>
      <p>{"Facility ID: " + mydata.facilityid}</p>
      <p>{"Phase Code: " + mydata.phasecode}</p>
      <p>{"Feeder Name: " + mydata.feedername}</p>
      <p>{"Description: " + mydata.description}</p>
      <p>Coordinates: { mydata.st_x }mE, { mydata.st_y } mN</p>  
    </div>
    <!--Display service location Information on Card -->
    <div if={ mydata.devicetype == 'Service Location' }>
      <p>Premises#: { mydata.premises }</p>
      <p>Name: { mydata.service_name }</p>
      <p>Address: { mydata.service_address }</p>
      <p>Route: { mydata.route }</p>
      <p>{"Feeder Name: " + mydata.feedername}</p>
      <p>{"Description: " + mydata.description}</p>
      <p>Coordinates: { mydata.st_x }mE, { mydata.st_y } mN</p>  
    </div>
  </div>
  
  
  <script type="coffeescript">
  
  @shoeCust = 0
  @items = []
  @mydata = {}
  @custshow = no
  
  updatestuff = (inme) =>
    @mydata = {}
    @mydata = inme
    console.log(inme)
    if inme.layer is 'Transformer' 
      @mydata.devicetype = 'Transformer'
      @mydata.isolator = 0
      @mydata.customerCount = inme.cust_info.length if inme.cust_info?
      @mydata.lampCount = inme.lamp_info.length if inme.lamp_info?
    if inme.layer is 'Isolator' 
      @mydata.isolator = 1
      @mydata.inme
    if 'premises' of inme
      @mydata.devicetype = 'Service Location'
      alert 'll'
    
    @.update()
  
  @hideInfo = =>
    @shown = no
    zzzz.trigger('hideTarget')
    zzzz.trigger('clearCustomers')
    riot.update()
      
  
  @showCustomers = =>
    fix = (inob) ->
      val = if "premises" of inob then 'prem' else 'lamp'
      inob.itemType = val
      inob
    if @shoeCust is 0
      @items = _.map(_.union(@mydata.cust_info,@mydata.lamp_info),fix)
      zzzz.trigger('customersOnMap',@items)
      @shoeCust = 1
    else
      @shoeCust = 0
      zzzz.trigger('clearCustomers')
    
  zzzz.on('infoFeature', (infoFeature)  =>
    @shoeCust = 0
    url = ''
    console.log "infoFeature: #{JSON.stringify(infoFeature)}"
    if 'layer' of infoFeature
      if infoFeature.layer is "Transformer"
        url = "/find/transformer/#{infoFeature.globalid}"
      if infoFeature.layer is "Streetlight"
        url = "/find/streetlight/#{infoFeature.globalid}"
      if infoFeature.layer is "Isolators"
        url = "/find/isolator/#{infoFeature.globalid}"
      if infoFeature.layer is "Service Location"
        url = "/find/premises/#{infoFeature.premises}"
    else
      if infoFeature.gid.startsWith('2')
        url = "/find/transformer/#{infoFeature.gid.slice(2)}"
      if infoFeature.gid.startsWith('9')
        url = "/find/isolator/#{infoFeature.gid.slice(2)}"
    req = new XMLHttpRequest()
    console.log "url: #{url}"
    req.onload = -> 
      q = JSON.parse(req.responseText)
      console.log req.responseText
      updatestuff(q)
      riot.update()
      zzzz.trigger('showTarget', [q.st_x,q.st_y]) if 'st_x' of q
      if 'premises' of q
        console.log 'hhh'
        zzzz.trigger('showTarget', [ q.coords.coordinates[0], q.coords.coordinates[1]]) 
    req.open("GET", url, true)
    req.send()
    @shown = yes
    @update()
  )
  
  
        
  @on('mount', -> console.log 'thisinfo')
  </script>

</edgeinfo>
