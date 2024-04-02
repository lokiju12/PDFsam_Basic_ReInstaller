@echo off

rem PDFsam Basic 프로세스 종료
taskkill /f /im pdfsam.exe
taskkill /f /im pdfsam.exe
taskkill /f /im pdfsam.exe
taskkill /f /im pdfsam.exe

rem 기존 PDFsam Basic 삭제
wmic product where "name='PDFsam Basic'" call uninstall /nointeractive

rem 기존 폴더 삭제
rmdir /s /q "C:\Program Files\PDFsam Basic"
rmdir /s /q "C:\Program Files (x86)\PDFsam Basic"

rem 5.1.1 설치
:: 중지한 기능
:: 시작시 업데이트 = 재부팅 후 적용, 뉴스, 도네이션, 홈페이지스킵, 프리미엄기능
msiexec /i "msi\pdfsam-5.1.1.msi" /qb /norestart CHECK_FOR_UPDATES=false CHECK_FOR_NEWS=false PLAY_SOUNDS=false DONATE_NOTIFICATION=false SKIPTHANKSPAGE=Yes PREMIUM_MODULES=no org.pdfsam.default.checkforupdate=false org.pdfsam.default.donate.notification=false org.pdfsam.default.fetch.premium.modules=false

rem 바로 가기 파일 생성
set "pdfsam_path=C:\Program Files\PDFsam Basic"
set "pdfsam_exe=%pdfsam_path%\pdfsam.exe"
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%public%\Desktop\PDFsam Basic.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%pdfsam_exe%" >> CreateShortcut.vbs
echo oLink.IconLocation = "%pdfsam_exe%" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript /nologo CreateShortcut.vbs
del CreateShortcut.vbs

start "" "%pdfsam_exe%"
