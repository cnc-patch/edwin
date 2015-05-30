%include "macros/setsym.inc"

setcglob 0x0048FBBA, start

; ### vars ###
setcglob 0x004D86F0, ScrollRate
setcglob 0x004AF944, ScreenWidth
setcglob 0x004AF948, ScreenHeight
setcglob 0x004EA354, EditorLanguage
setcglob 0x004B0978, VideoBackBuffer
setcglob 0x004B5820, HardwareFills
setcglob 0x004D7D21, MapCopyPasteCellsWidth
setcglob 0x004D874C, MapInfoStruct
setcglob 0x004D88BF, SelectedAreaTopLeftCell
setcglob 0x004D88C1, SelectedAreaBottomRightCell

setcglob 0x4ECB48, SidebarButtonShoreX
setcglob 0x4ECB84, SidebarButtonRiverX
setcglob 0x4ECBC0, SidebarButtonRoadX
setcglob 0x4ECBFC, SidebarButtonRidgesX
setcglob 0x4ECC38, SidebarButtonTreesX
setcglob 0x4ECC74, SidebarButtonDebrisX
setcglob 0x4ECD90, SidebarButtonLeftArrowX
setcglob 0x4ECDC8, SidebarButtonRightArrowX
setcglob 0x4ECE00, SidebarButtonTileBrowserX
setcglob 0x4ECE38, SidebarButtonFlagX
setcglob 0x4ECE70, SidebarButtonTileSelectionX
setcglob 0x4ECCB0, SidebarButtonTerrainClearX
setcglob 0x4ECD20, SidebarButtonTerrainOreX
setcglob 0x4ECD58, SidebarButtonTerrainGemX
setcglob 0x4ECCE8, SidebarButtonTerrainWaterX

; ### functions ###
setcglob 0x0047AA3A, INIClass__ClearSection
setcglob 0x00446672, LoadBlankMap
setcglob 0x00446A6D, LoadMapFile
setcglob 0x00474278, OriginalWindowProcedure
setcglob 0x0044A737, FillSelectedArea
setcglob 0x004481F5, TileBrowserDialog
setcglob 0x0041F915, MainLoop


setcglob 0x00485561, strcpy
setcglob 0x0047A687, strncpy
setcglob 0x0047FA83, stricmp
setcglob 0x00485548, strlen
setcglob 0x00485523, memcpy
setcglob 0x0048CA0D, strstr

; winapi
setcglob 0x005401F0, _imp__CreateFileA
setcglob 0x005401EC, _imp__CloseHandle
setcglob 0x00540428, _imp__LoadLibraryA
setcglob 0x00540418, _imp__GetProcAddress
setcglob 0x0054020C, _imp__GetCurrentProcess
setcglob 0x00540258, _imp__Sleep

; watcall functions
setwatglob 0x0047B6F7, INIClass__Put_Int, 4
setwatglob 0x0047B7A9, INIClass__Get_Int, 4
setwatglob 0x0047B945, INIClass__Put_String, 4
setwatglob 0x0047BAA4, INIClass__Get_String, 6
setwatglob 0x0047BB68, INIClass__Put_Bool, 4
setwatglob 0x0047BBBC, INIClass__Get_Bool, 4
setwatglob 0x004098FF, INIClass__Save, 2
setwatglob 0x0047CDE5, FileClass__FileClass, 2
        
