#!/usr/bin/env python

from pixcat import Image
import requests
from bs4 import BeautifulSoup as bs
from rich import print
import csv
import sys

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:103.0) Gecko/20100101 Firefox/103.0'
}

#url = 'https://asura.gg/boundless-necromancer-chapter-2/'
url = sys.stdin.read()

def get_html(url):
    r = requests.get(url, headers=headers)
    soup = bs(r.text, 'html.parser')
    return soup

def get_images(soup):
    images = []
    reader = soup.find('div', class_='rdminimal')
    paragraphs = reader.find_all('p')
    for x in paragraphs:
        img = x.find('img')
        images.append(img.get('src'))
        print(img.get('src'))
    return images
    #print(images)

def pixcat():
    pass

def main():
    html = get_html(url)
    soup = get_images(html)
    #pixcat(soup)

main()
