import bs4, requests
import pandas as pd

def extract(url):
    r = requests.get(url)
    soup = bs4.BeautifulSoup(r.content, 'html.parser')
    table = soup.find('table', class_='wikitable')

    df = pd.read_html(str(table))[0]
    return df




