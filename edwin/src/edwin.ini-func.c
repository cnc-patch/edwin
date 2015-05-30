#include <windows.h>
#include <stdbool.h>
#include "macros/patch.h"
#include "edwin.h"

char SettingsIniPath[] = "edwin.ini";

void LoadSettingsIni()
{
    ScrollRate = INIClass__Get_Int(INIClass__SettingsIni, "Options", "ScrollRate", 3);
    SlowerScrollRate = INIClass__Get_Bool(INIClass__SettingsIni, "Options", "SlowerScrollRate", SlowerScrollRate);
    ScreenWidth = INIClass__Get_Int(INIClass__SettingsIni, "Options", "EditorWidth", 640);
    ScreenHeight = INIClass__Get_Int(INIClass__SettingsIni, "Options", "EditorHeight", 400);
    EditorLanguage = INIClass__Get_Int(INIClass__SettingsIni, "Options", "EditorLanguage", 0);
    INIClass__Get_String(INIClass__SettingsIni, "Options", "MainMix", MainMixPath, MainMixPath, 256);
    INIClass__Get_String(INIClass__SettingsIni, "Options", "RedalertMix", RedalertMixPath, RedalertMixPath, 256);
    VideoBackBuffer = INIClass__Get_Bool(INIClass__SettingsIni, "Options", "VideoBackBuffer", 1);
    HardwareFills = INIClass__Get_Bool(INIClass__SettingsIni, "Options", "HardwareFills", 0);
    SingleProcAffinity = INIClass__Get_Bool(INIClass__SettingsIni, "Options", "SingleProcAffinity", SingleProcAffinity);
    LimitCpuUsage = INIClass__Get_Bool(INIClass__SettingsIni, "Options", "LimitCpuUsage", LimitCpuUsage);
}

void SaveSettingsIni()
{
    INIClass__Put_Int(INIClass__SettingsIni, "Options", "ScrollRate", ScrollRate);
    INIClass__Put_Bool(INIClass__SettingsIni, "Options", "SlowerScrollRate", SlowerScrollRate);
    INIClass__Put_Int(INIClass__SettingsIni, "Options", "EditorWidth", ScreenWidth);
    INIClass__Put_Int(INIClass__SettingsIni, "Options", "EditorHeight", ScreenHeight);
    INIClass__Put_Int(INIClass__SettingsIni, "Options", "EditorLanguage", (int)EditorLanguage);
    INIClass__Put_String(INIClass__SettingsIni, "Options", "MainMix", MainMixPath);
    INIClass__Put_String(INIClass__SettingsIni, "Options", "RedalertMix", RedalertMixPath);
    INIClass__Put_Bool(INIClass__SettingsIni, "Options", "VideoBackBuffer", VideoBackBuffer);
    INIClass__Put_Bool(INIClass__SettingsIni, "Options", "HardwareFills", HardwareFills);
    INIClass__Put_Bool(INIClass__SettingsIni, "Options", "SingleProcAffinity", SingleProcAffinity);
    INIClass__Put_Bool(INIClass__SettingsIni, "Options", "LimitCpuUsage", LimitCpuUsage);

    FileClass__FileClass(FileClass__SettingsIni, SettingsIniPath);
    INIClass__Save(INIClass__SettingsIni, FileClass__SettingsIni);
}
