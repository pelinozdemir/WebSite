from asyncio.windows_events import NULL
import json
import mimetypes
from urllib import response
from flask import Flask, jsonify, render_template, render_template_string,Response, request
from jmespath import search
import pymongo
from flask_restful import Resource,Api,abort,fields,marshal_with
from flask_pymongo import PyMongo
from bson import json_util
from flask_admin import Admin
from bson.objectid import ObjectId



app=Flask(__name__)
api=Api(app=app)
app.config["MONGO_URI"]="mongodb://localhost:27017/yazlab-app"
app.config['FLASK_ADMIN_SWATCH'] = 'cerulean'
admin = Admin(app)
email='web@gmail.com'
adminpassword='1234'
mongo=PyMongo(app=app)
mongo.db.products.update_many( {}, { '$rename': { 'marka': 'Marka' } } )
mongo.db.products.update_many( {}, { '$rename': { 'Fiyat': 'fiyat' } } )
mongo.db.products.update_many( {'İşletim Sistemi':'FREE DOS'}, {'$set':{'İşletim Sistemi':'FREEDOS'}} )
mongo.db.products.update_many( {'İşletim Sistemi':'YOK (FREE DOS)'}, {'$set':{'İşletim Sistemi':'FREEDOS'}} )



'''mongo.db.eTicaret.update_many({},{'$set':{'url':'Eticaret'}})
eticaret=mongo.db.eTicaret.find({})
for var in eticaret:
    mongo.db.products.insert_one(var)'''
@app.route('/')
def home():
    return "Anasayfa"


#tum urun listesi
@app.route('/productlist')
def productlist():
    mongo.db.eTicaret.update_many({},{'$set':{'url':'Eticaret'}})
    eticaret=mongo.db.eTicaret.find({})
    '''for var in eticaret:
      mongo.db.products.insert_one(var)'''
    products = mongo.db.products.find({})
    response=json_util.dumps(products)
    return Response(response,mimetype='application/json')


#e-ticaret sitesinin urunleri
@app.route('/eticaret',methods=["GET", "POST"])
def eticaret():
  
    products = mongo.db.products.find({'site':'E-Ticaret'})
    if request.method=="POST":
        field = request.form.get("field")
        value = request.form.get("value")
        search=request.form.get("search")
        if field=='none' or value=='none':
         #print(field);
         print(search)
         
         #print(value)
         if search =="none":
          distinct_= mongo.db.products.find({'site':'E-Ticaret'})
          print(distinct_);
          print(search)
          
         else:
         
          distinct_count= mongo.db.products.count_documents({'baslık':search.upper(),'site':'E-Ticaret'})
          if distinct_count >0:
          
           distinct_= mongo.db.products.find({'baslık':search.upper(),'site':'E-Ticaret'})
           print(distinct_)
          else:
           distinct_count= mongo.db.products.count_documents({'site':search,'site':'E-Ticaret'})
           if distinct_count >0:
            distinct_= mongo.db.products.find({'site':search})
           else:
            distinct_count= mongo.db.products.count_documents({'Model':search.upper(),'site':'E-Ticaret'}) 
            if distinct_count >0:
             distinct_= mongo.db.products.find({'Model':search.upper(),'site':'E-Ticaret'})    
          
        else:   
         print(field)
         print(value)
         distinct_= mongo.db.products.find({field:value.upper(),'site':'E-Ticaret'})
         print(distinct_)
         
       # print(distinct_)
      
    response=json_util.dumps(distinct_)
    
    return Response(response=response,mimetype='application/json')
   

@app.route('/admin/login',methods=["GET", "POST"])
def admin():
     if request.method =="POST":
        mail = request.form.get("email")
        password = request.form.get("password")
        if mail is None:
           return "Hata"
        else:
           if mail==email and password==adminpassword:
            return "Login"

