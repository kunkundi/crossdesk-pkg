; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; ��װ�����ʼ���峣��
!define PRODUCT_NAME "CrossDesk"
!define PRODUCT_VERSION "0.0.1"
!define PRODUCT_PUBLISHER "CrossDesk"
!define PRODUCT_WEB_SITE "https://www.crossdesk.cn/"
!define APP_NAME "CrossDesk"
!define UNINSTALL_REG_KEY "CrossDesk"

;�ﰲװ��ͼ��
Icon "E:\SourceCode\crossdesk-pkg\icons\crossdesk.ico"
!define MUI_ICON "E:\SourceCode\crossdesk-pkg\icons\crossdesk.ico"

;��ѹ������
SetCompressor /FINAL lzma

;���������ԱȨ�ޣ�д��HKLM��Ҫ��
RequestExecutionLevel admin

; ------ MUI �ִ����涨�� ------
!include "MUI.nsh"
!define MUI_ABORTWARNING
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI ������� ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "CrossDesk-${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\CrossDesk"
ShowInstDetails show

Section "MainSection"
    SetOutPath "$INSTDIR"
    SetOverwrite ifnewer

    ;��������ļ�
    File /oname=crossdesk.exe "E:\SourceCode\crossdesk-pkg\exec\crossdesk.exe"
	
	; ? ����ͼ���ļ�����װĿ¼
    File "E:\SourceCode\crossdesk-pkg\icons\crossdesk.ico"

    ;��д��ж����Ϣ
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
    ;�������ݷ�ʽ
    CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\crossdesk.exe" "" "$INSTDIR\crossdesk.ico"

    ;�￪ʼ�˵���ݷ�ʽ
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}.lnk" "$INSTDIR\crossdesk.exe" "" "$INSTDIR\crossdesk.ico"

    ;����ҳ��ݷ�ʽ�����棩
    WriteIniStr "$DESKTOP\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
SectionEnd

Section "Uninstall"
    ; ɾ���������ж�س���
    Delete "$INSTDIR\crossdesk.exe"
    Delete "$INSTDIR\uninstall.exe"

    ; �ݹ�ɾ����װĿ¼
    RMDir /r "$INSTDIR"

    ; ɾ������Ϳ�ʼ�˵���ݷ�ʽ
    Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
    Delete "$DESKTOP\${PRODUCT_NAME}.url"
    Delete "$SMPROGRAMS\${PRODUCT_NAME}.lnk"

    ; ɾ��ע���ж����
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${UNINSTALL_REG_KEY}"

    ; �ݹ�ɾ���û� AppData �е� CrossDesk �ļ���
    RMDir /r "$APPDATA\CrossDesk"
    RMDir /r "$LOCALAPPDATA\CrossDesk"
SectionEnd


Section -Post
SectionEnd