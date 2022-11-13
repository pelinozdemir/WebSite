
import scrapy

import pymongo
from pymongo import MongoClient

cluster=MongoClient()


class E_TicaretScraping(scrapy.Spider):
    
    name= 'eticaret'
    allowed_domains =['www.n11.com']
    start_urls=[]
   
    start_urls.append('https://www.n11.com/bilgisayar/dizustu-bilgisayar'),
    
    print(start_urls)
    def start_requests(self):
        for u in self.start_urls:
            yield scrapy.Request(u, callback=self.parse,
                                     cb_kwargs={'base_url': u, 'page_number': 1},
                                  )
    def parse(self, response, base_url,page_number):
        print(response)
        products=response.xpath(".//div[@class='columnContent']")
        items={}
        myClient=pymongo.MongoClient("mongodb://localhost:27017")
        mydb=myClient["yazlab-app"]
        mycollection=mydb['eTicaret']
        for product in products:
           
                items["url"]=product.xpath(".//div[@class='pro']/a//@href").get()
                items["baslık"]=str(product.xpath(".//h3[@class='productName']//text()").get()).split(',')[0].upper()
                items["fiyat"]=product.xpath(".//div[@class='priceContainer ']//span[@class='newPrice cPoint priceEventClick']//ins//text()").get()
                items["site"]='E-Ticaret'
                yield items
                
                   
            
                
              
        page_number += 1
        if(page_number<20):
          print(base_url+f'?ipg={str(page_number)}')
          yield scrapy.Request(url=base_url+f'?pg={str(page_number)}', cb_kwargs={'base_url': base_url, 'page_number': page_number}, callback=self.parse)
          
         
              
              #//div[@class='base-product-image']//img/@src
             
        