# Travis中添加ssh密钥

[TOC]

## 1、服务器密钥生成

```shell
ssh-keygen -t rsa -b 4096 -C "<your_email>" -f github_deploy -N ''
```

首先按照上面的命令生成名称为`github_deploy`的密钥，密钥会放在当前文件夹下

认证密钥需要放在`~/.ssh/authorized_keys`中生效，如果是在服务器上操作：

```shell
cat github_deploy.pub >> ~/.ssh/authorized_keys
```

远程操作：

```shell
ssh-copy-id -i github_deploy.pub [user]@[ip]
```



## 2、Travis上传密钥

这里使用了`travis`，如果没有安装`ruby`，需要先安装`ruby`

```shell
# 安装ruby
yum install ruby -y
# 安装travis
gem install travis
```



接下来使用`travis`来配置

-   登陆

```bash
(base)  ~ travis login
Shell completion not installed. Would you like to install it now? |y| y
We need your GitHub login to identify you.
This information will not be sent to Travis CI, only to api.github.com.
The password will not be displayed.

Try running with --github-token or --auto if you don't want to enter your password anyway.

Username: github注册邮箱
Password for zhishengqianjun@163.com: [******github密码******]
Successfully logged in as [会显示github用户名]!
(base)  ~ 
```

-   上传密钥信息

```shell
(base)  ~  travis encrypt-file ~/.ssh/github_deploy_key
Can't figure out GitHub repo name. Ensure you're in the repo directory, or specify the repo name via the -r option (e.g. travis <command> -r <owner>/<repo>)
(base)  ✘ ~  j blog
/Users/zhang/Workspace/mkdocs_blog
(base)  ~/Workspace/mkdocs_blog  travis encrypt-file ~/.ssh/github_deploy_key
Detected repository as gaviners/mkdocs_blog, is this correct? |yes| yes
encrypting /Users/zhang/.ssh/github_deploy_key for gaviners/mkdocs_blog
storing result as github_deploy_key.enc
storing secure env variables for decryption

Please add the following to your build script (before_install stage in your .travis.yml, for instance):

    openssl aes-256-cbc -K $encrypted_889ea77ee21e_key -iv $encrypted_889ea77ee21e_iv -in github_deploy_key.enc -out ~\/.ssh/github_deploy_key -d

Pro Tip: You can add it automatically by running with --add.

Make sure to add github_deploy_key.enc to the git repository.
Make sure not to add /Users/zhangguohao/.ssh/github_deploy_key to the git repository.
Commit all changes to your .travis.yml.
(base)  ~/Workspace/mkdocs_blog
```

如上所示，`travis`需要知道配置哪个库，因此在库路径下面

关键信息为上面的`openssl`这一行，`travis`将`key`作为变量，然后通过`openssl`还原出`key`文件

```shell
openssl aes-256-cbc -K $encrypted_889ea77ee21e_key -iv $encrypted_889ea77ee21e_iv -in github_deploy_key.enc -out ~\/.ssh/github_deploy_key -d
```



然后我们可以到`travis`中进行确认：

![image-20191127114045279](http://markdown-images-1251766755.cos.ap-beijing.myqcloud.com/notebook/2019-11-27-034050.png)

上面增加了命令行中的变量



## 3、修改`.travis.yml`文件



```yml
before_install:
    - openssl aes-256-cbc -K $encrypted_889ea77ee21e_key -iv $encrypted_889ea77ee21e_iv -in github_deploy_key.enc -out ~\/.ssh/github_deploy_key -d
    - chmod 600 ~/.ssh/github_deploy_key
    - eval $(ssh-agent)
    - ssh-add ~/.ssh/github_deploy_key
```

如上所示，`.travis.yml`中添加这一个环节，我们就能够使用`ssh`的形式访问到我们的服务器了



## 4、参考链接

-   [Connecting to GitHub with SSH](https://help.github.com/articles/connecting-to-github-with-ssh/)
-   [Encrypting Files](https://docs.travis-ci.com/user/encrypting-files/)

