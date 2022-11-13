

import scrapy


import pymongo



class E_TicaretDetailsScraping(scrapy.Spider):
   
    name= 'eticaretdetails'
    allowed_domains =['www.n11.com']
    start_urls=[]
    url=[]
    
   
    def start_requests(self):
      myClient=pymongo.MongoClient("mongodb://localhost:27017")
      mydb=myClient["yazlab-app"]
      mycollection=mydb['eTicaret']
    
      self.start_urls=mycollection.distinct('url')
      for u in self.start_urls:
         yield scrapy.Request(u, callback=self.parse )
   
      mycollection.delete_many({'Model':{'$exists':False}})
      mycollection.delete_many({'Disk Boyutu':{'$exists':False}})
      mycollection.update_many({},{'$set':{'url':'Eticaret'}})
      eticaret=mycollection.find({})
      for var in eticaret:
        mydb.products.insert_one(var)
      
    def parse(self, response, **kwargs):
       print(response.url)
       myClient=pymongo.MongoClient("mongodb://localhost:27017")
       mydb=myClient["yazlab-app"]
       mycollection=mydb['eTicaret']
     
       if mycollection.count_documents({'url':response.url})==1:
        print(mycollection.count_documents({'url':response.url}))
        mycollection.update_one({'url':response.url},{"$set":{'Img':str(response.xpath('//*[@id="unf-p-id"]/div/div[2]/div[2]/div[1]/div/div[1]/div[2]/div/a//@href').get())}});
        
        products=response.xpath(".//ul[@class='unf-prop-list']")
        for product in products:
           
           for x in range(0,30):
            #her model degeri iceren urunu almak icin    
            if(product.xpath(".//li[@class='unf-prop-list-item']["+ str(x) +"]//p[@class='unf-prop-list-title']//text()").get()=='Model'): 
               for i in range(0,30):
                if(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-title']//text()").get()=='Model'):  
                 #print(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-prop']//text()").get()) 
                 mycollection.update_one({'url':response.url},{"$set": {'Model':str(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-prop']//text()").get()).lstrip().upper()}, },upsert=True)
                
                elif(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-title']//text()").get()=='İşletim Sistemi'): 
                 mycollection.update_one({'url':response.url},{"$set": {'İşletim Sistemi':str(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-prop']//text()").get()).lstrip().upper()}, },upsert=True)
                  
                
                elif(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-title']//text()").get()=='İşlemci'): 
                 mycollection.update_one({'url':response.url},{"$set": {'İşlemci':str(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-prop']//text()").get()).lstrip().upper()}, },upsert=True)

                 
                elif(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-title']//text()").get()=='Bellek Kapasitesi'): 
                 mycollection.update_one({'url':response.url},{"$set": {'Ram':str(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-prop']//text()").get()).lstrip().upper()}, },upsert=True)


                elif(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-title']//text()").get()=='Disk Kapasitesi'): 
                 mycollection.update_one({'url':response.url},{"$set": {'Disk Boyutu':str(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-prop']//text()").get()).lstrip().upper()}, },upsert=True)
                 
                 
                elif(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-title']//text()").get()=='Disk Türü'): 
                 mycollection.update_one({'url':response.url},{"$set": {'Disk Türü':str(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-prop']//text()").get()).lstrip().upper()}, },upsert=True)
                 
                  
                elif(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-title']//text()").get()=='Ekran Boyutu'): 
                 mycollection.update_one({'url':response.url},{"$set": {'Ekran Boyutu':str(str(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-prop']//text()").get()).lstrip().split("\"")[0].replace(".",",")+" INÇ")}, },upsert=True)
                
                  
                 
                elif(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-title']//text()").get()=='Marka'): 
                 mycollection.update_one({'url':response.url},{"$set": {'Marka':str(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-prop']//text()").get()).upper() }},upsert=True)
                else:
                   continue
            
       
             
       else:
        mycollection.delete_one({'url':response.url})       
       
      
             