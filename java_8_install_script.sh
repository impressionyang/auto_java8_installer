#! /bin/bash
#written by impressionyang 31/8/2018

#获取超级用户权限
sudo echo "运行本命令需要超级用户权限"
#$(cd `dirname $0`; pwd)测试获取当前目录


#判断文件是否下载，若存在则直接加压，否则先下载在解压，不过嘴还运行前先删除之前下载过的文件，以免异常
if [ -e "$(cd `dirname $0`; pwd)/jdk-8u141-linux-x64.tar.gz" ]; then
        echo "下载文件已存在！"
	#解压文件
	tar xzf jdk-8u141-linux-x64.tar.gz
else
        echo "未下载文件，即将开始下载！"
	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz"

	tar xzf jdk-8u141-linux-x64.tar.gz
fi


#sudo mkdir /usr/java
#判断文件夹是否存在，存在则删除以保证更新，否则创建空文件夹
if [ -d "/usr/java" ]; then
        sudo rm -r /usr/java
else
        sudo mkdir /usr/java
fi

#$(cd `dirname $0`; pwd) 	#获取脚本当前位置
sudo mv $(cd `dirname $0`; pwd)/jdk1.8.0_141 /usr/java

#echo 可将内容写入文件 “”内的内容会被解释  ‘’内的内容不会被解释
#将java配置写入环境变量中
sudo sh -c 'echo "#create by auto java install script" >>/etc/profile'
sudo sh -c "echo 'export JAVA_HOME=/usr/java' >>/etc/profile"
sudo sh -c "echo 'export JRE_HOME=/usr/java/jre' >>/etc/profile"
sudo sh -c "echo 'export CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH ' >>/etc/profile"
sudo sh -c "echo 'export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH' >>/etc/profile"

source /etc/profile

echo "java 8 已安装完成，请重新登录系统以完成最后配置！"
java -version


