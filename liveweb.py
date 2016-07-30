import glob, os, sys, psycopg2, bottle
from bottle import route, run, template, response, static_file, redirect
import json

print('************************')
print(sys.version)
bottle.debug(True)
cnx = psycopg2.connect('dbname=livewire user=rhys password=mikoy@nshamar!3 host=rhys.host.funtoo.org port=5445 application_name=livewire_web')
#crs = cnx.cursor()

@route('/')
def index():
    return '<h1 style="font-size: 40em; text-align:center">@</h1>'

# @route('/bounds/<nwx:int>/<nwy:int>/<sex:int>/<sey:int>/<z:int>')
# def bounds(nwx,nwy,sex,sey,z):
#     #/bounds/758007/654406/775445/648123/14
#     crs = cnx.cursor()
#     crs.callproc('web.get_payload_live',[nwx,nwy,sex,sey])
#     txt = crs.fetchone()
#     return txt
    
@route('/bounds/<toggles>/<nwx:int>/<nwy:int>/<sex:int>/<sey:int>/<z:int>')
def bounds2(toggles,nwx,nwy,sex,sey,z):
    #/bounds/758007/654406/775445/648123/14
    crs = cnx.cursor()
    
    q_primary = """
    select  jsonb_build_object(
      'GID',
      CASE 
       when phasecode = 'ABC' 
       then ('33'||globalid::text)::int /* Three Phase line*/
       when phasecode in ('AB','AC','BC') 
       then ('32'||globalid::text)::int /* Two Phase line*/
       ELSE ('31'||globalid::text)::int /* Single Phase line*/
      end)
      || st_asgeojson(g,0)::jsonb payload from livewire.primaryline 
    where st_dwithin(st_makeenvelope(%(nwx)s,%(nwy)s,%(sex)s,%(sey)s,3448),g,5)
    """
    
    q_secondary = """
    select jsonb_build_object(
      'GID',
      ('39'||globalid::text)::int) 
      || st_asgeojson(g,0)::jsonb payload from livewire.secondaryline 
    where st_dwithin(st_makeenvelope(%(nwx)s,%(nwy)s,%(sex)s,%(sey)s,3448),g,5)
    """
    
    q_poles = """
    select jsonb_build_object(
      'GID',
      ('88'||globalid::text)::int) 
      || st_asgeojson(g,0)::jsonb payload from livewire.pole 
    where st_dwithin(st_makeenvelope(%(nwx)s,%(nwy)s,%(sex)s,%(sey)s,3448),g,5) 
    """
    
    q_transformers = """
    select jsonb_build_object(
      'GID',
      case 
        when mounted = 'POLE' then ('22'||globalid::text)::int 
        ELSE ('21'||globalid::text)::int
      end)
      || st_asgeojson(g,0)::jsonb payload from livewire.transformerbank
    where st_dwithin(st_makeenvelope(%(nwx)s,%(nwy)s,%(sex)s,%(sey)s,3448),g,5) 
    """
    
    q_isolators = """ 
    select jsonb_build_object(
      'GID',
      case 
        when devicetype = 'FUSE' and status = 'CLOSED' 
        then ('99'||globalid::text)::int 
        when devicetype in ('LAB','KS') and status = 'CLOSED' 
        then ('98'||globalid::text)::int 
        when devicetype in ('LAB','KS','FUSE') and status = 'OPEN' 
        then ('97'||globalid::text)::int 
        when devicetype in ('ALBS', 'PMR','LCB','LBS') and "status" = 'OPEN' 
        then ('96'||globalid::text)::int 
        when devicetype in ('ALBS', 'PMR','LCB','LBS') and "status" = 'CLOSED' 
        then ('95'||globalid::text)::int 
        when devicetype = 'FDR' then ('94'||globalid::text)::int 
        ELSE ('93'||globalid::text)::int 
      end) 
      || st_asgeojson(g,0)::jsonb payload from livewire.isolators 
    where st_dwithin(st_makeenvelope(%(nwx)s,%(nwy)s,%(sex)s,%(sey)s,3448),g,5)
    """
    # q_isolators_filter = ""
    # if 'A' in toggles:
    #   q_isolators_filter += "devicetype = 'FUSE' and status = 'CLOSED'" 
    
    q_streetlamps = """
    select jsonb_build_object(
      'GID',
      ('44'||globalid::text)::int)
      || st_asgeojson(g,0)::jsonb payload from livewire.streetlight 
    where st_dwithin(st_makeenvelope(%(nwx)s,%(nwy)s,%(sex)s,%(sey)s,3448),g,5)
    """
    
    
    qry = "select json_agg(payload)::text from ( "
    qrys = []
    if 'A' in toggles:
        qrys.append( q_primary)
    if 'B' in toggles and z > 17:
        qrys.append(q_secondary)
    if 'C' in toggles and z > 17:
        qrys.append(q_poles)
    if 'D in toggles' and z > 19:
        qrys.append(q_isolators)
    if 'E in toggles' and z > 17:
        qrys.append(q_transformers)
    if 'F in toggles' and z > 17:
        qrys.append(q_streetlamps)
        
    qry += ' UNION ALL '.join(qrys)
    qry += ") as foo"
    #print qry
    print crs.mogrify(qry,{'nwx':nwx,'nwy':nwy,'sex':sex,'sey':sey})
    crs.execute(qry,{'nwx':nwx,'nwy':nwy,'sex':sex,'sey':sey})
    return crs.fetchone()

    
    
    
    
    

