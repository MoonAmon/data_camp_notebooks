def matrizUniAleatorio(tamanho):
    matriz = list(range(tamanho))
    for num in range(tamanho):
        matriz[num] = random.randint(1, 999)
    return matriz


def matrizUniOrdinaria(tamanho, numero):
    matriz = list(range(tamanho))
    for num in range(tamanho):
        matriz[num] = numero
    return matriz


def matrizBiAleatorio(NumColunas, NumLinhas, ateNum):
    matriz = [[0 for i in range(NumColunas)] for j in range(NumLinhas)]
    for y in range(NumColunas):
        for x in range(NumLinhas):
            matriz[x][y] = random.randint(0, ateNum)
    return matriz


def matrizBiAleatorioFloat(NumColunas, NumLinhas, ateNum):
    matriz = [[0 for i in range(NumColunas)] for j in range(NumLinhas)]
    for y in range(NumColunas):
        for x in range(NumLinhas):
            matriz[x][y] = random.uniform(0, ateNum)
    return matriz


def matrizBiOrdinaria(NumColuna, NumLinhas, elemento=0):
    matriz = [[0 for i in range(NumColuna)] for j in range(NumLinhas)]
    for y in range(NumColuna):
        for x in range(NumLinhas):
            matriz[x][y] = elemento
    return matriz


def nomeAleatorio(tamanho):
    vogais = 'aeiou'
    consoantes = 'bcdfghjklmnpqrstvwxyz'
    nome = ''
    for i in range(tamanho):
        if i % 2 == 0:
            nome += random.choice(consoantes)
        else:
            nome += random.choice(vogais)
        return nome.capitalize()


def printMatrizBi(matriz, tamanhoElemento):
    for linha in matriz:
        for elemento in linha:
            print(str(elemento).center(tamanhoElemento), end=" ")
        print()
    print()