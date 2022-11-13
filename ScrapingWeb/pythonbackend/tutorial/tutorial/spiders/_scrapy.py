from argparse import Action
from asyncio.windows_events import NULL
from lib2to3.pgen2 import driver
from re import X
import time
from tracemalloc import start
from turtle import title
from typing import KeysView, Optional
from jmespath import Options, search
import pymongo
import scrapy
import urllib
from bs4 import BeautifulSoup
import requests
from asyncio import sleep, wait

from selenium import webdriver
from selenium.webdriver import ActionChains
from selenium.webdriver.chrome.service import Service
import webbrowser
from selenium.webdriver.common.by import By
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support import expected_conditions as EC
from ..items import TrendyolItem

class TrendyolScraping(scrapy.Spider):
   
    name= 'trendyol'
    allowed_domains =['www.trendyol.com']
    start_urls=[]
    


    def start_requests(self):
        
      
        myClient=pymongo.MongoClient("mongodb://localhost:27017")
        mydb=myClient["yazlab-app"]
        mycollection=mydb['products']
        mycollection.delete_many({ "site": "Trendyol" })
       
        self.element=mycollection.distinct('Model')
        self.start_urls=[]
        for x in self.element:
            print(x)
            url='https://www.trendyol.com/sr?q='+str(x)
            print(url)
            self.start_urls.append('https://www.trendyol.com/sr?q='+str(x))
        
       
         
        print(self.start_urls)
        print(self.element) 
        for u,x in zip(self.start_urls,self.element):
            yield scrapy.Request(u,  meta={'Model':x , },callback=self.parse,
                                  )
    def parse(self, response):
        print(response)
        #print('PARSE')
        myClient=pymongo.MongoClient("mongodb://localhost:27017")
        mydb=myClient["yazlab-app"]
        mycollection=mydb['products']
        items={}
        url=mycollection.find_one({'Model':str(response.meta['Model']).upper()})
        #product=response.xpath(".//div[@class='p-card-wrppr with-campaign-view']")
     
        items["url"]='https://www.trendyol.com'+str(response.xpath("//div[@class='p-card-chldrn-cntnr card-border']/a//@href").get())
        print(items["url"])
        items["marka"]=str(" "+response.xpath("//span[@class='prdct-desc-cntnr-ttl']/@title").get()).upper()
        items["baslık"]=str(response.xpath('//*[@id="search-app"]//div[@class="prdct-desc-cntnr-ttl-w two-line-text"]//span[2]//text()').get()).upper()
        #print(items["baslık"])
        items["fiyat"]=str(response.xpath("//div[@class='prc-box-dscntd']/text()[1]").get()).split('TL')[0].upper()
        items["site"]='Trendyol'
        items["Img"]=url['Img']
        items["Model"]=str(response.meta['Model']).upper()
        print(response.meta['Model'])
        print(items['baslık'])
        if items["Model"] in items["baslık"]:
         mycollection.insert_one(items)
             
        