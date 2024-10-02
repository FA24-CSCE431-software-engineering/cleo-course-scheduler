# https://catalog.tamu.edu/undergraduate/course-descriptions/csce/

import scrapy
import os
import csv
import logging
import re
import unidecode
from w3lib.html import remove_tags

class CourseSpider(scrapy.Spider):
    name = "courses"
    start_urls = ['https://catalog.tamu.edu/undergraduate/course-descriptions/csce/']

    def __init__(self, *args, **kwargs):
        super(CourseSpider, self).__init__(*args, **kwargs)
        self.custom_logger = logging.getLogger(self.__class__.__name__)
        curr_dir = os.path.dirname(__file__)
        data_dir = os.path.join(curr_dir, "..", "data", "courses.csv")
        self.file = open(data_dir, 'w', newline='', encoding='utf-8')
        self.course_pattern = r'[A-Z]{4}\s*\d{3}'
        self.course_title_pattern = r'([A-Z]{4}\s*\d{3})(?:/\s*[A-Z]{4}\s*\d{3})*'
        self.writer = csv.writer(self.file)
        self.writer.writerow(['ccode', 'cnumber', 'cname', 'credit_hours', 'lecture_hours', 'lab_hours', 'description', 'prereq_1', 'prereq_2', 'prereq_3'])

    def closed(self, reason):
        self.file.close()

    def parse_header(self, text):
        # Extract the course code from the full text
        match = re.search(self.course_pattern, text)
        code = match.group(0).split(' ')

        # Returns course code, course number, and course title
        return code[0], code[1], re.sub(self.course_title_pattern, '', text, count=1).strip()
    
    def parse_hours(self, text):
        hours = {'chours': '0', 'lhours': '0', 'labhours': '0'}
        for hour in text:
            hour = hour.strip()
            if 'Credit' in hour:
                hours['chours'] = re.search(r'\d+', hour).group()
            if 'Lecture' in hour:
                hours['lhours'] = re.search(r'\d+', hour).group()
            if 'Lab' in hour:
                hours['labhours'] = re.search(r'\d+', hour).group()
        return hours
    
    def parse_prereq(self, text):
        text = ' '.join(text).strip()
        text = re.split(r'Cross Listing:', text)[0].strip()
                
        # Remove the leading "Prerequisite:" or "Prerequisites:" if present
        text = re.sub(r'^(Prerequisite|Prerequisites):\s*', '', text)

        # Remove html tags
        text = remove_tags(text)

        # Parse equivalent and non equivalent prerequisites
        groups = re.split(r'\s*(?:and|;)\s*', text)
        groups = list(map(lambda x: unidecode.unidecode(x.strip(', ')), groups))

        # Extract out the course from the text
        groups = [re.findall(self.course_pattern, course) for course in groups]
        groups = [courses for courses in groups if courses]
        return groups

    def parse(self, response):
        if response.status != 200:
            self.custom_logger.error(f"Failed to fetch the page. Status code: {response.status}")
            return

        courses = response.css('div.courseblock')
        if not courses:
            self.custom_logger.warning("No course blocks found on the page.")
            return

        for course in courses:
            try:
                ccode, cnumber, cname = self.parse_header(unidecode.unidecode(course.css('h2.courseblocktitle::text').get()).strip())
                hours = self.parse_hours(' '.join(course.css('span.hours strong::text').getall()).split('.'))
                description = course.css('p.courseblockdesc::text').getall()[1].strip()
                prereqs = self.parse_prereq(course.xpath('.//strong[contains(text(), "Prerequisite") or contains(text(), "Prerequisites")]/following-sibling::node()').getall())
                
                self.writer.writerow([ccode, cnumber, cname, hours['chours'], hours['lhours'], hours['labhours'], description] + ['; '.join(prereq) for prereq in prereqs])
            except Exception as e:
                self.custom_logger.error(f"Error processing course: {e}")
                continue
