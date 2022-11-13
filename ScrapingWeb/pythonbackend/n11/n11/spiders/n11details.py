import ast
from cgitb import text
import csv
import pickle
from re import X
import string
import time
from tkinter import FALSE
from tracemalloc import start
from turtle import title
from typing import Optional
from jmespath import Options
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
import pymongo
from pymongo import MongoClient


class N11DetailsScraping(scrapy.Spider):
   
    name= 'n11details'
    allowed_domains =['www.n11.com']
    start_urls=[]
    url=[]
    
    
    def start_requests(self):
      myClient=pymongo.MongoClient("mongodb://localhost:27017")
      mydb=myClient["yazlab-app"]
      mycollection=mydb['products']
      mycollection.delete_many({'site':'Trendyol'})
      mycollection.delete_many({'site':'Teknosa'})
      mycollection.delete_many({'site':'Hepsiburada'})
      
      self.start_urls=mycollection.distinct('url',{'site':'N11'})
      for u in self.start_urls:
         yield scrapy.Request(u, callback=self.parse )
   
      mycollection.delete_many({'Model':{'$exists':False}})
      mycollection.delete_many({'Disk Boyutu':{'$exists':False}})
      

    def parse(self, response, **kwargs):
       print(response.url)
       myClient=pymongo.MongoClient("mongodb://localhost:27017")
       mydb=myClient["yazlab-app"]
       mycollection=mydb['products']
      
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
                 mycollection.update_one({'url':response.url},{"$set": {'Ram':str(product.xpath(".//li[@class='unf-prop-list-item']["+ str(i) +"]//p[@class='unf-prop-list-prop']//text()").get()).lstrip().lstrip().upper()}, },upsert=True)


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
         
             