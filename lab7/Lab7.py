#lab7 parse site
# -*- coding: utf-8 -*-
import sys, re, urllib2, urlparse

usedUrls = []
listOtherRef = []
urlPrimary = ""
correctUrls = []
urlsForCheck = []
failedUrl = []
queuedUrl = ""
queuedUrls = []
pageOpen = False

def CheckReference(page):
    code = ""
    try:
        code = urllib2.urlopen(page).getcode()
        status = str(code)
        if (code not in [200, 301, 302]):
            if (page + " " + status) not in failedUrl:
                failedUrl.append(page + " " + status)
        else:
            if (page + " " + status) not in correctUrls:
                correctUrls.append(page + " " + status)
                urlsForCheck.append(page)
    except urllib2.HTTPError as err:
        if (page + " " + str(err.getcode()) ) not in failedUrl:
            failedUrl.append(page + " " + str(err.getcode()) )
    except BaseException as err:
        if (page + " " + err.__str__()) not in failedUrl:
            failedUrl.append(page + " " + err.__str__())
            print(u"отрыть страницу невозможно, проверьте соединение с интеренетом")

def CheckLinksFromPage(url, urlPrimary):
    request = urllib2.Request(url)#url object
    try:
        response = urllib2.urlopen(request)#trying open
    except BaseException as err:
        return False
    else:
        usedUrls.append(url)

        content = response.read()

        # Find address data
        '''
        Атрибут href может содержать:
        Абсолютный URL — адрес страницы, документа или скрипта. Это наиболее распространенный вариант.
        Относительный URL — адрес страницы, документа или скрипта
        mailto: — e-mail адрес. Для написания письма откроется системный e-mail клиент.
        javascript: — исполняемый скрипт
        skype: — вызов абонента skype
        # — локальная ссылка(якорь)
        '''
        dataAllUrls = re.findall('href="((http|ftp)?.*?)"', content)
        dataUrls = re.findall('href="(((http|ftp)s?://)?.*?(/.*?)*)"', content)
        dataUrls2 = []
        for data in dataUrls:
            needDelete = False
            for element in {"mailto:", "javascript:", "skype:", "#"}:
                if element == data[0][:len(element)]:
                    needDelete = True
            if not needDelete:
                dataUrls2.append(data)
                
        convertAllDataUrls = [urlparse.urljoin(url, urlI[0]) for urlI in dataAllUrls]
        convertDataUrls = [urlparse.urljoin(url, urlI[0]) for urlI in dataUrls2]

        for urlList in convertDataUrls:
            if (not (urlList in usedUrls) and not (urlList in queuedUrls) and
                    (-1 != urlList.find(urlPrimary, 0, len(urlList))) ):
                queuedUrls.append(urlList)
            if( not (urlList in usedUrls)):
                usedUrls.append(urlList)

        for urlList in convertAllDataUrls:
            if ( (urlList not in convertDataUrls) ):  
                listOtherRef.append(urlList)


def CheckLinks(urls):
    for url in urls:
        CheckReference(url)
        del url

def deleteWhitespaceInEnd(url):
    result = url
    for char in url:
        if char == ' ':
            result = url[:-1]

    return result

def isCorrectRef(url):
    try:
        urllib2.urlopen(url)
    except urllib2.HTTPError, e:
        return False
    except urllib2.URLError, e:
        return False
    return True

def main(argv, urlPrimary):
    if (len(sys.argv) != 2):
        print(u"Ошибка ввода параметров")
        print(u"Укажите путь до программы в качестве перового параметра")
        print(u"Укажите адрес страницы в качестве второго параметра.")
        print(u"Формат ввода Lab7.py http://path-to-site.com.")
    else:
        queuedUrl = argv[1]
    queuedUrl = deleteWhitespaceInEnd(queuedUrl)
    if(isCorrectRef(queuedUrl) == False):
        print(u"Введенный адрес не является корректным URL.")
        print(u"Пожалуйста, введите адрес в формате http://path-to-site.com")
        queuedUrl = raw_input(u"введите URL: ")
    urlPrimary = queuedUrl
    queuedUrls.append(queuedUrl)
    while (len(queuedUrls)):
        CheckLinksFromPage(queuedUrls[0], urlPrimary)
        CheckLinks(usedUrls)
        del queuedUrls[0]

    
    if len(usedUrls):
        del usedUrls[0]
        CheckLinks(usedUrls)

    allRef = open("AllReference.txt", 'w')
    for url in correctUrls:
        allRef.write(url + '\n')
    for url in listOtherRef:
        allRef.write(url + '\n')
    for url in failedUrl:
        allRef.write(url + '\n')
    allRef.close()

    incorrectRef = open("InvalidReference.txt", 'w')

    for url in failedUrl:
        incorrectRef.write(url + '\n')
    incorrectRef.close()
    print (u"Программа завершена")

sys.argv = ["lab7.py", "https://pythonworld.ru/osnovy/indeksy-i-srezy.html"]
main(sys.argv, urlPrimary)
