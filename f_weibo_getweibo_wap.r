

f_login=function(name="*********",pwd="*******"){
memory.limit(4000)
library(RCurl)
myH=c(
"Host"="3g.sina.com.cn",
"User-Agent"="Mozilla/5.0 (Windows NT 5.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1",
"Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
"Accept-Language"="zh-cn,zh;q=0.5",
"Accept-Encoding"="gzip, deflate",
"Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7",
"Keep-Alive"="115",
"Connection"="keep-alive",
"Referer"="http://3g.sina.com.cn/prog/wapsite/sso/login.php?ns=1&backURL=http://weibo.cn/dpool/ttt/home.php?s2w=login&backTitle=����΢��&vt=",
"Content-Type"="application/x-www-form-urlencoded; charset=UTF-8"
)
d=debugGatherer()
cH=getCurlHandle(
debugfunction=d$update,verbose=T,
ssl.verifyhost=F,ssl.verifypeer=F,
followlocation=T,
cookiefile="cc.txt")

## ��¼֮ǰ��Ȼ����Ҫ�Ȼ�ȡһЩ����
preurl='http://3g.sina.com.cn/prog/wapsite/sso/login.php?ns=1&backURL=http://weibo.cn/dpool/ttt/home.php?s2w=login&backTitle=����΢��&vt=4'
h=readLines(preurl,warn=F)
write(h,"temp.txt")
hh=readLines("temp.txt",encoding="UTF-8")
file.remove("temp.txt")
rm(h)
rand=hh[grep('rand',hh)]
rand=strsplit(rand,'rand=')[[1]][2]
rand=strsplit(rand,'&amp;')[[1]][1]
rand
vk=hh[grep('vk',hh)]
vk=strsplit(vk,'value=\"')[[1]][2]
vk=strsplit(vk,'\" />')[[1]][1]
vk
password=hh[grep('password',hh)]
password=strsplit(password,'name=\"')[[1]][2]
password=strsplit(password,'\" size=')[[1]][1]
password

posturl=paste("http://3g.sina.com.cn/prog/wapsite/sso/login_submit.php?rand=",rand,"&backURL=http://weibo.cn/dpool/ttt/home.php&backTitle=����΢��&vt=4&ns=1",sep="")
pinfo=c(
"mobile"=name,
"password"=pwd,
"remember"="on",
"backURL"="http://weibo.cn/dpool/ttt/home.php?s2w=login",
"backTitle"="����΢��",
"backURL"="http://weibo.cn/dpool/ttt/home.php?s2w=login",
"vk"=vk,
"submit"="��¼"
)
names(pinfo)[2]=password
## ��¼���������һ��warning������������ʲô���壬�����Ҿ�����ȥ��
options(warn=-1)
ttt=postForm(posturl,httpheader=myH,.params=pinfo,curl=cH,style="post")
options(warn=0)
write(ttt[1],'ttt.txt')
ttt=readLines("ttt.txt",encoding="UTF-8")
file.remove("ttt.txt")

## ���������ƣ���¼�ɹ��Ļ��᷵��һ�����ӣ������������һ����¼��Ҫ�õ���
newurl=ttt[grep('url=',ttt)]
newurl=strsplit(newurl,'url=')[[1]][2]
newurl=strsplit(newurl,'\" />')[[1]][1]
newurl=gsub('amp;','',newurl)
zzz=getURL(newurl,curl=cH,.encoding="gbk")
## ��¼���
return(cH)
}

## Ȼ��д��СС�Ķ�ȡ���ݵĺ���
f_get=function(cH=ch0,target='chenyibo',pg=1){
memory.limit(4000)
library(RCurl)
theurl=paste('http://weibo.cn/',target,'?page=',pg,sep='')
h=getURL(theurl,curl=cH,.encoding="gbk")
write(h,"temp.txt")
hh=readLines("temp.txt",encoding="UTF-8")
file.remove("temp.txt")
rm(h)
return(hh)
}