@route('/find/transformer/<gid>')
def find_transformer(gid):
    crs = cnx.cursor()
    # qry = "select (to_jsonb(foo.*) - 'g' ||jsonb_build_object('layer','Transformer')|| "
    # qry += "jsonb_build_object('cust_info', "
    # qry += "(select json_agg(row_to_json(foo.*)::jsonb - 'g')::jsonb from  "
    # qry += "(select *,st_asgeojson(g)::json coords from service.location  "
    # qry += "join service.info using (premises) where connectedtransformer =  %(gid)s::text)  "
    # qry += "as foo "
    # qry += "))|| "
    # qry += "jsonb_build_object('lamp_info', "
    # qry += "(select json_agg(row_to_json(foo.*)::jsonb - 'g')::jsonb from  "
    # qry += "(select *,st_asgeojson(g)::json coords from livewire.streetlight  "
    # qry += "where connectedtransformer =  %(gid)s::int)  "
    # qry += "as foo "
    # qry += ")))::text " 
    # qry += "from (select *,st_x(g), st_y(g) from livewire.transformerbank  "
    # qry += "where globalid =  %(gid)s::int ) as foo; "
    qry = """select (
              to_jsonb(foo.*) - 'g' 
              || jsonb_build_object('layer','Transformer')
              || jsonb_build_object('cust_info', 
                (select json_agg(row_to_json(foo.*)::jsonb - 'g')::jsonb from  
                    (select *,st_asgeojson(g)::json coords from service.location  
                    join service.info using (premises) where connectedtransformer =  %(gid)s::text)  
                    as foo)
                    )
              || jsonb_build_object('lamp_info', 
                (select json_agg(row_to_json(foo.*)::jsonb - 'g')::jsonb from  
                    (select *,st_asgeojson(g)::json coords from livewire.streetlight  
                    where connectedtransformer =  %(gid)s::int)  
                    as foo))
                    )::text 
            from 
                (select *,st_x(g), st_y(g) from livewire.transformerbank  
                where globalid =  %(gid)s::int ) as foo
        """
    
    #print crs.mogrify(qry,({'gid': gid}))
    crs.execute(qry,({'gid': gid}))
    txt = crs.fetchone()
    return txt
@route('/find/streetlight/<gid>')
def find_streetlight(gid):
    crs = cnx.cursor()
    qry = """select jsonb_pretty(to_jsonb(foo.*) - 'g' ||jsonb_build_object('layer','Streetlight'))"""
    qry += """from (select *,st_x(g), st_y(g) from livewire.streetlight where globalid = %s::int ) as foo"""
    crs.execute(qry,(gid,))
    txt = crs.fetchone()
    return txt

@route('/find/isolator/<gid>')
def find_isolator(gid):
    crs = cnx.cursor()
    qry = """select jsonb_pretty(to_jsonb(foo.*) - 'g' ||jsonb_build_object('layer','Isolator'))"""
    qry += """from (select *,st_x(g), st_y(g) from livewire.isolators where globalid = %s::int ) as foo"""
    crs.execute(qry,(gid,))
    txt = crs.fetchone()
    return txt

@route('/find/pole/<gid>')
def find_pole(gid):
    crs = cnx.cursor()
    qry = """select jsonb_pretty(to_jsonb(foo.*) - 'g' ||jsonb_build_object('layer','Pole'))"""
    qry += """from (select *,st_x(g), st_y(g) from livewire.pole where globalid = %s::int ) as foo"""
    crs.execute(qry,(gid,))
    txt = crs.fetchone()
    return txt


@route('/find/premises/<prem>')
def find_premises(prem):
    crs = cnx.cursor()
    qry = "select (row_to_json(foo.*)::jsonb -'g')::text from "
    qry += "(select *,st_asgeojson(g)::json coords from service.location "
    qry += "left join service.info using (premises) where premises = %s) "
    qry += "as foo"
    crs.execute(qry,(prem,))
    txt = crs.fetchone()
    return txt

# @route('/customers/<gid>')
# def customers(gid):
#     crs = cnx.cursor()
#     # qry = "select json_agg(row_to_json(foo.*))::text from "
#     # qry += "(select premises, st_asgeojson(g)::json coords  "
#     # qry += "from service.location where connectedtransformer = %s) as foo"
#     qry = "select json_agg(row_to_json(foo.*)::jsonb -'g')::text from "
#     qry += "(select *,st_asgeojson(g)::json coords from service.location "
#     qry += "join service.info using (premises) where connectedtransformer = %s) "
#     qry += "as foo"
#     crs.execute(qry,(gid,))
#     return crs.fetchone()
    
