import pokebase as pb
import pandas as pd
import numpy as np
import random
import funfunctions as fc

def get_data_pokemon(count):
    matriz = fc.matrizBiOrdinaria(6, count)
    
    for id in range(1, count):
        try:
            pokemon = pb.pokemon(id)
            pokemon_name = pokemon.name
            pokemon_weight = pokemon.weight
            pokemon_height = pokemon.height
            
            matriz[id][0]=id
            matriz[id][1]=pokemon_name
            matriz[id][2]=pokemon_weight
            matriz[id][3]=pokemon_height
        except Exception as e:
            print(f"id {id} error: {e}")
    return matriz

test_api = get_data_pokemon(10)

df_api = pd.DataFrame(test_api)
test_api.head()