#kullanıcının yan panelde yaptigi filtrelere gore urunleri dondurur
@app.route('/user/filter',methods=["GET", "POST"])
def filter():
    distinct_= mongo.db.products.find({})
    
    if request.method=="POST":
        field = request.form.get("field")
        value = request.form.get("value")
        search=request.form.get("search")
        if field=='none' or value=='none':
         #print(field);
         print(search)
         
         #print(value)
         if search =="none":
          distinct_= mongo.db.products.find({})
          print(distinct_);
          print(search)
          
         else:
         
          distinct_count= mongo.db.products.count_documents({'baslık':search.upper()})
          print(distinct_count)
          if distinct_count >0:
          
           distinct_= mongo.db.products.find({'baslık':search.upper()})
           print(distinct_)
          else:
           distinct_count= mongo.db.products.count_documents({'site':search})
           if distinct_count >0:
            distinct_= mongo.db.products.find({'site':search})
           else:
            distinct_count= mongo.db.products.count_documents({'Model':search.upper()}) 
            print(distinct_count)
            if distinct_count >0:
             
             distinct_= mongo.db.products.find({'Model':search.upper()})    
          
        else:   
         print(field)
         print(value)
         distinct_= mongo.db.products.find({field:value.upper()})
         print(distinct_)
         
       # print(distinct_)
      
    response=json_util.dumps(distinct_)
    
    return Response(response=response,mimetype='application/json')
       
#karsilastirma için urun dondurur      
@app.route('/compare',methods=["GET", "POST"])      
def compare():
    mongo.db.products.update_many( {}, { '$rename': { 'Fiyat': 'fiyat' } } )
    if request.method=="POST":
     model = request.form.get("model")
     products= mongo.db.products.find({'Model':model})
     response=json_util.dumps(products)
     return Response(response,mimetype='application/json')
 
 #modelleri dondurur       
@app.route('/compare/model',methods=["GET", "POST"])       
def getModel():
       if request.method=="GET":
        distinct_= mongo.db.products.distinct("Model")
        response=json_util.dumps(distinct_)
        return Response(response=response,mimetype='application/json')      
#markaları dondurur    
@app.route('/filtre/marka',methods=["GET", "POST"])       
def getMarka():
       if request.method=="GET":
        distinct_= mongo.db.products.distinct("Marka")
        response=json_util.dumps(distinct_)
        return Response(response=response,mimetype='application/json')   
    
#ekran boyutu dondurur
@app.route('/filtre/ekran',methods=["GET", "POST"])       
def getEkran():
       if request.method=="GET":
        distinct_= mongo.db.products.distinct("Ekran Boyutu")
        response=json_util.dumps(distinct_)
        return Response(response=response,mimetype='application/json')  

#disk boyutu dondurur    
@app.route('/filtre/disk',methods=["GET", "POST"])       
def getDisk():
       if request.method=="GET":
        distinct_= mongo.db.products.distinct("Disk Boyutu")
        response=json_util.dumps(distinct_)
        return Response(response=response,mimetype='application/json')   
    
#ram dondurur
@app.route('/filtre/ram',methods=["GET", "POST"])       
def getRam():
       if request.method=="GET":
        distinct_= mongo.db.products.distinct("Ram")
        response=json_util.dumps(distinct_)
        return Response(response=response,mimetype='application/json')   
#sistem dondurur
@app.route('/filtre/sistem',methods=["GET", "POST"])       
def getSistem():
       if request.method=="GET":
        distinct_= mongo.db.products.distinct("İşletim Sistemi")
        response=json_util.dumps(distinct_)
        return Response(response=response,mimetype='application/json')   

