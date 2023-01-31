f = open("DANE_2105/instrukcje.txt", "r")
output = ""
for line in f:
    if line.startswith("DOPISZ "):
        output += line[7]
    elif line.startswith("USUN "):
        output = output[:-1]
    elif line.startswith("ZMIEN "):
        output = output[:-1] + line[6]
    elif line.startswith("PRZESUN "):
        char = chr(ord(line[8]) + 1)
        if line[8] == 'Z':
            char = 'A'
        output = output.replace(output[output.find(line[8])], char, 1)


#todo Replace zamienia WSZYSTKIE wystapienia danego chara/stringa
#todo zeby usunac ostatni char najelpiej uzywac zmienna[:-1] co oznacza zmienna[start:end]
#todo Mapy robi sie {}, a listy []



print("Zadanie 1")
print(len(output))

instrukcja = "";
occ = 0;

top_instrukcja = "";
top_occ = 0;

f.seek(0)

occurences = []


for line in f:
    if instrukcja == "":
        instrukcja = line.split(" ")[0]
        occ = 1
    if line.split(" ")[0] == instrukcja:
        occ += 1
    else:
        if top_occ < occ:
            top_instrukcja = instrukcja
            top_occ = occ
        instrukcja = line.split(" ")[0]
        occ = 1

print("Zadanie 2")
print(top_occ)
print(top_instrukcja)



f.seek(0)

litery = {}

for line in f:
    instrukcja = line.split(" ")
    if instrukcja[0] == "DOPISZ":
        if instrukcja[1] in litery.keys():
            litery[instrukcja[1]] += 1
        else:
            litery[instrukcja[1]] = 1

print("Zadanie 3")
wynik = max(litery, key=litery.get)
print(wynik, end="")
print(litery[wynik])

print("Zadanie 4")
print(output)

f.close()