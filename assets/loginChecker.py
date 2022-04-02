from selenium import webdriver
from selenium.webdriver.common.by import By
from string import ascii_lowercase
import json, time, math, sys

# Get a set of strings to search through
try:
    letters = open('letter_combos.txt','r') # Open File
except:
    letters = open('letter_combos.txt','x') # Make file if doesn't exist
try:
    outFile = open("cua_people.txt","r")
except:
    outFile = open("cua_people.txt","x")
strings = letters.read().splitlines()
database = outFile.read().splitlines()
letters.close()
outFile.close()

if (len(strings) < 1):
    print("Generating letters")
    letters = open('letter_combos.txt','w')
    for a in ascii_lowercase:
        for b in ascii_lowercase:
            for c in ascii_lowercase:
                letters.write(str(a)+str(b)+str(c)+'\n')
                strings.append(str(a)+str(b)+str(c))
    letters.close()

# URL of directory webpage
url = "https://technology.catholic.edu/campus-directory/index.php"

# Start selenium webdriver
options = webdriver.ChromeOptions()
options.add_argument('--ignore-certificate-errors')
options.add_argument("--test-type")
options.add_experimental_option('excludeSwitches', ['enable-logging'])
driver = webdriver.Chrome(options=options,executable_path='C:/Users/apett/chromedriver.exe')
driver.get(url)
text_area = driver.find_element(By.ID,'search_word')
searchButton = driver.find_element(By.ID,'view_directory')  

people = []                                   # Empty python list
parsed = 0
breakout = False
keys = json.loads(database.pop(0))

for x in database:
    people.append(json.loads(x))

def knowPerson(name,job):
    start = keys[job]
    waypoints = sorted(keys.values())
    if waypoints.index(start) == len(waypoints)-1:
        end = len(people)-1
    else:
        end = waypoints[waypoints.index(start)+1]
    spread = end-start
    i = start + math.floor(spread/2)
    guessName = people[i]['name']
    while spread > 1:
        spread = end-start
        i = start + math.floor(spread/2)
        guessName = people[i]['name']
        if guessName == name:
            return False
        elif name > guessName:
            start = i
        else:
            end = i
    if guessName == name:
        return False
    return True

def addPerson(person):
    name = person['name']
    job = person['role']
    start = keys[job]
    waypoints = sorted(keys.values())
    if waypoints.index(start) == len(waypoints)-1:
        end = len(people)-1
    else:
        end = waypoints[waypoints.index(start)+1]
    spread = end-start
    i = start + math.floor(spread/2)
    guessName = people[i]['name']
    while spread > 1:
        spread = end-start
        i = start + math.floor(spread/2)
        guessName = people[i]['name']
        if name > guessName:
            start = i
        else:
            end = i
    if name > guessName:
        people.insert(i+1,person)
        i += 1
    else:
        people.insert(i-1,person)
        i -= 1

    # Update key values
    roles = keys.keys()
    if i < keys[job]:
        keys[job] = i
    for r in roles:
        if keys[r] > i:
            keys[r] += 1

print('Starting search')
for j in strings[100:500]:                           # Loop through directory pages
    if breakout:
        break
    text_area.clear()                               
    text_area.send_keys(j)                      # Enter the first string
    searchButton.click()                            # Click button
    time.sleep(0.1)
    rows = len(driver.find_elements(By.XPATH,'//*[@id="campus_directory_content_search_results"]/div'))
    for i in range(rows):
        cell = driver.find_elements(By.XPATH,'//*[@id="campus_directory_content_search_results"]/div/div/ul')[i]
        fullName = cell.find_element(By.TAG_NAME,'h4')
        spans = cell.find_elements(By.TAG_NAME,'span')
        try:
            if len(spans) > 1 and len(spans[0].text) > 1: 
                if spans[0].text[0] == '(':
                    name = fullName.text.split('(')[0]
                    role = spans[0].text[1:-1]
                    if role[0] == 's' or role[0] == 'f':
                        if knowPerson(name,role):
                            cell.click()
                            if role == 'student':
                                person = {
                                    'name':name,
                                    'role':role,
                                    'email':spans[2].text,
                                }
                            else:
                                if spans[7].text[0] == 'r':
                                    person = {
                                        'name':name,
                                        'role':role,
                                        'title':spans[2].text,
                                        'department':spans[4].text,
                                        'office':spans[6].text + spans[7].text,
                                        'phone':spans[9].text,
                                        'email':spans[11].text,
                                    }
                                else:
                                    person = {
                                        'name':name,
                                        'role':role,
                                        'title':spans[2].text,
                                        'department':spans[4].text,
                                        'office':spans[6].text,
                                        'phone':spans[8].text,
                                        'email':spans[10].text,
                                    }
                            addPerson(person)
                            parsed = parsed + 1
        except Exception as e:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            print("Encountered an error: "+ repr(e))
            print("On string: " + j + ", Name: " + name + ", On line: " + str(exc_tb.tb_lineno))
            print('Spans:')
            for s in spans:
                print('['+s.text+']')
            print('Quitting')
            breakout = True
            break


print('Saving file')
people = [keys] + people 
outFile = open('cua_people.txt','w')
for y in people:
    outFile.write(json.dumps(y)+'\n')

print("Found " + str(parsed) + " people.")

outFile.close()
letters.close()
driver.quit()