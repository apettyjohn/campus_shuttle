import json
import sys

try:
    file = open("cua_people.txt","r") 
except:
    print("Couldn't find the database file")
    sys.exit()

print('Reading in file')
database = file.read().splitlines()
file.close()
keys = {'faculty':0,'staff':0,'student':0,"student, staff":0,}
data = []
for d in database:
        data.append(json.loads(d))
try:
    data[0]['student']
    keys = data.pop(0)
    print('Found index keys')
except:
    pass

# # debug loop
# for x in data:
#     try:
#         x['phone']
#     except:
#         print("Stopped on line " + str(x))
# sys.exit()
print('Sorting data')
people = sorted(data,key= lambda x:(x['role'],x['name']))
role = people[0]['role']
keys[role] = 0
i=0
print('Looping through data')
while i < len(people):
    if people[i]['role'] != role:
        role = people[i]['role']
        keys[role] = i
    if i+1 < len(people):
        try:
            phone = people[i+1]['phone']
            email = people[i+1]['email']
        except:
            phone = ''
            email = ''
        if people[i+1]['name'] == people[i]['name'] or phone == 'Phone: ' or email == 'Email: ':
            x = people.pop(i+1)
            #print("Removing " + str(x))
        else:
            i += 1
    else:
        i += 1

print('Saving file')
people = [keys]+people
file = open("cua_people.txt","w") 
for i in people:
    file.write(json.dumps(i)+'\n')

print("Sucessfully sorted data")

file.close()