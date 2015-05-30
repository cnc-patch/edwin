typedef char INIClass[];
typedef char FileClass[];

void INIClass__Put_Int(INIClass iniClass, char *section, char *key, int value);
void INIClass__Put_Bool(INIClass iniClass, char *section, char *key, bool value);
void INIClass__Put_String(INIClass iniClass, char *section, char *key, char *value);
int INIClass__Get_Int(INIClass iniClass, char *section, char *key, int defaultValue);
bool INIClass__Get_Bool(INIClass iniClass, char *section, char *key, bool defaultValue);
void INIClass__Get_String(INIClass iniClass, char *section, char *key, char *defaultValue, char *returnedString, int size);
void FileClass__FileClass(FileClass fileClass, char *fileName);
void INIClass__Save(INIClass iniClass, FileClass fileClass);

extern INIClass INIClass__SettingsIni;
extern FileClass FileClass__SettingsIni;
extern int ScrollRate;
extern bool SlowerScrollRate;
extern int ScreenWidth;
extern int ScreenHeight;
extern char EditorLanguage;
extern char MainMixPath[];
extern char RedalertMixPath[];
extern bool VideoBackBuffer;
extern bool HardwareFills;
extern bool SingleProcAffinity;
extern bool LimitCpuUsage;
