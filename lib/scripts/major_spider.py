# https://catalog.tamu.edu/undergraduate/

import scrapy
import os
import csv
import logging
import unidecode

class MajorSpider(scrapy.Spider):
    name = "majors"
    start_urls = ['https://catalog.tamu.edu/undergraduate/']
    college_names = ['College of Agriculture and Life Sciences', 'College of Architecture', 'College of Arts and Sciences', 'Mays Business School', 'College of Dentistry', 'College of Education and Human Development', 'College of Engineering', 'Bush School of Government and Public Service', 'College of Nursing', 'College of Performance, Visualization and Fine Arts', 'School of Public Health', 'College of Veterinary Medicine and Biomedical Sciences', 'School of Military Sciences', 'Texas A&​M University at Galveston', 'Texas A&​M University at Qatar']
    unique_majors = set()

    def __init__(self, *args, **kwargs):
        super(MajorSpider, self).__init__(*args, **kwargs)
        self.custom_logger = logging.getLogger(self.__class__.__name__)
        curr_dir = os.path.dirname(__file__)
        data_dir = os.path.join(curr_dir, "..", "data", "majors.csv")
        self.file = open(data_dir, 'w', newline='', encoding='utf-8')
        self.writer = csv.writer(self.file)
        self.writer.writerow(['cname', 'mname'])

    def closed(self, reason):
        self.file.close()

    def parse(self, response):
        if response.status != 200:
            self.custom_logger.error(f"Failed to fetch the page. Status code: {response.status}")
            return

        for college in response.css('li.isparent'):
            college_name = college.css('a::text').get().strip()
            if college_name not in self.college_names:
                continue

            # Now get the majors within this college
            for major in college.css('ul.levelthree li a'):
                major_name = major.css('a::text').get().split(' -')[0].strip()  # Get major and clean up the string

                major_tuple = (college_name, major_name)

                if major_tuple not in self.unique_majors:
                    self.unique_majors.add(major_tuple)

                    try:
                        self.writer.writerow([unidecode.unidecode(college_name), unidecode.unidecode(major_name)])
                    except Exception as e:
                        self.custom_logger.error(f"Error processing course: {e}")
                    continue

                    # Yield data in the desired format
                    # yield {
                    #     'cname': college_name,
                    #     'major': unidecode.unidecode(major_name),
                    # }