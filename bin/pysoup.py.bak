#!/usr/bin/env python

from pixcat import Image
import requests
from bs4 import BeautifulSoup as bs
from rich import print
import csv

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:103.0) Gecko/20100101 Firefox/103.0'
}

url = 'https://asura.gg/'
#url = sys.stdin.read()

def get_html(url):
    r = requests.get(url, headers=headers)
    soup = bs(r.text, 'html.parser')
    return soup

def get_images(soup):
    images = []
    reader = soup.find_all('div', class_='utao styletwo')

    for uta in reader:
        alink = uta.find('a')
        href = alink.get('href')
        src = alink.find('img')
        src = src.get('src')
        title = alink.get('title')
        print(title + "+" + str(href) + "+" + str(src))

def pixcat():
    pass

def main(): 
    html = get_html(url)
    soup = get_images(html)
    #print(soup)

main()