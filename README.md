# MonkeyTest4iOS

一、介绍

iOSMonkeyKingTest是一款全天候·全流程自动化·无人值守的iOS APP Crash抓取小能手工具。


二、特点

2.1支持自动打包并直接安装到iPhone设备上，持续更新APP持续测试；

2.2支持提供最后10s操作截图PNG文件，方便定位在哪个界面出现Crash；

2.3支持提供解析后的Crash文件，方便定位哪些代码出现问题；

2.4支持把Crash和PNG文件以附件形式自动发邮件给对应APP开发；

2.5支持APP自动登陆功能。


三、组成

3.1 Jenkins

3.2 Fruitstrap：实现命令行把最新IPA包更新到iPhone设备上 

3.3 CrashMonkey4iOS：CrashMonkey4IOS

3.4 Pngquant：近乎无损压缩PNG图片大小减少70%左右

3.5 Xcode

3.6 UIAutomation：实现自动登陆功能

3.7 命令行发邮件：实现自动发邮件功能

3.8 Shell脚本

四、参考文献

https://github.com/vigossjjj/CrashMonkey4IOS；

https://github.com/ghughes/fruitstrap；

https://pngquant.org/；
