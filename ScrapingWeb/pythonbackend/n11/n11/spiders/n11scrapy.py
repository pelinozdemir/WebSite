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

from ..items import N11Item




cluster=MongoClient()


class N11Scraping(scrapy.Spider):
    
    name= 'n11'
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
      
        products=response.xpath(".//div[@class='columnContent']")
        items=N11Item()
        for product in products:
           
                #URL = (product.xpath(".//div[@class='pro']/a//@href").get())
               
          
                
               
                items["url"]=product.xpath(".//div[@class='pro']/a//@href").get()
                items["baslık"]=str(product.xpath(".//h3[@class='productName']//text()").get()).upper()
                items["fiyat"]=str(product.xpath(".//div[@class='priceContainer ']//span[@class='newPrice cPoint priceEventClick']//ins//text()").get()).split(',')[0]
                items["site"]='N11'
                #print(items)
                yield items
                 
            
                
              
        page_number += 1
        if(page_number<45):
         print(base_url+f'?ipg={str(page_number)}')
         yield scrapy.Request(url=base_url+f'?pg={str(page_number)}', cb_kwargs={'base_url': base_url, 'page_number': page_number}, callback=self.parse)
          
         
              
              #//div[@class='base-product-image']//img/@src
             
        