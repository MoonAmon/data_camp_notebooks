import datetime

import pandas as pd
import requests
import bs4
import sqlalchemy as sql



def extract(url, table_attribs):
    """ This function extracts the required information from the
    url and returns a dataframe """

    r = requests.get(url)
    bs_html = bs4.BeautifulSoup(r.content, 'html.parser')
    tbodies = bs_html.find_all('tbody')
    tbody = tbodies[2]
    rows = tbody.find_all('tr')
    df = pd.DataFrame(columns=table_attribs)

    for row in rows:
        cols = row.find_all('td')
        if len(cols) != 0:
            if cols[0].find('a') is not None and '—' not in cols[2]:
                data_dict = {"Country": cols[0].a.contents[0],
                             "GDP_USD_millions": cols[2].contents[0]}
                df1 = pd.DataFrame(data_dict, index=[0])
                df = pd.concat([df, df1], ignore_index=True)

    return df


def transform(df):
    """ This function converts the GDP information from Currency
    format to float value, transforms the information. Function returns a dataframe"""
    old_gdp = df['GDP_USD_millions'].tolist()
    new_gdp = []

    for value in old_gdp:
        value = float(value.replace(',', ''))
        value = round(value / 1000, 2)
        new_gdp.append(value)

    df['GDP_USD_millions'] = new_gdp
    df.rename(columns={'GDP_USD_millions': 'GDP_USD_billions'}, inplace=True)

    return df


def load_to_csv(df, csv_path):
    """ This function saves the final dataframe as a csv file in
    a provided path. Function returns nothing """
    df.to_csv(csv_path)


def load_to_db(df, sql_connection, table_name):
    """ This function saves the final dataframe as a table in a
    with the provided name in the sql database. Function returns nothing """
    df.to_sql(table_name, con=sql_connection, if_exists='replace', index=False)


def run_query(query_statement, sql_connection):
    """ This function runs the stated query on the database table and prints
    the output. Function returns nothing """
    print(query_statement)

    with sql_connection.connect() as connection:
        result_proxy = connection.execute(sql.text(query_statement))
        rows = result_proxy.fetchall()

        for row in rows:
            print(row)

    connection.close()


def log_progress(message):
    """ This function logs the progress of the code. Function returns nothing """
    now = datetime.datetime.now()
    now_str = now.strftime("%Y-%m-%d %H:%M:%S")

    with open('log_etl.txt', 'a') as file:
        file.write(now_str + ' : ' + message + '\n')


''' Here, we will define the required entities and call the relevant functions 
in the correct order to perform the ETL process. '''

url = 'https://web.archive.org/web/20230902185326/https://en.wikipedia.org/wiki/List_of_countries_by_GDP_%28nominal%29'
table_attribs = ["Country", "GDP_USD_millions"]
db_name = 'World_Economies.db'
table_name = 'Countries_by_GDP'
csv_path = './Countries_by_GDP.csv'

log_progress('Preliminaries complete. Initiating ETL process.')

df = extract(url, table_attribs)

log_progress('Data Extraction complete. Initialing Transformation process.')

transform(df)

log_progress('Data transformation complete. Initiating loading proceess.')

load_to_csv(df, csv_path)

log_progress('Data saved to CSV file.')

engine = sql.create_engine('sqlite:///World_Economies.db')

log_progress('SQL Connection initialed.')

load_to_db(df, engine, table_name)

log_progress('Data loaded to Database as table. Running the query.')

query = f"SELECT * FROM {table_name} WHERE GDP_USD_billions >= 100"
run_query(query, engine)

log_progress('Process Complete.')

