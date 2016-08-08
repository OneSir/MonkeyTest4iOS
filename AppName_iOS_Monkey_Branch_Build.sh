#!/bin/bash
#把用户名替换成本机用户名
#把AppName替换成对应的APP名字即可
		if find /Users/用户名/Home/workspace/AppName_iOS_Monkey_Branch_Build/build/*dSYM
		then
    		echo 打包成功，执行下一步命令
    		if find /Users/用户名/Desktop/AppName_Crash
    		then
        		echo 找到AppName_Crash文件夹并删除，新建它
        		rm -rf /Users/用户名/Desktop/AppName_Crash
        		mkdir /Users/用户名/Desktop/AppName_Crash
    		else
        		echo 没有找到AppName_Crash文件夹，新建它
       			mkdir /Users/用户名/Desktop/AppName_Crash
    		fi
				
				#复制dSYM文件，为后面解析Crash文件做准备
    		cp -r /Users/用户名/Home/workspace/AppName_iOS_Monkey_Branch_Build/build/*dSYM /Users/用户名/Desktop/AppName_Crash
    
				if find /Users/用户名/Desktop/App\ ipa
				then
    				echo 已经存在归档文件夹，跳过该if语句
    		else
        		echo 没有App ipa归档文件夹，新建它
        		mkdir /Users/用户名/Desktop/App\ ipa
    		fi

    		if find /Users/用户名/Desktop/App\ ipa/AppName*.ipa
    		then
        		echo App ipa文件夹里面有该APP的ipa文件，先删除再复制
        		rm -rf /Users/用户名/Desktop/App\ ipa/AppName*.ipa
        		#ipa路径每个APP功能都不一样，根据工程实际ipa路径
        		cp -r /Users/用户名/Home/workspace/AppName_iOS_Monkey_Branch_Build/dist/*ipa /Users/用户名/Desktop/App\ ipa/
        		#进入fruitstrap根目录路径下
        		cd /Users/用户名/Desktop/App\ ipa/fruitstrap
        		#使用fruitstrap安装ipd到设备
        		./fruitstrap -b /Users/用户名/Desktop/App\ ipa/AppName_*.ipa
    		else
        		echo App ipa文件夹里面没有该APP的ipa文件，直接复制
        		#ipa路径每个APP功能都不一样，根据工程实际ipa路径
        		cp -r /Users/用户名/Home/workspace/AppName_iOS_Monkey_Branch_Build/dist/*ipa /Users/用户名/Desktop/App\ ipa/
        		#进入fruitstrap根目录路径下
        		cd /Users/用户名/Desktop/App\ ipa/fruitstrap
        		#使用fruitstrap安装ipd到设备
        		./fruitstrap -b /Users/用户名/Desktop/App\ ipa/AppName_*.ipa
    		fi
		else
    		echo 打包失败，不执行安装命令
		fi

