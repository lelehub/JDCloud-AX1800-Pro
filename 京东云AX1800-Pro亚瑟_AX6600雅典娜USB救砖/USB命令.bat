@echo off

title=AX1800 Pro/AX6600 USB救砖

echo ***********************************************************************************
echo * 如果没有安装Qualcomm USB Driver驱动，请先安装                                   *
echo * USB线连接路由器和电脑，路由器上电会进入Qualcomm Emergency Download mode         *
echo * 此时设备管理器-端口 (COM 和 LPT) 下会出现Qualcomm HS-USB QDLoader 9008的COM端口 *
echo * 如果未出现，则需要拆机短接启动电阻，路由器再上电，出现后可松开短接              *
echo * 输入9008的COM端口号并回车，第一个命令执行后注意观察设备管理器是否已刷新两次     *
echo * 观察已刷新两次，再等待5秒，如果要进入U-Boot webui此时可以按住reset按键          *
echo * 然后按任意键执行第二个命令，执行成功后路由器会亮灯                              *
echo * 也可以不按reset键，U-Boot会直接启动原闪存上的固件                               *
echo ***********************************************************************************

echo 1.京东云AX1800 Pro亚瑟
echo 2.京东云AX6600雅典娜
:modelSTART
set /p model=请输入序号：

set "SBL1=mmcblk0p1_0SBL1.bin"
set "DEVCFG=mmcblk0p6_0DEVCFG.bin"
set "QSEE=mmcblk0p4_0QSEE.bin"
set "RPM=mmcblk0p8_0RPM.bin"
set "APPSBL=mmcblk0p13_0APPSBL.bin"

if "%model%"=="1" (
	set "CDT=mmcblk0p10_0CDT_AX1800_Pro.bin"
	echo ^>^>^>已选择1.京东云AX1800 Pro亚瑟
	echo.
) else if "%model%"=="2" (
	set "CDT=mmcblk0p10_0CDT_AX6600_Athena.bin"
	echo ^>^>^>已选择2.京东云AX6600雅典娜
	echo.
) else (
	echo 无效的输入，请重新输入1或2。
	goto modelSTART
)

echo.
set /p comPort=请输入COM端口号：
echo ^>^>^>输入端口号为COM%comPort%
cd /d %~dp0\QSahara
echo 正在上传SBL1。。。
echo QSaharaServer.exe -p \\.\COM%comPort% -s 13:%SBL1%
QSaharaServer.exe -p \\.\COM%comPort% -s 13:%SBL1%
echo.
echo ^>^>^>看到最后输出Sahara protocol completed说明SBL1已上传成功
echo ^>^>^>观察到设备管理器刷新两次后，按任意键继续下一步
echo.
pause
echo 正在上传CDT DEVCFG QSEE RPM APPSBL。。。
echo QsaharaServer.exe -p \\.\COM%comPort% -s 1:%CDT% -s 34:%DEVCFG% -s 25:%QSEE% -s 23:%RPM% -s 5:%APPSBL%
QsaharaServer.exe -p \\.\COM%comPort% -s 1:%CDT% -s 34:%DEVCFG% -s 25:%QSEE% -s 23:%RPM% -s 5:%APPSBL%
echo.
echo ^>^>^>看到最后输出Sahara protocol completed说明CDT DEVCFG QSEE RPM APPSBL已上传成功
echo ^>^>^>请查看路由器LED是否亮起，检查是否能进入U-Boot，并及时断开USB线
echo.
pause