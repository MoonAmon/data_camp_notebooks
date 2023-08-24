var1 = input('digite var 1: ')
var2 = input('digite var 2: ')

if len(var1) == len(var2):
    print('{0},{1}tamanho das variaveis: {3}',var1,var2,len(var1) )
elif type(var1) == type(var2):
    print('As duas variaveis são do tipo string!')
