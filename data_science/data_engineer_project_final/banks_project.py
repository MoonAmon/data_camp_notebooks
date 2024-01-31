import pandas as pd
import sqlalchemy as sql
import bs4
import datetime
import requests
import numpy as np


def log_progress(message):
    now = datetime.datetime.now()
    now_str = now.strftime("%Y-%m-%d %H:%M:%S")

    with open('code_log.txt', 'a') as file:
        file.write(now_str + ' : ' + message + '\n')


def extract(url, col_attributes):
    pass


def transform(df):
    pass


def load_to_csv(df, csv_path):
    pass


def load_to_db(df, table_name, conn):
    pass


def run_query(query, conn_db):
    pass


url = 'https://web.archive.org/web/20230908091635/https://en.wikipedia.org/wiki/List_of_largest_banks'
table_attr = ['Name', 'MC_USD_Billion']
table_attr_final = ['Name', 'MC_USD_Billion', 'MC_GBP_Billion', 'MC_EUR_Billion', 'MC_INR_Billion']
db_name = 'Banks.db'
table_name = 'Largest_banks'

