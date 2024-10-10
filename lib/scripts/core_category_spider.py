# https://catalog.tamu.edu/undergraduate/general-information/university-core-curriculum/

import scrapy
import os
import csv
import logging
import re
from w3lib.html import remove_tags

class CoreCategorySpider(scrapy.Spider):
    name = "core_categories"
    start_urls = ['https://catalog.tamu.edu/undergraduate/general-information/university-core-curriculum/']

    def __init__(self, *args, **kwargs):
        super(CoreCategorySpider, self).__init__(*args, **kwargs)
        self.custom_logger = logging.getLogger(self.__class__.__name__)
        curr_dir = os.path.dirname(__file__)
        data_dir = os.path.join(curr_dir, "..", "data", "core_categories.csv")
        self.file = open(data_dir, 'w', newline='', encoding='utf-8')
        self.writer = csv.writer(self.file)
        self.writer.writerow(['core_categories'])

    def closed(self, reason):
        self.file.close()

    def parse(self, response):
        if response.status != 200:
            self.custom_logger.error(f"Failed to fetch the page. Status code: {response.status}")
            return

        categories = response.xpath('//div[@class="notinpdf onthispage"]//ul/li//text()').getall()

        for category in categories:
        # Using regex to split by ' - ' or ' – ' (dash and en dash)
            match = re.split(r'\s*[-–]\s*', category)
            if not match:
                continue
            if len(match[0]) > 1:
                self.writer.writerow([match[0]])

        
