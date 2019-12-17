#!/bin/bash

rm -rf /usr/share/nginx/html_back  && git clone https://git.dev.tencent.com/zhishengqianjun/blog.git  /usr/share/nginx/html_back

rm -rf /usr/share/nginx/html && mv /usr/share/nginx/html_back /usr/share/nginx/html

sed -i "s/aisky.men/apesite.xyz/g" /usr/share/nginx/html/sitemap.xml
