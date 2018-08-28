# docker-pam
解决如果启动启用了主机网络的docker容器，那么由于内核PAM错误，命令su不能正常工作。

# PAM模块
在Linux中执行有些程序时，这些程序在执行前首先要对启动它的用户进行认证，符合一定的要求之后才允许执行，例如login, su等。

在Linux中进行身份或是状态的验证程序是由PAM来进行的，PAM（Pluggable Authentication Modules）可动态加载验证模块，因为可以按需要动态的对验证的内容进行变更，所以可以大大提高验证的灵活性。

# Linux-PAM共享库
Linux-PAM（即linux可插入认证模块）是一套共享库,使本地系统管理员可以随意选择程序的认证方式。

换句话说，不用(重新编写)重新编译一个包含PAM功能的应用程序，就可以改变它使用的认证机制，这种方式下，就算升级本地认证机制,也不用修改程序。

PAM使用配置/etc/pam.d/下的文件，来管理对程序的认证方式.应用程序 调用相应的配置文件，从而调用本地的认证模块.模块放置在/lib/security下，以加载动态库的形式进，像我们使用su命令时，系统会提示你输入root用户的密码.这就是su命令通过调用PAM模块实现的。

# Pull the image
```$xslt
docker pull honeyshawn/pam:centos-6.5
```

# Test the image
```
$ sudo docker run -i -t --net=host honeyshawn/pam:centos-6.5 /bin/bash -c "useradd testuser; su testuser"
$
```

作为参考，尝试使用原始的没有修补PAM的CentOS 6.5容器作为客户操作系统，效果如下：
```$xslt
$ sudo docker run -i -t --net=host tianon/centos:6.5 /bin/bash -c "useradd testuser; su testuser"
$ su: incorrect password
```





