#!/bin/bash
##参数

export PATH=$PATH:/usr/local/bin/
export PATH=$PATH:~/Downloads/pngquant
LOG_TIME=`date +%Y%m%d%H%M%S`

#环境准备
#jenkins_home=~/Home/workspace/
#project_name=${APP_NAME}_SmartMonkey_Test/
##判断是否以及存在~/Desktop/${APP_NAME}_Crash文件夹
if find ~/Desktop/${APP_NAME}_Crash
then
   echo 已存在${APP_NAME}_Crash/文件夹，不需要处理
else
    mkdir ~/Desktop/${APP_NAME}_Crash/
    echo 未存在${APP_NAME}_Crash/文件夹，进行创建
fi
##判断是否以及存在~/Desktop/crash文件夹
if find ~/Desktop/crash
then
    echo 已存在crash文件夹，不需要处理
else
    mkdir ~/Desktop/crash/
    echo 未存在crash文件夹，进行创建
fi
##判断是否以及存在~/Desktop/crash/${APP_NAME}/文件夹
if find ~/Desktop/crash/${APP_NAME}/
then
    echo 已存在${APP_NAME}/文件夹，不需要处理
else
    mkdir ~/Desktop/crash/${APP_NAME}/
    echo 未存在/Desktop/crash/${APP_NAME}/文件夹，进行创建
fi
##判断是否以及存在~/Desktop/crash/Auto_Handle_Crash/文件夹
if find ~/Desktop/crash/Auto_Handle_Crash/
then
    echo 已存在~/Desktop/crash/Auto_Handle_Crash文件夹，不需要处理
else
    echo 未存在~/Desktop/crash/Auto_Handle_Crash文件夹，进行创建
    mkdir ~/Desktop/crash/Auto_Handle_Crash/
fi

#华丽的分割线
if find ~/Desktop/${APP_NAME}_Crash/Crash*
then
    echo 找到Crash文件夹，删除它
    #该判定是为了避免出现后面脚本出现不可预知的情况，导致上次运行Auto_Handle_Crash脚本的Crash文件夹遗留在${APP_NAME}_Crash文件夹的问题
    rm -rf ~/Desktop/${APP_NAME}_Crash/Crash*
    
else
    echo 恭喜，~/Desktop/${APP_NAME}_Crash/没有遗留Crash文件夹
fi



if find ~/Desktop/${APP_NAME}_Crash/report*
then
    echo 把在${APP_NAME}_Crash的report文件夹复制归档到对应APP文件夹
    #该判定是为了避免出现后面脚本出现不可预知的情况，导致上次运行monkeytest的report文件夹遗留在${APP_NAME}_Crash文件夹的问题
    cp ~/Desktop/${APP_NAME}_Crash/report* ~/Desktop/crash/${APP_NAME}/
    rm -rf ~/Desktop/${APP_NAME}_Crash/report*
    
else
    echo 恭喜，~/Desktop/${APP_NAME}_Crash/没有遗留report文件夹
fi