@route('/search/<num:re:[0-9]+>')
def errbodylook(num):
    crs = cnx.cursor()
    qry = """
        with one as (
        select to_jsonb(foo.*) - 'g' ||jsonb_build_object('layer','Streetlight') payload
        from (select * from livewire.streetlight where polenumber ~* %(bam)s  limit 5) as foo
        union all
        select to_jsonb(foo.*) - 'g' ||jsonb_build_object('layer','Service Location')
        from (select * from service.location where premises ~* %(bam)s  limit 5) as foo
        union all
        select to_jsonb(foo.*) - 'g' ||jsonb_build_object('layer','Isolators')
        from (select * from livewire.isolators where polenumber ~* %(bam)s or facilityid::text ~* %(bam)s  limit 5) as foo
        union all
        select to_jsonb(foo.*) - 'g' ||jsonb_build_object('layer','Transformer')
        from (select * from livewire.transformerbank where polenumber ~* %(bam)s or facilityid::text ~* %(bam)s  limit 5) as foo
        union all
        select to_jsonb(foo.*) - 'g' ||jsonb_build_object('layer','Poles')
        from (select * from livewire.pole where polenumber ~* %(bam)s limit 5) as foo)
        select json_agg(payload)::text from one
        """
    num = '^' + str(num)
    crs.execute(qry,{'bam':num})
    out = crs.fetchone()[0]
    #print 'len is: ' + str(len(out))
    return out

@route('/search/<word>')
def wordsearch(word):
    crs = cnx.cursor()
    qry = "select json_agg(row_to_json(foo.*)::jsonb || "
    qry += "jsonb_build_object('layer', 'Service_name'))::text from "
    qry += "(select * from service.info where "
    
    #qry = """select * from service.info where """
    q = ['service_name ~* %s' for nn in word.split(' ')]
    qry =  qry + ' and '.join(q) + ' limit 10) as foo'
    print crs.mogrify(qry,word.split(' '))
    crs.execute(qry,word.split(' '))
    return crs.fetchone()[0]
    















@route('/ele/<zoom>/<x>/<y>')
def tiles(zoom,x,y):
    uri = '/{}/{}/{}'.format(zoom,x,y)
    return static_file(uri,'d:/ih_tiles/gl2/island')

@route('/images/<image>')
def images(image):
    return static_file(image,'www/images/')


@route('/map/')
def map_():
    redirect("/map")

@route('/map')
def map():
    return template('www/index.html')
   
@route('/livewire.css')
@route('/map/livewire.css')
def legend():
    response.content_type = 'text/css'
    return template('www/livewire.css')

@route('/js/<jsfile>')
@route('/map/js/<jsfile>')
def js(jsfile):
  response.content_type = 'application/javascript'
  return template('www/js/'+jsfile)


@route('/map/query/<thisquery:int>')
def query_number(thisquery):
    crs = cnx.cursor()
    crs.callproc('map.web_point_query_by_pnumber',[thisquery,])
    txt = crs.fetchone()[0]
    crs.close()
    #print(txt)
    response.content_type = 'application/json'
    return str(txt)

@route('/map/query/<thisquery:re:[a-z, ]+>')
def query_alpha(thisquery):
    tq = ' & '.join(thisquery.split(' '))
    tq = tq.strip() + ":*"
    tq = """to_tsquery('addressing_en','{}')""".format(tq)
    print(tq)
    crs = cnx.cursor()
    #crs.callproc('map.web_roadname_query',[tq,])
    qry = """select map.web_roadname_query({})""".format(tq)
    print(qry)
    crs.execute(qry)
    txt = crs.fetchone()[0]
    crs.close()
    #print(txt)
    response.content_type = 'application/json'
    return str(txt)

@route('/map/query/<thisquery:re:[a-z,0-9, ]+>')
def query_parcels(thisquery):
    tq = ' & '.join(thisquery.split(' '))
    tq = tq.strip() + ":*"
    tq = """to_tsquery('addressing_en','{}')""".format(tq)
    print(tq)
    crs = cnx.cursor()
    #crs.callproc('map.web_parcel_query',[tq,])
    qry = """select map.web_parcel_query({})""".format(tq)
    print(qry)
    crs.execute(qry)
    txt = crs.fetchone()[0]
    crs.close()
    #print(txt)
    response.content_type = 'application/json'
    return str(txt)

@route('/map/query/<lon>/<lat>')
def location(lon,lat):
    crs = cnx.cursor()
    crs.callproc('map.web_point_query_by_location',[lon,lat])
    txt = crs.fetchone()[0]
    crs.close()
    #print(txt)
    response.content_type = 'application/json'
    return str(txt)

# @route('/map/query/<selon>/<selat>/<nelon>/<nelat>')
# def bounds(selon,selat,nelon,nelat):
#     crs = cnx.cursor()
#     crs.callproc('map.web_point_query_by_bounds',[selon,selat,nelon,nelat])
#     txt = crs.fetchone()[0]
#     crs.close()
#     #print(txt)
#     response.content_type = 'application/json'
#     return str(txt)


run(host='0.0.0.0', port=8080)
