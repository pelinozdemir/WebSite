import ast
import csv
import pickle
from re import X
import time
from tracemalloc import start
from turtle import title
from typing import Optional
from xmlrpc.client import boolean
from jmespath import Options
import pymongo
import scrapy
import urllib
from bs4 import BeautifulSoup
import requests
from asyncio import sleep
from selenium import webdriver
from selenium.webdriver import ActionChains
from selenium.webdriver.chrome.service import Service
import webbrowser
from selenium.webdriver.common.by import By

class TeknosaDetailsScraping(scrapy.Spider):
   
    name= 'teknosadetails'
    allowed_domains =['www.teknosa.com']
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
  
      self.start_urls=mycollection.distinct("url",{ "site" :"Teknosa"})
      for u in self.start_urls:
         yield scrapy.Request(u, callback=self.parse )
   
      '''mycollection.delete_many({'Disk Boyutu':{'$exists':False}})
      mycollection.delete_many({'Model':{'$exists':False}})'''
      
    
    def parse(self, response, **kwargs):
        
       print(response.url)
       myClient=pymongo.MongoClient("mongodb://localhost:27017")
       mydb=myClient["yazlab-app"]
       mycollection=mydb['products']
     
         
       '''   options = webdriver.ChromeOptions()
       s=Service(executable_path="C:\\Users\\Pelin\\Downloads\\chromedriver_win32 (1)\\chromedriver.exe")
       options.add_argument('--ignore-certificate-errors')
       options.add_argument('--ignore-ssl-errors')
       driver = webdriver.Chrome(options=options,service=s)
       driver.get(response)
       driver.find_element(By.XPATH,"//div[@class='pdp-acc pdp-section']").click()'''
       products=response.xpath("//div[@class='pdp-acc pdp-section']//div[@class='pdp-acc-body']//div[@class='ptf-body']//table")
       for product in products:
           find=0
           
           for i in range(0,30):
                
                
                if(product.xpath(".//div[@class='pdp-acc-body']//table//tr//th["+ str(i) +"]/text()").get()=='İşletim Sistemi Yazılımı'): 
                 mycollection.update_one({'url':response.url},{"$set": {'İşletim Sistemi':str(product.xpath(".//div[@class='pdp-acc-body']//table//tr//td["+ str(i) +"]/text()").get()).upper()}, },upsert=True)
                 print(product.xpath(".//div[@class='pdp-acc-body']//table//tr//td["+ str(i) +"]/text()").get())
                
                elif(product.xpath(".//div[@class='pdp-acc-body']//table//tr//th["+ str(i) +"]/text()").get()=='İşlemci'): 
                 mycollection.update_one({'url':response.url},{"$set": {'İşlemci':str(product.xpath(".//div[@class='pdp-acc-body']//table//tr//td["+ str(i) +"]/text()").get()).upper()}, },upsert=True)
                 #print(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get())
                 print(product.xpath(".//div[@class='pdp-acc-body']//table//tr//td["+ str(i) +"]/text()").get())
                 
                elif(product.xpath(".//div[@class='pdp-acc-body']//table//tr//th["+ str(i) +"]/text()").get()=='Ram'): 
                 mycollection.update_one({'url':response.url},{"$set": {'Ram':str(product.xpath(".//div[@class='pdp-acc-body']//table//tr//td["+ str(i) +"]/text()").get()).upper()}, },upsert=True)
                 #print(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get())
                 print(product.xpath(".//div[@class='pdp-acc-body']//table//tr//td["+ str(i) +"]/text()").get())

                elif(product.xpath(".//div[@class='pdp-acc-body']//table//tr//th["+ str(i) +"]/text()").get()=='SSD Kapasitesi'): 
                 mycollection.update_one({'url':response.url},{"$set": {'Disk Boyutu':str(product.xpath(".//div[@class='pdp-acc-body']//table//tr//td["+ str(i) +"]/text()").get()).upper()}, },upsert=True)
                 print(product.xpath(".//div[@class='pdp-acc-body']//table//tr//td["+ str(i) +"]/text()").get())
                 
                 
                elif(product.xpath(".//div[@class='pdp-acc-body']//table//tr//th["+ str(i) +"]/text()").get()=='Ekran Boyutu'): 
                 mycollection.update_one({'url':response.url},{"$set": {'Ekran Boyutu':str(product.xpath(".//div[@class='pdp-acc-body']//table//tr//td["+ str(i) +"]/text()").get()).upper()}, },upsert=True)
                 print(product.xpath(".//div[@class='pdp-acc-body']//table//tr//td["+ str(i) +"]/text()").get())
                  
                  
                
                else:
                   continue
            
       
       
           
     
        
        
        
        
        
     
              
              
          
         
              
              #//div[@class='base-product-image']//img/@src
             
        