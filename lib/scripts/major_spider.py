# https://careercenter.tamu.edu/current-students/explore-majors-and-careers/majors

import scrapy
import os
import csv
import logging
from w3lib.html import remove_tags

class MajorSpider(scrapy.Spider):
    name = "majors"
    start_urls = ['https://careercenter.tamu.edu/current-students/explore-majors-and-careers/majors']

    def __init__(self, *args, **kwargs):
        super(MajorSpider, self).__init__(*args, **kwargs)
        self.custom_logger = logging.getLogger(self.__class__.__name__)
        curr_dir = os.path.dirname(__file__)
        data_dir = os.path.join(curr_dir, "..", "data", "majors.csv")
        self.file = open(data_dir, 'w', newline='', encoding='utf-8')
        self.writer = csv.writer(self.file)
        self.writer.writerow(['majors'])

    def closed(self, reason):
        self.file.close()

    def parse(self, response):
        if response.status != 200:
            self.custom_logger.error(f"Failed to fetch the page. Status code: {response.status}")
            return

        majors = response.xpath('//div/h2/a[@class="major_a"]/text()').getall()
        for major in majors:
            try:
                self.writer.writerow([major])
            except Exception as e:
                self.custom_logger.error(f"Error processing course: {e}")
                continue