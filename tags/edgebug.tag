<edgebug>
  <style scoped>
    :scope {
      /*position:absolute;*/
      /*left: 0;*/
      /*right:0;*/
      /*height: 400px;*/
      display: block;
      background-color: red;
      transition: left .65s ease-in-out .05s;
      position: fixed; left:200px; bottom:200px;
    }
    
     
  </style>
  
  <div><h1>DEBUG STUFF</h1>
  <hr>
  <h1>{zzzz.coords.lat}:{zzzz.coords.lng}</h1>
  
  </div>

  <script type="coffeescript">

  zzzz.on('coordsupdate', -> 
    zzzz.coords = zzzz.map.getCenter()
    console.log(zzzz.coords.lat + ':::' + zzzz.coords.lng)
    
    )
 
  @on('mount', -> 
      console.log 'DEBUG'
      
      )
  
  </script>

</edgebug>
