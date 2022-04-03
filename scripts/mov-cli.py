#!/usr/bin/env python3
import httpx
from bs4 import BeautifulSoup as BS
from urllib import parse
import base64, json, os

requests = httpx.Client()
x = lambda d: base64.b64encode(d.encode()).decode().replace("\n", "").replace("=", ".")
q = input("Enter the name of the movie").replace(' ', '-')
res = requests.get(f"https://sflix.se/search/{q}").text
soup = BS(res,'html.parser')
titles = [i['title'] for i in soup.select('.film-poster-img')][0]
urls = [i['href'] for i in soup.select('.film-poster-ahref')]
links = urls[0]
ids = [i.split('-')[-1] for i in urls][0]
rem = requests.get(f"https://sflix.se/ajax/movie/episodes/{ids}").text
soup = BS(rem,'html.parser')
sids = [i['data-id'] for i in soup.select('.link-item')][0]
useragent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36'
ram = requests.get(f"https://sflix.se/ajax/get_link/{sids}").json()['link']
meid = parse.urlparse(ram,allow_fragments=True,scheme='/')
rabbid = meid.path.replace("/embed-4/",'')
domain = x('https://rabbitstream.net:443')

yae_miko = requests.get(ram,headers={'user-agent':useragent,'referer':'https://sflix.se'}).text
soup = BS(yae_miko,'html.parser')
f = [i.text for i in soup.find_all("script")][-3].replace("var","")
k = list(f)
key = "".join(k[21:61])
num = k[-3]

def gettoken():
    r = requests.get("https://www.google.com/recaptcha/api.js?render="+key,headers={'referer':'https://sflix.se','user-agent':useragent,'cacheTime':'0'})
    s = r.text.replace("/* PLEASE DO NOT COPY AND PASTE THIS CODE. */","")
    s = s.split(";")
    vtoken = s[10].replace("po.src=","").split("/")[-2]

    r = requests.get("https://www.google.com/recaptcha/api2/anchor?ar=1&hl=en&size=invisible&cb=xxmovclix&k="+key+"&co="+domain+"&v="+vtoken,headers={'user-agent':useragent})
    
    soup = BS(r.content, "html.parser")
    recap_token = [i['value'] for i in soup.select("#recaptcha-token")][0]
    
    data = {
        "v" : vtoken,
        "k" : '6LeWLCYeAAAAAL1caYzkrIY-M59Vu41vIblXQZ48',
        "c" : recap_token,
        "co" : domain,
        "sa" : "",
        "reason" :"q"
    }
    return requests.post("https://www.google.com/recaptcha/api2/reload?k="+key,data=data,headers={'user-agent':useragent,'cacheTime':'0'}).text.replace(")]}'",'')


final_token = json.loads(gettoken())
rose = final_token[1]
ayaka = requests.get(f"https://rabbitstream.net/ajax/embed-4/getSources?id={rabbid}&_token={rose}&_number={num}",headers={'user-agent':useragent,'referer':ram,'X-Requested-With': 'XMLHttpRequest'}).json()
os.system(f'mpv --referrer="https://sflix.se" {ayaka["sources"][0]["file"]}')
