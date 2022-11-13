from re import X
import time
from tracemalloc import start
from turtle import title
from typing import Optional
from jmespath import Options
import scrapy
import urllib
from bs4 import BeautifulSoup
import requests
from asyncio import sleep
import pymongo
from pymongo import MongoClient
from selenium import webdriver
from selenium.webdriver import ActionChains
from selenium.webdriver.chrome.service import Service
import webbrowser
from selenium.webdriver.common.by import By








class TeknosaScraping(scrapy.Spider):
    
    name= 'teknosa'
    allowed_domains =['www.teknosa.com']
    start_urls=[]

    def start_requests(self):
        
        options = webdriver.ChromeOptions()
        s=Service(executable_path="C:\\Users\\Pelin\\Downloads\\chromedriver_win32 (1)\\chromedriver.exe")
        options.add_argument('--ignore-certificate-errors')
        options.add_argument('--ignore-ssl-errors')
        self.driver = webdriver.Chrome(options=options,service=s)
        myClient=pymongo.MongoClient("mongodb://localhost:27017")
        mydb=myClient["yazlab-app"]
        mycollection=mydb['products']
        mycollection.delete_many({ "site": "Teknosa" })
       
        self.element=mycollection.distinct('Model')
        self.start_urls=[]
        i=0
        for x in self.element:
            print(x)
            self.start_urls.append('https://www.teknosa.com/arama/?s='+str(x))
          
            
        #print(self.start_urls)
        print(self.element) 
        for u,x in zip(self.start_urls,self.element):
            yield scrapy.Request(u,  meta={'Model':x },callback=self.parse,)
    def parse(self, response):
        print(response)
        #print('PARSE')
        
        myClient=pymongo.MongoClient("mongodb://localhost:27017")
        mydb=myClient["yazlab-app"]
        mycollection=mydb['products']
        url=mycollection.find_one({'Model':str(response.meta['Model']).upper()})
        
        items={}
        #product=response.xpath(".//div[@class='p-card-wrppr with-campaign-view']")
     
        items["url"]='https://www.teknosa.com'+(response.xpath("//a[@class='prd-link']/@href").get())
        print(items["url"])
        items["marka"]=str(" "+str(response.xpath("//a[@class='prd-link']/@title").get()).split(' ')[0]).upper()
        items["baslık"]=str(response.xpath("//a[@class='prd-link']/@title").get()).upper()
        #print(items["baslık"])
        items["fiyat"]=str(response.xpath("//div[@class='prd-block2  clearfix']//span[@class='prc prc-last ']//text()").get()).lstrip().split('TL')[0].upper()
        items["site"]='Teknosa'
        items["Img"]=url['Img']
        items["Model"]=str(response.meta['Model']).upper()
        print(response.meta['Model'])
        print(items['baslık'])
        
        
        if items["Model"] in items["baslık"]:
         mycollection.insert_one(items)
             
     
        
             
        