#admin panelinden urun gunceller dondurur
@app.route('/eticaret/update',methods=["GET", "POST"])
def eticaretupdate():
    item={}
    if request.method =="POST":
        _id = request.form.get("id")
        baslik = request.form.get("baslik")
        marka = request.form.get("marka")
        model = request.form.get("model")
        islemci = request.form.get("islemci")
        isletimsistem = request.form.get("isletimsistem")
        ekran = request.form.get("ekran")
        disk = request.form.get("disk")
        ram = request.form.get("ram")
        fiyat = request.form.get("fiyat")
        str=_id.split(":")
        str=str[1].split("}")
        print(str[0])
        str=str[0].split(" ")
        new_id=str[1]
        #mongo.db.eTicaret.update_many({}, {'$unset':{"url":1}})
        item["site"]="E-Ticaret"
        item["baslık"]=baslik.upper()
        item["Model"]=model.upper()
        item["Marka"]=marka.upper()
        item["İşlemci"]=islemci.upper()
        item["İşletim Sistemi"]=isletimsistem.upper()
        item["Ekran Boyutu"]=ekran.upper()
        item["Disk Boyutu"]=disk.upper()
        item["Ram"]=ram.upper()
        item["fiyat"]=fiyat.upper()
        print(item)
        a=mongo.db.products.count_documents(item)
        print(a)
    if(a==0):
        
        if(baslik != ""):
         mongo.db.products.update_one({'_id' : ObjectId(new_id)},{'$set':{'baslık':baslik.upper()}})
        if(marka != ""):
         mongo.db.products.update_one({'_id' : ObjectId(new_id)},{'$set':{'Marka':marka.upper()}})
        if(model != ""):
         mongo.db.products.update_one({'_id' : ObjectId(new_id)},{'$set':{'Model':model.upper()}})
        if(fiyat != ""):
         mongo.db.products.update_one({'_id' : ObjectId(new_id)},{'$set':{'fiyat':fiyat.upper()}})
        if(islemci != ""):
         mongo.db.products.update_one({'_id' : ObjectId(new_id)},{'$set':{'İşlemci':islemci.upper()}})
        if(isletimsistem != ""):
         mongo.db.products.update_one({'_id' : ObjectId(new_id)},{'$set':{'İşletim Sistemi':isletimsistem.upper()}})
        if(ekran != ""):
         mongo.db.products.update_one({'_id' : ObjectId(new_id)},{'$set':{'Ekran Boyutu':ekran.upper()}})
        if(disk != ""):
         mongo.db.products.update_one({'_id' : ObjectId(new_id)},{'$set':{'Disk Boyutu':disk.upper()}})
        if(ram != ""):
         mongo.db.products.update_one({'_id' : ObjectId(new_id)},{'$set':{'Ram':ram.upper()}})  
   
        return "null"
        
#admin panelinden urun siler  
@app.route('/eticaret/remove',methods=["GET", "POST"])    
def eticaretremove():
    if request.method =="POST":
        _id = request.form.get("id")
        str=_id.split(":")
        str=str[1].split("}")
        print(str[0])
        str=str[0].split(" ")
        new_id=str[1]
        mongo.db.products.delete_one({'_id': ObjectId(new_id)})
        
#admin panelinden urun ekler       
@app.route('/eticaret/add',methods=["GET", "POST"])
def eticaretadd():
    item={}
    if request.method =="POST":
        item["baslık"] = request.form.get("baslik").upper()
        item["Marka"] = request.form.get("marka").upper()
        item["Model"]= request.form.get("model").upper()
        item["İşlemci"] = request.form.get("islemci").upper()
        item["İşletim Sistemi"] = request.form.get("isletimsistem").upper()
        item["Ekran Boyutu"] = request.form.get("ekran").upper()
        item["Disk Boyutu"] = request.form.get("disk").upper()
        item["Ram"] = request.form.get("ram").upper()
        item["fiyat"]= request.form.get("fiyat").upper()
        item["site"]="E-Ticaret"
        item["url"]="Eticaret"
        print(item)
        a=mongo.db.products.count_documents(item)
        if(a==0):
         mongo.db.products.insert_one(item)
        
        
       
        #mongo.db.eTicaret.update_one({'_id' : new_id},{})
        return "null"

if __name__=="__main__":
    app.run(debug=True)