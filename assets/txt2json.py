import json, sys

try:
    file = open("cua_people.txt",'r')
except:
    print("Couldn't find file")
    sys.exit()
txtStrings = file.read().splitlines()
file.close()

output = {'keys':json.loads(txtStrings[0]),'people':[]}
for line in txtStrings[1:]:
    output['people'].append(json.loads(line))

try:
    outFile = open('cua_people.json','w')
except:
    outFile = open('cua_people.json','x')
outFile.write(json.dumps(output))
outFile.close()