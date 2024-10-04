# https://catalog.tamu.edu/undergraduate/general-information/university-core-curriculum/

import scrapy
import os
import csv
import logging
import unidecode
import re

class CoreCourseSpider(scrapy.Spider):
    name = "core_course"
    start_urls = ['https://catalog.tamu.edu/undergraduate/general-information/university-core-curriculum/']

    def __init__(self, *args, **kwargs):
        super(CoreCourseSpider, self).__init__(*args, **kwargs)
        self.custom_logger = logging.getLogger(self.__class__.__name__)
        curr_dir = os.path.dirname(__file__)
        data_dir = os.path.join(curr_dir, "..", "data", "core_courses.csv")
        self.file = open(data_dir, 'w', newline='', encoding='utf-8')
        self.writer = csv.writer(self.file)
        self.writer.writerow(['category', 'course_code', 'course_number', 'course_title', 'credit_hours'])

    def closed(self, reason):
        self.file.close()

    def parse(self, response):
        # Find all h2 tags that represent category headings
        headings = response.xpath('//h2[@class="Undergrad-Catalog_body-text-10-12-no-indent"]')

        for heading in headings:
            # Extract the category (heading) text
            match = re.split(r'\s*[-–]\s*', str(heading.xpath('.//text()').get()))
            if not match or len(match[0]) <= 1:
                continue
        
            course_category = match[0]

            # Find the table that belongs to this category (the first following sibling table)
            table = heading.xpath('following-sibling::table[1]')
            
            # Check if the table exists
            if table:
                # Iterate through each row in the tbody of the found table
                for row in table.xpath('.//tbody/tr'):
                    # Extract course code from the <a> tag inside the first <td>
                    course = row.xpath('.//td[@class="codecol"]/a/text()').get()
                    course = unidecode.unidecode(course).split()
                    course_code = course[0]
                    course_number = course[1].split('/')[0]

                    # Extract course title from the second <td>
                    course_title = row.xpath('.//td[2]/text()').get()

                    # Extract course hours from the third <td>
                    course_hours = row.xpath('.//td[@class="hourscol"]/text()').get()

                    self.writer.writerow([course_category, course_code, course_number, course_title, course_hours])

                    # Yield a dictionary containing the course data and the category it belongs to
                    # yield {
                    #     'category': category,  # Add the category here
                    #     'course_code': course_code,
                    #     'course_description': course_title,
                    #     'course_hours': course_hours
                    # }

        
