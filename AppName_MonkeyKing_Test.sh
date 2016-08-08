#!/bin/bash

export PATH=$PATH:/usr/local/Cellar/libimobiledevice/1.2.0/bin/
export PATH=$PATH:/usr/local/Cellar/ideviceinstaller/1.1.0_2/bin/
export PATH=$PATH:/usr/local/bin/
export PATH=$PATH:/Library/Ruby/Gems/2.0.0/gems/smart_monkey-0.5.0/bin/

#执行登录脚本
instruments -w 设备号 -t "/Applications/Xcode.app/Contents/Applications/Instruments.app/Contents/PlugIns/AutomationInstrument.xrplugin/Contents/Resources/Automation.tracetemplate" com.xxx.iphone -e UIASCRIPT /Users/用户名/登录脚本路径/APPLogin/xxx.js

#执行稳定性测试
smart_monkey -a com.xxx.iphone -w 设备号 --compress-result 50% -n 1 -s /Users/用户名/Desktop/APP的dSYM文件路径/APPdSYM文件名.app.dSYM
