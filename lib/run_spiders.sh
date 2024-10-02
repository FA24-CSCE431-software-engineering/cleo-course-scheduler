#!/bin/bash

folder_name="data"

# Attempt to create the folder
if mkdir "$folder_name" 2>/dev/null; then
    echo "Folder '$folder_name' created successfully."
else
    echo "Folder '$folder_name' already exists."
fi

scrapy runspider ./scripts/course_spider.py --nolog &