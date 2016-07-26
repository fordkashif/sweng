<answer-box>
  <style></style>
  
  <div if={ opts.info.layer === 'Service Location' }>
    Service Location: {opts.info.premises}
  </div>
  <div if={ opts.info.layer === 'Streetlight' }>
    Streetlight: {opts.info.polenumber}
  </div>
  <div if={ opts.info.layer === 'Transformer' }>
    Transformer: {opts.info.facilityid} | {opts.info.polenumber}
  </div>
  <div if={ opts.info.layer === 'Isolators' }>
    Isolator: {opts.info.facilityid} | {opts.info.polenumber}
  </div>

  
  <script type="coffeescript">
  #console.log(opts.info)
  #console.log(opts.info.layer)
  
  </script>
</answer-box>