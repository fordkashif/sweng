import glob, os, sys, psycopg2, bottle
from bottle import route, run, template, response, static_file
import json

print('************************')
print(sys.version)
bottle.debug(True)
cnx = psycopg2.connect('dbname=livewire user=rhys password=mikoy@nshamar!3 host=rhys.host.funtoo.org port=5445 application_name=livewire_web')
#crs = cnx.cursor()

@route('/')
def index():
    return '<h1 style="font-size: 40em; text-align:center">@</h1>'


@route('/service-pole')
def service_pole():
    return template('servicepole.html')

@route('/service-pole/query/<polenumber>/<premisesnumber>/<commercialdivision>')
def service_pole_query(polenumber, premisesnumber,commercialdivision):
  crs = cnx.cursor()
  crs.execute("""select _.district_pole_match(%s,%s,%s)""",[polenumber,premisesnumber,commercialdivision])
  txt = crs.fetchone()
  cnx.commit()
  crs.close()
  return txt 

@route('/netcadops')
def netcadops():
    return template('netcadops.html')


#/bounds/758007/654406/775445/648123/14
@route('/bounds/<nwx:int>/<nwy:int>/<sex:int>/<sey:int>/<z:int>')
def bounds(nwx,nwy,sex,sey,z):
    crs = cnx.cursor()
    crs.callproc('web.get_payload_live',[nwx,nwy,sex,sey])
    txt = crs.fetchone()
    return txt

@route('/find/globalid/<gid>')
def find(gid):
    crs = cnx.cursor()
    
    qry = "select (to_jsonb(foo.*) - 'g' ||jsonb_build_object('layer','Transformer')|| "
    qry += "jsonb_build_object('cust_info', "
    qry += "(select json_agg(row_to_json(foo.*)::jsonb - 'g')::jsonb from  "
    qry += "(select *,st_asgeojson(g)::json coords from service.location  "
    qry += "join service.info using (premises) where connectedtransformer =  %(gid)s::text)  "
    qry += "as foo "
    qry += "))|| "
    qry += "jsonb_build_object('lamp_info', "
    qry += "(select json_agg(row_to_json(foo.*)::jsonb - 'g')::jsonb from  "
    qry += "(select *,st_asgeojson(g)::json coords from livewire.streetlight  "
    qry += "where connectedtransformer =  %(gid)s::int)  "
    qry += "as foo "
    qry += ")))::text " 
    qry += "from (select *,st_x(g), st_y(g) from livewire.transformerbank  "
    qry += "where globalid =  %(gid)s::int ) as foo; "
  
    crs.execute(qry,({'gid': gid}))
    
    
    
    
    if crs.rowcount == 0:
        qry = """select jsonb_pretty(to_jsonb(foo.*) - 'g' ||jsonb_build_object('layer','Isolator'))"""
        qry += """from (select *,st_x(g), st_y(g) from livewire.isolators where globalid = %s::int ) as foo"""
        #print("*********************")
        #print(crs.mogrify(qry,(gid[2:],)))
        #print("*********************")
        crs.execute(qry,(gid[2:],))
        txt = crs.fetchone()
        
        print(txt)
        return txt
    txt = crs.fetchone()
    #print(txt)
    return txt

@route('/customers/<gid>')
def customers(gid):
    crs = cnx.cursor()
    # qry = "select json_agg(row_to_json(foo.*))::text from "
    # qry += "(select premises, st_asgeojson(g)::json coords  "
    # qry += "from service.location where connectedtransformer = %s) as foo"
    qry = "select json_agg(row_to_json(foo.*)::jsonb -'g')::text from "
    qry += "(select *,st_asgeojson(g)::json coords from service.location "
    qry += "join service.info using (premises) where connectedtransformer = %s) "
    qry += "as foo"
    crs.execute(qry,(gid,))
    return crs.fetchone()
    
@route('/search/<num>')
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
    num = '^' + num
    crs.execute(qry,{'bam':num})
    out = crs.fetchone()[0]
    #print 'len is: ' + str(len(out))
    return out



@route('/ele/<zoom>/<x>/<y>')
def tiles(zoom,x,y):
    uri = '/{}/{}/{}'.format(zoom,x,y)
    return static_file(uri,'d:/ih_tiles/gl2/island')

@route('/images/<image>')
def images(image):
    return static_file(image,'www/images/')



@route('/map')
@route('/map/')
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
