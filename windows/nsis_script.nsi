; 该脚本使用 HM VNISEdit 脚本编辑器向导产生

; 安装程序初始定义常量
!define PRODUCT_NAME "CrossDesk"
!define PRODUCT_VERSION "0.0.1"
!define PRODUCT_PUBLISHER "CrossDesk"
!define PRODUCT_WEB_SITE "https://www.crossdesk.cn/"
!define APP_NAME "CrossDesk"
!define UNINSTALL_REG_KEY "CrossDesk"

;★安装包图标
Icon "E:\SourceCode\crossdesk-pkg\icons\crossdesk.ico"
!define MUI_ICON "E:\SourceCode\crossdesk-pkg\icons\crossdesk.ico"

;★压缩设置
SetCompressor /FINAL lzma

;★请求管理员权限（写入HKLM需要）
RequestExecutionLevel admin

; ------ MUI 现代界面定义 ------
!include "MUI.nsh"
!define MUI_ABORTWARNING
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 定义结束 ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "CrossDesk-${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\CrossDesk"
ShowInstDetails show

Section "MainSection"
    SetOutPath "$INSTDIR"
    SetOverwrite ifnewer

    ;★程序主文件
    File /oname=crossdesk.exe "E:\SourceCode\crossdesk-pkg\exec\crossdesk.exe"
	
	; ? 复制图标文件到安装目录
    File "E:\SourceCode\crossdesk-pkg\icons\crossdesk.ico"

    ;★写入卸载信息
    WriteUninstaller "$INSTDIR\uninstall.exe"

    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${UNINSTALL_REG_KEY}" "DisplayName" "${PRODUCT_NAME}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${UNINSTALL_REG_KEY}" "UninstallString" "$INSTDIR\uninstall.exe"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${UNINSTALL_REG_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${UNINSTALL_REG_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${UNINSTALL_REG_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${UNINSTALL_REG_KEY}" "DisplayIcon" "$INSTDIR\crossdesk.ico"
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${UNINSTALL_REG_KEY}" "NoModify" 1
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${UNINSTALL_REG_KEY}" "NoRepair" 1
SectionEnd

Section "Cert"
    SetOutPath "$APPDATA\CrossDesk\certs"
    File /r "E:\SourceCode\crossdesk-pkg\certs\crossdesk.cn_root.crt"
SectionEnd

Section -AdditionalIcons
    ;★桌面快捷方式
    CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\crossdesk.exe" "" "$INSTDIR\crossdesk.ico"

    ;★开始菜单快捷方式
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}.lnk" "$INSTDIR\crossdesk.exe" "" "$INSTDIR\crossdesk.ico"

    ;★网页快捷方式（桌面）
    WriteIniStr "$DESKTOP\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
SectionEnd

Section "Uninstall"
    ; 删除主程序和卸载程序
    Delete "$INSTDIR\crossdesk.exe"
    Delete "$INSTDIR\uninstall.exe"

    ; 递归删除安装目录
    RMDir /r "$INSTDIR"

    ; 删除桌面和开始菜单快捷方式
    Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
    Delete "$DESKTOP\${PRODUCT_NAME}.url"
    Delete "$SMPROGRAMS\${PRODUCT_NAME}.lnk"

    ; 删除注册表卸载项
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${UNINSTALL_REG_KEY}"

    ; 递归删除用户 AppData 中的 CrossDesk 文件夹
    RMDir /r "$APPDATA\CrossDesk"
    RMDir /r "$LOCALAPPDATA\CrossDesk"
SectionEnd


Section -Post
SectionEnd