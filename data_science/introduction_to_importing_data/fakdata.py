from faker import Faker
import csv
import openpyxl

def mkcsv():

    fake = Faker()

    with open('datafk.csv', 'w', newline='') as csvfile:
        fieldnames = ['Nome', 'Idade', 'Endereço']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writeheader()
        for _ in range(10):
            writer.writerow({'Nome': fake.name(), 'Idade': fake.random_int(18, 60), 'Endereço': fake.address()})

import pickle

# Dados fictícios
dados = {
    'nome': 'João',
    'idade': 30,
    'cidade': 'Exemploville'
}

# Salvar em um arquivo pickle
with open('dados.pkl', 'wb') as arquivo:
    pickle.dump(dados, arquivo)



def mkxxlx():

    fake = Faker()

    workbook = openpyxl.Workbook()
    sheet = workbook.active
