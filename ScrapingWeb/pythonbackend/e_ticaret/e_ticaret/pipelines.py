# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
import pymongo


class ETicaretPipeline:
    collection_name = 'eTicaret'

    def __init__(self, mongo_uri, mongo_db):
        self.mongo_uri ='mongodb://localhost:27017/'
        self.mongo_db = "yazlab-app"
     

    @classmethod
    def from_crawler(cls, crawler):
        return cls(
            mongo_uri=crawler.settings.get('MONGODB_SERVER'),
            mongo_db=crawler.settings.get('MONGO_DATABASE', 'items')
        )

    def open_spider(self, spider):
        self.client = pymongo.MongoClient(self.mongo_uri)
        self.db = self.client[self.mongo_db]

    def close_spider(self, spider):
        self.client.close()

    def process_item(self, item, spider):
        if spider.name == 'eticaret':
         self.db[self.collection_name].insert_one(ItemAdapter(item).asdict())
         return item
        elif spider.name=='eticaretdetails':
            return item