;Address  Ordinal Name                      Library 
;-------  ------- ----                      ------- 
;00540108         ClipCursor                USER32  
;0054010C         CreateWindowExA           USER32  
;00540110         DefWindowProcA            USER32  
;00540114         DialogBoxParamA           USER32  
;00540118         DispatchMessageA          USER32  
;0054011C         FindWindowA               USER32  
;00540120         GetAsyncKeyState          USER32  
;00540124         GetCursorPos              USER32  
;00540128         GetKeyState               USER32  
;0054012C         GetMessageA               USER32  
;00540130         GetSystemMetrics          USER32  
;00540134         LoadIconA                 USER32  
;00540138         MessageBoxA               USER32  
;0054013C         PeekMessageA              USER32  
;00540140         PostMessageA              USER32  
;00540144         PostQuitMessage           USER32  
;00540148         RegisterClassA            USER32  
;0054014C         RegisterWindowMessageA    USER32  
;00540150         SetFocus                  USER32  
;00540154         SetForegroundWindow       USER32  
;00540158         ShowCursor                USER32  
;0054015C         ShowWindow                USER32  
;00540160         TranslateMessage          USER32  
;00540164         UpdateWindow              USER32  
;00540168         VkKeyScanA                USER32  
;005401F4         CreateThread              KERNEL32
;005401F8         DeleteCriticalSection     KERNEL32
;005401FC         DeleteFileA               KERNEL32
;00540200         DuplicateHandle           KERNEL32
;00540204         EnterCriticalSection      KERNEL32
;00540208         ExitProcess               KERNEL32
;00540210         GetCurrentThread          KERNEL32
;00540214         GetDriveTypeA             KERNEL32
;00540218         GetFileSize               KERNEL32
;0054021C         GetLastError              KERNEL32
;00540220         GetLocalTime              KERNEL32
;00540224         GetModuleFileNameA        KERNEL32
;00540228         GetPriorityClass          KERNEL32
;0054022C         GetSystemTime             KERNEL32
;00540230         GetThreadContext          KERNEL32
;00540234         GetVolumeInformationA     KERNEL32
;00540238         GlobalMemoryStatus        KERNEL32
;0054023C         InitializeCriticalSection KERNEL32
;00540240         LeaveCriticalSection      KERNEL32
;00540244         OutputDebugStringA        KERNEL32
;00540248         ReadFile                  KERNEL32
;0054024C         SetFilePointer            KERNEL32
;00540250         SetPriorityClass          KERNEL32
;00540254         SetThreadPriority         KERNEL32
;0054025C         TerminateThread           KERNEL32
;00540260         WriteFile                 KERNEL32
;00540274         GetActiveWindow           USER32  
;00540278         wsprintfA                 USER32  
;005402A0         mmioClose                 WINMM   
;005402A4         mmioOpenA                 WINMM   
;005402A8         mmioWrite                 WINMM   
;005402AC         timeBeginPeriod           WINMM   
;005402B0         timeEndPeriod             WINMM   
;005402B4         timeKillEvent             WINMM   
;005402B8         timeSetEvent              WINMM   
;005402C8         DirectDrawCreate          DDRAW   
;005403A8         CloseHandle               KERNEL32
;005403AC         CreateEventA              KERNEL32
;005403B0         CreateFileA               KERNEL32
;005403B4         CreateMutexA              KERNEL32
;005403B8         CreateThread              KERNEL32
;005403BC         DeleteFileA               KERNEL32
;005403C0         DosDateTimeToFileTime     KERNEL32
;005403C4         ExitProcess               KERNEL32
;005403C8         ExitThread                KERNEL32
;005403CC         FileTimeToDosDateTime     KERNEL32
;005403D0         FileTimeToLocalFileTime   KERNEL32
;005403D4         FindClose                 KERNEL32
;005403D8         FindFirstFileA            KERNEL32
;005403DC         FindNextFileA             KERNEL32
;005403E0         GetCPInfo                 KERNEL32
;005403E4         GetCommandLineA           KERNEL32
;005403E8         GetConsoleMode            KERNEL32
;005403EC         GetCurrentDirectoryA      KERNEL32
;005403F0         GetCurrentProcessId       KERNEL32
;005403F4         GetCurrentThreadId        KERNEL32
;005403F8         GetCurrentThread          KERNEL32
;005403FC         GetDiskFreeSpaceA         KERNEL32
;00540400         GetEnvironmentStrings     KERNEL32
;00540404         GetFileType               KERNEL32
;00540408         GetLastError              KERNEL32
;0054040C         GetLocalTime              KERNEL32
;00540410         GetModuleFileNameA        KERNEL32
;00540414         GetModuleHandleA          KERNEL32
;0054041C         GetStdHandle              KERNEL32
;00540420         GetTimeZoneInformation    KERNEL32
;00540424         GetVersion                KERNEL32
;0054042C         LocalFileTimeToFileTime   KERNEL32
;00540430         ReadConsoleInputA         KERNEL32
;00540434         ReadFile                  KERNEL32
;00540438         ReleaseMutex              KERNEL32
;0054043C         RtlUnwind                 KERNEL32
;00540440         SetConsoleCtrlHandler     KERNEL32
;00540444         SetConsoleMode            KERNEL32
;00540448         SetCurrentDirectoryA      KERNEL32
;0054044C         SetEvent                  KERNEL32
;00540450         SetFilePointer            KERNEL32
;00540454         SetStdHandle              KERNEL32
;00540458         TlsAlloc                  KERNEL32
;0054045C         TlsFree                   KERNEL32
;00540460         TlsGetValue               KERNEL32
;00540464         TlsSetValue               KERNEL32
;00540468         VirtualAlloc              KERNEL32
;0054046C         VirtualFree               KERNEL32
;00540470         WaitForSingleObject       KERNEL32
;00540474         WriteConsoleA             KERNEL32
;00540478         WriteFile                 KERNEL32
;00540488         DirectSoundCreate         DSOUND  