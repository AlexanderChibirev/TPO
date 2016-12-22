#lab7 parse site
# -*- coding: utf-8 -*-
import sys, re, urllib2, urlparse

def GetRefCode(page, correctUrls, failedUrl):
    code = ""
    try:
        code = urllib2.urlopen(page).getcode()
        status = str(code)
        if (code in [200, 301, 302]):
            if (page + " " + status) not in correctUrls:
                correctUrls.append(page + " " + status)
        else:
            if (page + " " + status) not in failedUrl:
                failedUrl.append(page + " " + status)
    except urllib2.HTTPError as err:
        if (page + " " + str(err.getcode()) ) not in failedUrl:
            failedUrl.append(page + " " + str(err.getcode()) )
    except BaseException as err:
        if (page + " " + "404") not in failedUrl:
            failedUrl.append(page + " " + "404")
            
def CheckPage(awaitingVerificationUrls, urlPrimary, usedUrls):
    url = awaitingVerificationUrls[0]
    request = urllib2.Request(url)#url object
    try:
        response = urllib2.urlopen(request)#trying open
    except BaseException as err:
        return False
    else:
        usedUrls.append(url)
        dataUrls = re.findall('href="(((http|ftp)s?://)?.*?(/.*?)*)"', response.read())
        convertDataUrls = [urlparse.urljoin(url, urlI[0]) for urlI in dataUrls]
        for urlList in convertDataUrls:
            if (not (urlList in usedUrls) and not (urlList in awaitingVerificationUrls) and
                    (-1 != urlList.find(urlPrimary, 0, len(urlList))) ):
                awaitingVerificationUrls.append(urlList)
            if( not (urlList in usedUrls)):
                usedUrls.append(urlList)
                
def IsCorrectRef(url):
    try:
        urllib2.urlopen(url)
    except urllib2.HTTPError, e:
        return False
    except urllib2.URLError, e:
        return False
    return True

def WriteInFileRefAll(correctUrls, failedUrl):
    refAll = open("RefAll.txt", 'w')
    for url in correctUrls:
        refAll.write(url + '\n')
  
    for url in failedUrl:
        refAll.write(url + '\n')
    refAll.close()
    
def WriteInFileRefError(failedUrl):
    refError = open("RefError.txt", 'w')
    for url in failedUrl:
        refError.write(url + '\n')
    refError.close()

def main(argv):
    if (len(sys.argv) != 2):
        print(u"Ошибка ввода параметров")
        print(u"Укажите путь до программы в качестве перового параметра")
        print(u"Укажите адрес страницы в качестве второго параметра.")
        print(u"Формат ввода Lab7.py http://path-to-site.com.")
    else:
        startUrl = argv[1]
    if(IsCorrectRef(startUrl) == False):
        print(u"Введенный адрес не является корректным URL.")
        print(u"Пожалуйста, введите адрес в формате http://path-to-site.com")
        startUrl = raw_input(u"введите URL: ")
    awaitingVerificationUrls = []
    awaitingVerificationUrls.append(startUrl)
    usedUrls = [] 
    correctUrls = []
    failedUrl = []
    while (len(awaitingVerificationUrls)):
        CheckPage(awaitingVerificationUrls, startUrl, usedUrls)
        for url in usedUrls:
            GetRefCode(url, correctUrls, failedUrl)
            del url
        del awaitingVerificationUrls[0]
    WriteInFileRefAll(correctUrls, failedUrl)
    WriteInFileRefError(failedUrl)
    print (u"Программа завершена")

sys.argv = ["lab7.py", "http://gudsoft.ru"]
main(sys.argv)