if find  ~/Home/workspace/${APP_NAME}_SmartMonkey_Test/smart_monkey_result/report_*
then
    echo 找到report文件夹，进行下一步操作
    #该判定是为了检查在smart_monkey_result下是否有report文件夹，一般来说都会存在
    cp -r  ~/Home/workspace/${APP_NAME}_SmartMonkey_Test/smart_monkey_result/report_* ~/Desktop/${APP_NAME}_Crash/

    rm -rf ~/Home/workspace/${APP_NAME}_SmartMonkey_Test/smart_monkey_result/report_*

    mkdir ~/Desktop/${APP_NAME}_Crash/Crash$LOG_TIME


    if find ~/Desktop/${APP_NAME}_Crash/report_*/result_000/CoreTime*.crash
    then
        echo 该crash是CoreTime-*.crash，非APP crash不用解析
    
    elif find ~/Desktop/${APP_NAME}_Crash/report_*/result_000/backupd*.crash
    then
        echo 该crash是backupd crash，非APP crash不用解析

    elif find ~/Desktop/${APP_NAME}_Crash/report_*/result_000/stacks+timed*.crash
    then
        echo 该crash是stacks+timed crash，非APP crash不用解析

    elif find ~/Desktop/${APP_NAME}_Crash/report_*/result_000/ExcResource*.crash
    then
        echo 该crash是APP异常信息，非APP crash不用解析

    elif find ~/Desktop/${APP_NAME}_Crash/report_*/result_000/$CRASH_NAME*.crash
    then
        echo 找到APP crash文件，进行解析

        cd ~/Desktop/${APP_NAME}_Crash/report_*/result_000/
        #把crash文件复制到Crash$LOG_TIME/ 文件夹
        cp $CRASH_NAME*.crash ~/Desktop/${APP_NAME}_Crash/Crash$LOG_TIME/
        cp console.txt ~/Desktop/${APP_NAME}_Crash/Crash$LOG_TIME/${APP_NAME}_Console.log
        if find monkey*.png
        then
            echo 找到png，执行下一步
            for year in 2017 2016 ; do
                if find monkey-$year*.png
                then
                    echo 找到$year年份的png

                    for month in 12 11 10 9 8 7 6 5 4 3 2 1 ; do
                        num=10
                        #shell 脚本默认数值是由10 进制数处理,除非这个数字某种特殊的标记法或前缀开头. 才可以表示其它进制类型数值。
                        #如果加了0会以为是8进制，所以只能通过在前面另外加0来实现该功能
                        if (( "$month" < "$num" ))
                        then
                            MonthName=$year-0$month
                        else
                            MonthName=$year-$month
                        fi

                        if find monkey-$MonthName*.png
                        then
                            echo 找到$MonthName月份的png

                            for day in 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 ; do
                                if (( "$day" < "$num" ))
                                then
                                    DayName=$MonthName-0$day
                                else
                                    DayName=$MonthName-$day
                                fi

                                if find monkey-$DayName*.png
                                then
                                    echo 找到$DayName的png

                                    for hour in 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0 ; do
                                        if (( "$hour" < "$num" ))
                                        then
                                            HourName=$DayName'T0'$hour
                                        else
                                            HourName=$DayName'T'$hour
                                        fi


                                        if find monkey-$HourName*.png
                                        then
                                            echo 找到$HourName的png

                                            for minute in 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 ; do
                                                if (( "$minute" < "$num" ))
                                                then
                                                    MinuteName=$HourName-0$minute
                                                else
                                                    MinuteName=$HourName-$minute
                                                fi

                                                if find monkey-$MinuteName*.png
                                                then
                                                    echo 找到$MinuteName的png
                                                    break 2016;
                                                fi
                                            done
                                        fi
                                    done
                                fi
                            done
                        fi
                    done
                fi
            done
        fi

        #找最后10秒内的操作截屏PNG文件
        if find monkey-$MinuteName-5*.png
        then
            MinuteName=$MinuteName-5
            echo 找到$MinuteName的png

        elif find monkey-$MinuteName-4*.png
        then
            MinuteName=$MinuteName-4
            echo 找到$MinuteName的png

        elif find monkey-$MinuteName-3*.png
        then
            MinuteName=$MinuteName-3
            echo 找到$MinuteName的png

        elif find monkey-$MinuteName-2*.png
        then
            MinuteName=$MinuteName-2
            echo 找到$MinuteName的png

        elif find monkey-$MinuteName-1*.png
        then
            MinuteName=$MinuteName-1
            echo 找到$MinuteName的png

        elif find monkey-$MinuteName-0*.png
        then
            MinuteName=$MinuteName-0
            echo 找到$MinuteName的png
        fi    

        export PngName=$MinuteName

        Test=~/Desktop/${APP_NAME}_Crash/Crash$LOG_TIME/
        #把最后10秒的操作截屏PNG文件全部复制到~/Desktop/${APP_NAME}_Crash/Crash$LOG_TIME/
        ls "monkey-$PngName"*|xargs -t -I {} cp {} $Test
        #用pngquant把~/Desktop/${APP_NAME}_Crash/Crash$LOG_TIME/下的PNG文件全部压缩一次
        ls "/$Test/monkey-"*.png | xargs -L1 -t ~/Downloads/pngquant/pngquant --ext .png --force 256 --speed 1 --quality=50-60

        cd ~/Desktop/${APP_NAME}_Crash/
        #压缩含有crash文件和最后10秒操作截屏PNG文件的Crash$LOG_TIME/ 文件夹
        zip -r CrashScreenshot$LOG_TIME.zip Crash$LOG_TIME/

    else
        echo 恭喜，没有找到crash文件
    fi

