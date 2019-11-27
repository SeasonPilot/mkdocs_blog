#!/bin/bash

rm -rf /usr/share/nginx/html_back  && git clone --depth=1 https://github.com/gaviners/gaviners.github.io  /usr/share/nginx/html_back

rm -rf /usr/share/nginx/html && mv /usr/share/nginx/html_back /usr/share/nginx/html
