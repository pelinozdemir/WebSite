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
from ..items import HepsiburadaItem

class HepsiburadaScraping(scrapy.Spider):
   
    name= 'hepsiburada'
    allowed_domains =['www.hepsiburada.com']
    start_urls=[]
  


    def start_requests(self):
        
        myClient=pymongo.MongoClient("mongodb://localhost:27017")
        mydb=myClient["yazlab-app"]
        mycollection=mydb['products']
        mycollection.delete_many({ "site": "Hepsiburada" })
       
        self.element=mycollection.distinct('Model')
        self.start_urls=[]
        for x in self.element:
            print(x)
            url='https://www.hepsiburada.com/ara?q='+str(x)
            print(url)
            self.start_urls.append('https://www.hepsiburada.com/ara?q='+str(x))
     
         
        print(self.start_urls)
        print(self.element) 
        for u,x in zip(self.start_urls,self.element):
            yield scrapy.Request(u,  meta={'Model':x },callback=self.parse,
                                  )
    def parse(self, response):
        print("HELLUUU")
        print(response)
        #print('PARSE')
        myClient=pymongo.MongoClient("mongodb://localhost:27017")
        mydb=myClient["yazlab-app"]
        mycollection=mydb['products']
        items={}
        url=mycollection.find_one({'Model':str(response.meta['Model']).upper()})
        
        ''' options = webdriver.ChromeOptions()
        s=Service(executable_path="C:\\Users\\Pelin\\Downloads\\chromedriver_win32 (1)\\chromedriver.exe")
        options.add_argument('--ignore-certificate-errors')
        options.add_argument('--ignore-ssl-errors')
        self.driver = webdriver.Chrome(options=options,service=s)
        self.driver.get(response)'''
        #product=response.xpath(".//div[@class='p-card-wrppr with-campaign-view']")
       
        items["url"]='https://www.hepsiburada.com'+str(response.xpath("//li[@id='i0']//a[@target='_blank']//@href").get())
        print(items["url"])
        items["marka"]=str(" "+str(response.xpath("//li[@id='i0']//h3[@type='comfort']//text()").get()).split(' ')[0]).upper()
        items["baslık"]=str(response.xpath("//li[@id='i0']//h3[@type='comfort']//text()").get()).upper()
        items["site"]='Hepsiburada'
        items["Img"]=url['Img']
        items["Model"]=str(response.meta['Model']).upper()
        print(response.meta['Model'])
        print(items['baslık'])
        if items["Model"] in items["baslık"]:
         mycollection.insert_one(items)    
        