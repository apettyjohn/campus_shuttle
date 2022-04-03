from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException,StaleElementReferenceException
from string import ascii_lowercase
import json, time, math, sys

# star timer
startTime = time.perf_counter()
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

people = []                                   # Empty python list
parsed = 0
scanned = 0
breakout = False
keys = json.loads(database.pop(0))
letterString = ''

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

### debug 
# wait = WebDriverWait(driver, 0.5)
# text_area = wait.until(EC.presence_of_element_located((By.ID, "search_word")))
# searchButton = driver.find_element(By.ID, "view_directory")
# text_area.clear()                               
# text_area.send_keys('all')
# searchButton.click()
# time.sleep(0.25)
# rows = wait.until(EC.presence_of_all_elements_located((By.XPATH,'//*[@id="campus_directory_content_search_results"]/div/div/ul')))
# for cell in rows:
#    cell.click()
# rows = wait.until(EC.presence_of_all_elements_located((By.XPATH,'//*[@id="campus_directory_content_search_results"]/div/div/ul')))
# for cell in rows:
#     try:
#         text = cell.text.split('\n')
#         if '(' in text[0]:
#             name = text[0].split('(')[0]
#             role = text[0].split('(')[-1][:-1]
#             if role[0] == 's' or role[0] == 'f':
#                 if knowPerson(name,role):
#                     if role == 'student':
#                         person = {
#                             'name':name,
#                             'role':role,
#                             'email':text[1].split(': ')[1],
#                         }
#                     else:
#                         person = {
#                             'name':name,
#                             'role':role,
#                             'title':text[1].split(': ')[1],
#                             'department':text[2].split(': ')[1],
#                             'office':text[3].split(': ')[1],
#                             'phone':text[4].split(': ')[1],
#                             'email':text[5].split(': ')[1],
#                         }
#     except:
#         print(text)
#         break
# driver.close()
# sys.exit()

wait = WebDriverWait(driver, 0.5)
print('Starting search')
loopStart = 500
loopEnd = len(strings)-1
h = loopStart
while h < loopEnd:                           # Loop through directory pages
    j = strings[h]
    if breakout:
        break
    text_area = driver.find_element(By.ID, "search_word")
    searchButton = driver.find_element(By.ID, "view_directory")
    letterString = j
    try:
        text_area.clear()                               
        text_area.send_keys(j)
        searchButton.click()
        time.sleep(0.2)
        rows = wait.until(EC.presence_of_all_elements_located((By.XPATH,'//*[@id="campus_directory_content_search_results"]/div/div/ul')))
        for cell in rows:
            text = cell.text.split('\n')
            if '(' in text[0]:
                name = text[0].split('(')[0]
                role = text[0].split('(')[-1][:-1]
                if role[0] == 's' or role[0] == 'f':
                    if knowPerson(name,role):
                        cell.click()
        time.sleep(0.2)
        rows = wait.until(EC.presence_of_all_elements_located((By.XPATH,'//*[@id="campus_directory_content_search_results"]/div/div/ul')))
        for cell in rows:
            scanned += 1
            text = cell.text.split('\n')
            if '(' in text[0]:
                name = text[0].split('(')[0]
                role = text[0].split('(')[-1][:-1]
                if role[0] == 's' or role[0] == 'f':
                    if knowPerson(name,role) and len(text) > 1:
                        if role == 'student':
                            person = {
                                'name':name,
                                'role':role,
                                'email':text[1].split(': ')[1],
                            }
                        else:
                            person = {
                                'name':name,
                                'role':role,
                                'title':text[1].split(': ')[1],
                                'department':text[2].split(': ')[1],
                                'office':text[3].split(': ')[1],
                                'phone':text[4].split(': ')[1],
                                'email':text[5].split(': ')[1],
                            }
                        addPerson(person)
                        parsed = parsed + 1
        h += 1
    except TimeoutException:
        pass
        h += 1
    except StaleElementReferenceException:
        pass
    except Exception as e:
        exc_type, exc_obj, exc_tb = sys.exc_info()
        print("Encountered an error: "+ repr(e))
        print("On line: " + str(exc_tb.tb_lineno))
        print('Quitting')
        breakout = True
        break


print('Saving file')
people = [keys] + people 
outFile = open('cua_people.txt','w')
for y in people:
    outFile.write(json.dumps(y)+'\n')

# stop timer
endTime = time.perf_counter()
print("Ended on letter " + letterString + ", line " + str(strings.index(letterString)))
print("Scanned " + str(scanned) + " profiles.")
print("Found " + str(parsed) + " new people.")
print("Ran for " + str(round(endTime-startTime,2)) + " seconds.")

outFile.close()
driver.quit()