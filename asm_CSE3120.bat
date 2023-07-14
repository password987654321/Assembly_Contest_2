@ECHO OFF
rem Author: Marius Silaghi, 2019
SET FILEBASE=%~n1
echo Handling Source: %FILEBASE%
setlocal

rem You may use quotes only once, for the whole parameter
set "PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.34.31933\bin\HostX86\x86;C:\Program Files (x86)\Windows Kits\10\bin\10.0.22000.0\x86;;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\tools;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\ide;C:\Program Files (x86)\HTML Help Workshop;;C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin;C:\Windows\Microsoft.NET\Framework\v4.0.30319\;;C:\Program Files\Microsoft\jdk-11.0.12.7-hotspot\bin;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\dotnet\;C:\Users\Marcu\AppData\Local\Microsoft\WindowsApps;C:\Users\Marcu\.dotnet\tools;"

set "LIB=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.34.31933\lib\x86;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.34.31933\atlmfc\lib\x86;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x86;;C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\ucrt\x86;;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib;C:\Program Files (x86)\Windows Kits\10\lib\10.0.22000.0\um\x86;lib\um\x86;"

set "LIBPATH=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.34.31933\atlmfc\lib\x86;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.34.31933\lib\x86;"


set "INCLUDE=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.34.31933\include;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.34.31933\atlmfc\include;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include;;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt;;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt;Include\um;"

set "EXTERNAL_INCLUDE=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.34.31933\include;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.34.31933\atlmfc\include;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include;;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\ucrt;;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\winrt;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\cppwinrt;Include\um;"


rem ml.exe /c /nologo /Sg /Zi /Fo"%FILEBASE%.obj" /Fl"%FILEBASE%.lst" /I "c:\Irvine" /W3 /errorReport:prompt /Ta%FILEBASE%.asm


FOR %%F IN (%*) DO (
echo Handling %%~nF
ml.exe /c /nologo /Sg /Zi /Fo"%%~nF.obj" /Fl"%%~nF.lst" /I "c:\Irvine" /W3 /errorReport:prompt /Ta%%~nF.asm
)

link.exe /ERRORREPORT:PROMPT /OUT:"%FILEBASE%.exe" /NOLOGO /LIBPATH:c:\Irvine user32.lib irvine32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /MANIFEST /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /manifest:embed /DEBUG /SUBSYSTEM:CONSOLE /TLBID:1 /DYNAMICBASE:NO /MACHINE:X86 /SAFESEH:NO %FILEBASE%.obj

endlocal

