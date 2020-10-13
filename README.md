# OnlineShop-studentproject

## 我的项目是运行在tomcat中的，要顺利运行这个项目：  

* 需要修改conf/service.xml中设置虚拟目录pt，在文件中找到<HOST></HOST>，在其中添加<Context docBase="D:\pt" path="/pt" reloadable="true"></Context>  
* 需要两个jar:jspSmartUpload.jar、mysql-connector-java-8.0.20.jar，存放在lib中
* 需要使用mysql  
* 修改jsp文件里面关于数据库的内容，对账号、密码、端口等进行修改。由于我设置了图片，所以可能需要添加相关的图片，并修改jsp文件中的相关路径。    
* 添加一个imeg文件夹到d:\pt中，图片文件就存放在这。
* 可能需要修改字符集，修改成gb18030



ps:上了web课程之后进行的相关练习。项目开始的时候课上到了jsp，所以大量使用了jsp。  
