import pandas as pd
import sqlalchemy as sql
import bs4
import datetime
import requests
import numpy as np
from lxml import html


def log_progress(message):
    now = datetime.datetime.now()
    now_str = now.strftime("%Y-%m-%d %H:%M:%S")

    with open('code_log.txt', 'a') as file:
        file.write(now_str + ' : ' + message + '\n')


def extract(url, table_attribs):
    r = requests.get(url)
    bs_html = bs4.BeautifulSoup(r.content, 'html.parser')
    tables = bs_html.find_all('tbody')
    table = tables[0]
    rows = table.find_all('tr')
    df = pd.DataFrame(columns=table_attribs)

    for row in rows:
        cols = row.find_all('td')

        if len(cols) != 0:
            text_a = cols[1].find_all('a')[1]
            print(text_a)
            data_dict = {"Name": text_a,
                         "MC_USD_Billion": cols[2].contents[0]}
            df1 = pd.DataFrame(data_dict, index=[0])
            df = pd.concat([df, df1], ignore_index=True)

    return df


def transform(df):
    old_values = df['MC_USD_Billion'].tolist()
    new_values = []

    for value in old_values:
        value = np.round(float(value.replace(',', '')),2)
        new_values.append(value)

    df['MC_USD_Billion'] = new_values

    df_exchange = pd.read_csv('exchange_rate.csv')
    dict_exchange = df_exchange.set_index('Currency').to_dict()['Rate']

    df['MC_GBP_Billion'] = [np.round(x * dict_exchange['GBP'], 2) for x in df['MC_USD_Billion']]
    df['MC_EUR_Billion'] = [np.round(x * dict_exchange['EUR'], 2) for x in df['MC_USD_Billion']]
    df['MC_INR_Billion'] = [np.round(x * dict_exchange['INR'], 2) for x in df['MC_USD_Billion']]

    return df


def load_to_csv(df, csv_path):
    df.to_csv(csv_path)


def load_to_db(df, table_name, conn):
    df.to_sql(table_name, con=conn, if_exists='replace', index=False)


def run_query(query, conn_db):
    print(query)

    with conn_db.connect() as connection:
        result_proxy = connection.execute(sql.text(query))
        rows = result_proxy.fetchall()

        for row in rows:
            print(row)

    connection.close()


url = 'https://web.archive.org/web/20230908091635/https://en.wikipedia.org/wiki/List_of_largest_banks'
table_attr = ['Name', 'MC_USD_Billion']
table_attr_final = ['Name', 'MC_USD_Billion', 'MC_GBP_Billion', 'MC_EUR_Billion', 'MC_INR_Billion']
db_name = 'Banks.db'
table_name = 'Largest_banks'


log_progress('Extracting the data...')

df = extract(url, table_attr)

log_progress('Extraction complete. Initialing transformation process...')

clean_df = transform(df)

log_progress('Transformation complete. Initialing loading csv process...')

load_to_csv(clean_df, 'csv_banks.csv')

log_progress('Load csv complete. Connecting to database...')

engine = sql.create_engine('sqlite:///Banks.db')

log_progress('Connection complete. Initialing loading data to database...')

load_to_db(clean_df, table_name, engine)

query1 = f'SELECT * FROM {table_name}'
query2 = f'SELECT AVG({table_attr_final[2]}) FROM {table_name}'
query3 = f'SELECT {table_attr[0]} FROM {table_name} LIMIT 5'

log_progress(f'Load database complete. Running the query {query1}...')

run_query(query1, engine)

log_progress(f'Running the query {query2}...')

run_query(query2, engine)

log_progress(f'Running the query {query3}...')

run_query(query3, engine)
