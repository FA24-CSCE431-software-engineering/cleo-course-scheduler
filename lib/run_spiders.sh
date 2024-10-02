#!/bin/bash

folder_name="data"

# Attempt to create the folder
mkdir "$folder_name" 2>/dev/null

scrapy runspider ./scripts/course_spider.py --nolog &
scrapy runspider ./scripts/major_spider.py --nolog &
scrapy runspider ./scripts/core_category_spider.py --nolog &
scrapy runspider ./scripts/core_course_spider.py --nolog &