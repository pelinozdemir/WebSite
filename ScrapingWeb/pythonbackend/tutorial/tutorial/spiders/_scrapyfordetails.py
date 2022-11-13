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

class TendyolDetailsScraping(scrapy.Spider):
   
    name= 'trendyoldetails'
    allowed_domains =['www.trendyol.com']
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
  
      self.start_urls=mycollection.distinct("url",{ "site" :"Trendyol"})
      for u in self.start_urls:
         yield scrapy.Request(u, callback=self.parse )
   
      mycollection.delete_many({'Disk Boyutu':{'$exists':False}})
      mycollection.delete_many({'Model':{'$exists':False}})
      
    
    def parse(self, response, **kwargs):
        
       print(response.url)
       myClient=pymongo.MongoClient("mongodb://localhost:27017")
       mydb=myClient["yazlab-app"]
       mycollection=mydb['products']
      
       
       
       products=response.xpath(".//ul[@class='detail-attr-container']")
       for product in products:
           find=0
           
           for i in range(0,33):
                
                
                if(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get()=='İşletim Sistemi'): 
                 mycollection.update_one({'url':response.url},{"$set": {'İşletim Sistemi':str(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[2]//text()").get()).upper()}, },upsert=True)
                 #print(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get())
                
                elif(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get()=='İşlemci Tipi'): 
                 mycollection.update_one({'url':response.url},{"$set": {'İşlemci':str(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[2]//text()").get()).upper()}, },upsert=True)
                 #print(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get())
                 
                 
                elif(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get()=='Ram (Sistem Belleği)'): 
                 mycollection.update_one({'url':response.url},{"$set": {'Ram':str(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[2]//text()").get()).upper()}, },upsert=True)
                 #print(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get())
                 

                elif(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get()=='SSD Kapasitesi'): 
                 mycollection.update_one({'url':response.url},{"$set": {'Disk Boyutu':str(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[2]//text()").get()).upper()}, },upsert=True)
                 print(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get())
                 
                 
                elif(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get()=='Ekran Boyutu'): 
                 mycollection.update_one({'url':response.url},{"$set": {'Ekran Boyutu':str(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[2]//text()").get()).upper()}, },upsert=True)
                 #print(product.xpath(".//li[@class='detail-attr-item']["+ str(i) +"]//span[1]//text()").get())
                  
                  
                
                else:
                   continue
            
       
       
           
     
        
        
        
        
        
     
              
              
          
         
              
              #//div[@class='base-product-image']//img/@src
             
        