else
    echo 没有找到report文件夹，不需要处理
fi


#把${APP_NAME}_Crash归类到~/Desktop/crash/Auto_Handle_Crash/Auto_Handle_Crash$LOG_TIME
mkdir ~/Desktop/crash/Auto_Handle_Crash/Auto_Handle_Crash$LOG_TIME

cp -r ~/Desktop/${APP_NAME}_Crash ~/Desktop/crash/Auto_Handle_Crash/Auto_Handle_Crash$LOG_TIME

rm -rf ~/Desktop/${APP_NAME}_Crash

mkdir ~/Desktop/${APP_NAME}_Crash
#因为每12个小时自动打包一次，在12小时内运行monkey都需要用到该dSYM文件，所以要把它放回原位
cp -r ~/Desktop/crash/Auto_Handle_Crash/Auto_Handle_Crash$LOG_TIME/${APP_NAME}_Crash/*app ~/Desktop/${APP_NAME}_Crash

cp -r ~/Desktop/crash/Auto_Handle_Crash/Auto_Handle_Crash$LOG_TIME/${APP_NAME}_Crash/*dSYM ~/Desktop/${APP_NAME}_Crash




if find ~/Desktop/crash/Auto_Handle_Crash/Auto_Handle_Crash$LOG_TIME/${APP_NAME}_Crash/Crash$LOG_TIME/*.crash
then

    cd ~/Desktop/crash/Auto_Handle_Crash/Auto_Handle_Crash$LOG_TIME/${APP_NAME}_Crash/
    
    rm -rf Crash$LOG_TIME
    #避免邮件发送失败时没有删除上次test.zip的情况
    if find ~/Desktop/test.zip
    then
        rm -rf ~/Desktop/test.zip
    fi
    
    cp -r ~/Desktop/crash/Auto_Handle_Crash/Auto_Handle_Crash$LOG_TIME/${APP_NAME}_Crash/*zip ~/Desktop/test.zip
    
    HOST="http://192.168.xx.xxx:5000"
    
    URL="${HOST}/send_log"
    
    EMAIL="{\"platform\":\"iOS\",\"appname\":\"${EMAIL_MAPPER}\",\"mailbody\":\"Hi,All:附件是${CNAME}[iPhone]Crash文件和最后10s操作截图PNG文件，如果不想再收到该Crash邮件，请主程尽快解决^_^，谢谢！【定时自动更新APP】备注：新增APP控制台日志(console.log)，有助于更加精确定位Crash问题，欢迎查阅。\"}"
    
    
    function sendmail()
    {
        curl ${URL} -F timestamp=$LOG_TIME  -F title="${APP_NAME}_iOS_MonkeyTest_Crash" -F client_info=$EMAIL -F logfile='@~/Desktop/test.zip' 
    }

    for i in {0..0}; do
        echo "sendmail ${i}"
        sendmail ${i}
    done
    
    rm -rf ~/Desktop/test.zip
    
else
    echo 没有找到crash文件，无需发邮件
fi
