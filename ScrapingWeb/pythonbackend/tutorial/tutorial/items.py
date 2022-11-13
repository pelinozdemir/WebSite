# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy
from scrapy.item import Item, Field

class TrendyolItem(scrapy.Item):
    url=Field()
    baslık=Field()
    fiyat=Field()
    site=Field()
    marka=Field()
 