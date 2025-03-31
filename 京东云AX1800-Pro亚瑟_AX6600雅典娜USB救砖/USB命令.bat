@echo off

title=AX1800 Pro/AX6600 USB��ש

echo ***********************************************************************************
echo * ���û�а�װQualcomm USB Driver���������Ȱ�װ                                   *
echo * USB������·�����͵��ԣ�·�����ϵ�����Qualcomm Emergency Download mode         *
echo * ��ʱ�豸������-�˿� (COM �� LPT) �»����Qualcomm HS-USB QDLoader 9008��COM�˿� *
echo * ���δ���֣�����Ҫ����̽��������裬·�������ϵ磬���ֺ���ɿ��̽�              *
echo * ����9008��COM�˿ںŲ��س�����һ������ִ�к�ע��۲��豸�������Ƿ���ˢ������     *
echo * �۲���ˢ�����Σ��ٵȴ�5�룬���Ҫ����U-Boot webui��ʱ���԰�סreset����          *
echo * Ȼ�������ִ�еڶ������ִ�гɹ���·����������                              *
echo * Ҳ���Բ���reset����U-Boot��ֱ������ԭ�����ϵĹ̼�                               *
echo ***********************************************************************************

echo 1.������AX1800 Pro��ɪ
echo 2.������AX6600�ŵ���
:modelSTART
set /p model=��������ţ�

set "SBL1=mmcblk0p1_0SBL1.bin"
set "DEVCFG=mmcblk0p6_0DEVCFG.bin"
set "QSEE=mmcblk0p4_0QSEE.bin"
set "RPM=mmcblk0p8_0RPM.bin"
set "APPSBL=mmcblk0p13_0APPSBL.bin"

if "%model%"=="1" (
	set "CDT=mmcblk0p10_0CDT_AX1800_Pro.bin"
	echo ^>^>^>��ѡ��1.������AX1800 Pro��ɪ
	echo.
) else if "%model%"=="2" (
	set "CDT=mmcblk0p10_0CDT_AX6600_Athena.bin"
	echo ^>^>^>��ѡ��2.������AX6600�ŵ���
	echo.
) else (
	echo ��Ч�����룬����������1��2��
	goto modelSTART
)

echo.
set /p comPort=������COM�˿ںţ�
echo ^>^>^>����˿ں�ΪCOM%comPort%
cd /d %~dp0\QSahara
echo �����ϴ�SBL1������
echo QSaharaServer.exe -p \\.\COM%comPort% -s 13:%SBL1%
QSaharaServer.exe -p \\.\COM%comPort% -s 13:%SBL1%
echo.
echo ^>^>^>����������Sahara protocol completed˵��SBL1���ϴ��ɹ�
echo ^>^>^>�۲쵽�豸������ˢ�����κ󣬰������������һ��
echo.
pause
echo �����ϴ�CDT DEVCFG QSEE RPM APPSBL������
echo QsaharaServer.exe -p \\.\COM%comPort% -s 1:%CDT% -s 34:%DEVCFG% -s 25:%QSEE% -s 23:%RPM% -s 5:%APPSBL%
QsaharaServer.exe -p \\.\COM%comPort% -s 1:%CDT% -s 34:%DEVCFG% -s 25:%QSEE% -s 23:%RPM% -s 5:%APPSBL%
echo.
echo ^>^>^>����������Sahara protocol completed˵��CDT DEVCFG QSEE RPM APPSBL���ϴ��ɹ�
echo ^>^>^>��鿴·����LED�Ƿ����𣬼���Ƿ��ܽ���U-Boot������ʱ�Ͽ�USB��
echo.
pause