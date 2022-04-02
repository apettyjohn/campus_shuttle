from selenium import webdriver
from selenium.webdriver.common.by import By
from string import ascii_lowercase
import json, time

# Get a set of strings to search through
try:
    letters = open('letter_combos.txt','r+') # Open File
except:
    letters = open('letter_combos.txt','x') # Make file if doesn't exist
try:
    outFile = open("cua_people.txt","r+")
except:
    outFile = open("cua_people.txt","x")
strings = letters.read().splitlines()
database = outFile.read().splitlines()
if (len(strings) < 1):
    print("Generating letters")
    for a in ascii_lowercase:
        for b in ascii_lowercase:
            for c in ascii_lowercase:
                letters.write(str(a)+str(b)+str(c)+'\n')
    strings = letters.read().splitlines()

# URL of directory webpage
url = "https://technology.catholic.edu/campus-directory/index.php"

# Start selenium webdriver
options = webdriver.ChromeOptions()
options.add_argument('--ignore-certificate-errors')
options.add_argument("--test-type")
driver = webdriver.Chrome(options=options,executable_path='C:/Users/apett/chromedriver.exe')
driver.get(url)
text_area = driver.find_element(By.ID,'search_word')
searchButton = driver.find_element(By.ID,'view_directory')  

people = []                                   # Empty python list
parsed = 0

for x in database:
    people.append(json.loads(x))

def knowPerson(name):
    for i in people:
        if i['name'] == name:
            return False
    return True

for i in strings[100:5000]:                           # Loop through directory pages
    text_area.clear()                               
    text_area.send_keys(i)                      # Enter the first string
    searchButton.click()                            # Click button
    time.sleep(0.1)
    rows = driver.find_elements(By.XPATH,'//*[@id="campus_directory_content_search_results"]/div/div/ul')
    for cell in rows:
        try:
            fullName = cell.find_element(By.TAG_NAME,'h4')
            spans = cell.find_elements(By.TAG_NAME,'span')
            if len(spans) > 1:
                role = spans[0].text[1:-1]
                if role == 'student' or role == 'faculty' or role == 'staff':
                    if knowPerson(fullName.text.split('(')[0]):
                        cell.click()
                        if role == 'student':
                            person = {
                                'name':fullName.text.split('(')[0],
                                'role':role,
                                'email':spans[2].text,
                            }
                        else:
                            person = {
                                'name':fullName.text.split('(')[0],
                                'role':role,
                                'title':spans[2].text,
                                'department':spans[4].text,
                                'office':spans[6].text,
                                'phone':spans[8].text,
                                'email':spans[10].text,
                            }
                        people.append(person)
                        parsed = parsed + 1
        except:
            print("Encountered an Error")
        
for y in people:
    outFile.write(json.dumps(y)+'\n')

print("Found " + str(parsed) + " students.")

outFile.close()
letters.close()
driver.quit()