
import pymongo
import scrapy


class TendyolDetailsScraping(scrapy.Spider):
   
    name= 'hepsiburadadetails'
    allowed_domains =['www.hepsiburada.com']
    start_urls=[]
    urls=[]
    myClient=pymongo.MongoClient("mongodb://localhost:27017")
    mydb=myClient["yazlab-app"]
    mycollection=mydb['products']
    #mycollection.delete_many({'Model':{'$exists':False}})
    
    def start_requests(self):
      myClient=pymongo.MongoClient("mongodb://localhost:27017")
      mydb=myClient["yazlab-app"]
      mycollection=mydb['products']
  
      self.start_urls=mycollection.distinct("url",{ "site" :"Hepsiburada"})
      for u in self.start_urls:
         yield scrapy.Request(u, callback=self.parse )
   
      mycollection.delete_many({'Disk Boyutu':{'$exists':False}})
      mycollection.delete_many({'Model':{'$exists':False}})
      
    
    def parse(self, response, **kwargs):
        
       print(response.url)
       myClient=pymongo.MongoClient("mongodb://localhost:27017")
       mydb=myClient["yazlab-app"]
       mycollection=mydb['products']
       mycollection.update_one({'url':response.url},{"$set": {'Fiyat':str(response.xpath("//span[@id='offering-price']//span//text()").get()).upper()}, },upsert=True)

 
      
       for i in range(0,44):
               
                
                if(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//th[1]//text()").get()=='İşletim Sistemi'): 
                 
              
                   if(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//td[1]//a//text()").get()!= None): 
                     mycollection.update_one({'url':response.url},{"$set": {'İşletim Sistemi':str(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//td[1]//a//text()").get()).upper()}, },upsert=True)
                     
                   elif(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr[12]//td[1]//span//text()").get()!= None):
        
                     mycollection.update_one({'url':response.url},{"$set": {'İşletim Sistemi':str(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr[12]//td[1]//span//text()").get()).upper()}, },upsert=True)
                     
                elif(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//th[1]//text()").get()=='İşlemci Tipi'): 
                
                 
                 if(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//td[1]//a//text()").get()!= None): 
                     mycollection.update_one({'url':response.url},{"$set": {'İşlemci':str(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//td[1]//a//text()").get()).upper()}, },upsert=True)
                     
                 elif(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr[12]//td[1]//span//text()").get()!= None):
                     
                     mycollection.update_one({'url':response.url},{"$set": {'İşlemci':str(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr[12]//td[1]//span//text()").get()).upper()}, },upsert=True)
                 
                elif(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//th[1]//text()").get()=='Ram (Sistem Belleği)'): 
                  
                   
                   if(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//td[1]//a//text()").get()!= None): 
                     mycollection.update_one({'url':response.url},{"$set": {'Ram':str(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//td[1]//a//text()").get()).upper()}, },upsert=True)
                    
                   elif(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr[12]//td[1]//span//text()").get()!= None):
                    
                     mycollection.update_one({'url':response.url},{"$set": {'Ram':str(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr[12]//td[1]//span//text()").get()).upper()}, },upsert=True)

                elif(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//th[1]//text()").get()=='SSD Kapasitesi'): 
                 
                   
                   if(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//td[1]//a//text()").get()!= None): 
                     mycollection.update_one({'url':response.url},{"$set": {'Disk Boyutu':str(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//td[1]//a//text()").get()).upper()}, },upsert=True)
                    
                   elif(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr[12]//td[1]//span//text()").get()!= None):
                   
                     mycollection.update_one({'url':response.url},{"$set": {'Disk Boyutu':str(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr[12]//td[1]//span//text()").get()).upper()}, },upsert=True)
                 
                 
                elif(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//th[1]//text()").get()=='Ekran Boyutu'): 
                 
                   
                   if(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//td[1]//a//text()").get()!= None): 
                     mycollection.update_one({'url':response.url},{"$set": {'Ekran Boyutu':str(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr["+str(i)+"]//td[1]//a//text()").get()).upper()}, },upsert=True)
                     
                   elif(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr[12]//td[1]//span//text()").get()!= None):
                     
                     mycollection.update_one({'url':response.url},{"$set": {'Ekran Boyutu':str(response.xpath("//section[@class='product-detail-container container desktop']//div[@class='list-container']//div[@id='tabProductDesc']//table[2]//tbody//table[@class='data-list tech-spec'][1]//tbody//tr[12]//td[1]//span//text()").get()).upper()}, },upsert=True)
                  
                
                else:
                   continue
            
       
       
           
     
        
        
        
        
        
     
              
              
          
         
              
              #//div[@class='base-product-image']//img/@src
             
        