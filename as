Using Notepad++ to write MapBasic programs

The MapBasic Development Environment contains a built-in text editor that you can use to create and edit MapBasic programs. But if you already have a favorite text editor, you can use that editor for editing your MapBasic program.


Let's suppose that Notepad++ is your editor of choice. Haven't heard of Notepad++ yet? Notepad++ is a very powerful text editor, it's free and it's source is published under the GPL (GNU General Public License).


Notepad++ logo

Here you will find some information on how to configure Notepad++ so that you can use it to develop your own MapBasic applications quickly, easily and effectively. Topics covered here include:


Syntax Highlighting and Auto Completion - Updated to MapBasic 10.5;

Compiling MapBasic Program Source without leaving Notepad++;

Start a MapBasic Application from within Notepad++;

Search MapBasic Help with keywords from within Notepad++;

Modular Programming: Linking a MapBasic Project File from within Notepad++;

Compiling Object Files, Linking Project File and Running Application, all with one Mouse click or Keystroke.




Syntax Highlighting and Auto Completion for MapBasic 10.5

Syntax Highlighting

By default Notepad++ supports a lot of languages. Unfortunately MapBasic is not one of them;-( You will have to add MapBasic as a user defined language.


How?

Download the file userDefineLang.xml and copy it to the folder %USERPROFILE%\Application Data\Notepad++ (i.e. C:\Documents and Settings\my_user_name\Application Data\Notepad++\userDefineLang.xml).

Please note: if you already have other user defined languages, you will need to append the content of this userDefineLang.xml to the existing file. Otherwise you can just copy the file to the aforementioned folder.


Now the syntax will be highlighted by telling Notepad++ to use Language > MapBasic for your file. This works for the following MapBasic and MapInfo Professional file types: *.MB, *.DEF, *.TAB and *.WOR.


Auto Completion

When creating programs with Notepad++ you can make use of auto completion of your source code ("code completion"). To use this feature just type Ctrl+Space; this will trigger the autocomplete list box for the language you are using. Because Notepad++ does not know MapBasic by heart, you will have to add a file with all the keywords to appear in the autocomplete list box.


How?

For Notepad++ version 5.0 (released July 2008) and later versions: mapbasic.xml

Download the file mapbasic.xml and copy it to the folder \plugins\APIs of the Notepad++ installation folder. (i.e. C:\Program Files\Notepad++\plugins\APIs\mapbasic.xml).


For Notepad++ version 4.9.2 and earlier versions: mapbasic.api

Download the file mapbasic.api and copy it to the folder \plugins\APIs of the Notepad++ installation folder. (i.e. C:\Program Files\Notepad++\plugins\APIs\mapbasic.api).


You can now invoke Auto Completion (using Ctrl+space) for MapBasic if you have indicated that the Language of your file is MapBasic. (This means that the file with the user defined language for syntax highlighting should also be in place.)


A few words about the files published here:

The files presented above - userDefineLang.xml, mapbasic.xml and mapbasic.api - are created by the author of this website. (So they are different from the ones you will find elsewhere on the web.)

The content (more than 2500 entries) of the files mapbasic.xml and mapbasic.api is equal. But Notepad++ v5.0 does not support the good old api file anymore, so we had to translate the file to an xml based file format.

The content of the files is based on MapBasic 10.5 (released June 2010).

The files are provided on an "as is" basis. Please read the README.TXT for a proper disclaimer.

You can download the files here in a zipped file.




^^^^^^^^^^^^^^^^^^^^^^^^
Compiling MapBasic Program Source without leaving Notepad++

Now that you are using Notepad++ to edit your MapBasic code, you may not want to switch back to MapBasic whenever you need to compile your application. Fortunately there are ways to compile your MapBasic Program Source without leaving Notepad++. One way would be to call a batch file to start MapBasic in the background.


Please see the batch code below. This will first check that your file is an MB file; if so, it will call MapBasic to compile your file and create an MBX (MapBasic Application). If any compiler errors do occur, you will be prompted to press any key and the error file will be opened for you.


@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
rem Compile_MB.bat
rem This file is used to compile a MapBasic Program Source file from within Notepad++

rem Check that the file is a MapBasic Program Source file
if /i %~x1 NEQ .mb (
        echo Error: file %~dpnx1 is not a MapBasic Program Source file ^(^*.mb^)
        echo.
        pause
) else (

        echo Compiling %~dpnx1
        "C:\Program Files\MapInfo\MapBasic\MAPBASIC.EXE" -server -D %1

        if exist "%~dpn1.err" (
                echo Errors in compilation
                echo Press a key to open error log: %~dpn1.err.
                echo.
                pause
                "C:\Program Files\Notepad++\notepad++.exe" "%~dpn1.err"
        )
)


Steps to follow:

Copy the batch code above and save it to a file Compile_MB.bat. Copy this batch file to the Notepad++ installation folder. (i.e. C:\Program Files\Notepad++\Compile_MB.bat).


Configure Notepad++ to call this batch file by modifying the file shortcuts.xml. You will find this file in the folder %USERPROFILE%\Application Data\Notepad++ (i.e. C:\Documents and Settings\my_user_name\Application Data\Notepad++\shortcuts.xml). Add the following line within the <UserDefinedCommands> tag:


<Command name="Compile MapBasic" Ctrl="yes" Alt="no" Shift="no" Key="49">$(NPP_DIRECTORY)\Compile_MB.bat &quot;$(FULL_CURRENT_PATH)&quot;</Command>


This will add an entry to the Run menu: Run > Compile MapBasic (with the shortcut key Ctrl+1).


Please note: it is not possible to modify the shortcuts.xml file while Notepad++ is running (because it is locked by the program). So you have to use another text editor to do this (or you can copy the file to another location; modify it ; close Notepad++; copy the file back and restart Notepad++).


Conflicting shortcut keys / Notepad++ Shortcut Mapper


Please note: the shortcut key we use here - Ctrl+1 - was still available way back in 2008. Nowadays - from Notepad++ 5.x onwards - this key is assigned to default Notepad++ functionality (Search > Jump down > 1st Style). To resolve this conflict, you can use the Shortcut Mapper in Notepad++ (Settings > Shortcut Mapper...) to modify or disable either one of the shortcut keys.




^^^^^^^^^^^^^^^^^^^^^^^^
Start a MapBasic Application from within Notepad++

Now that you are using Notepad++ to edit and compile your MapBasic application, you may even wish to start your application from within Notepad++. A way to accomplish this would be to call a batch file to run your application.


Please see the batch code below. This will first check that your file is an MB file; if so, it will search for the MBX and run it (and start MapInfo Professional, if necessary). If no MBX is found, you will be prompted to compile your file first.


@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
rem Run_MBX.bat
rem This file is used to run a MapBasic Application from within Notepad++

rem Check that the current file is a MapBasic Program Source file
if /i %~x1 NEQ .mb (
        echo Error: file %~dpnx1 is not a MapBasic Program Source file ^(^*.mb^)
        echo.
        pause
) else (
        if not exist "%~dpn1.mbx" (
                echo Error: file %~dpn1.mbx does not exist
                echo You have to compile the file before you can run it
                echo.
                pause
) else (
        "%~dpn1.mbx"
)
)

Steps to follow:

Copy the batch code above and save it to a file Run_MBX.bat. Copy this batch file to the Notepad++ installation folder. (i.e. C:\Program Files\Notepad++\Run_MBX.bat).


Configure Notepad++ to call this batch file by modifying the file shortcuts.xml. You will find this file in the folder %USERPROFILE%\Application Data\Notepad++ (i.e. C:\Documents and Settings\my_user_name\Application Data\Notepad++\shortcuts.xml). Add the following line within the <UserDefinedCommands> tag:


<Command name="Run MapBasic Application" Ctrl="yes" Alt="no" Shift="no" Key="50">$(NPP_DIRECTORY)\Run_MBX.bat &quot;$(FULL_CURRENT_PATH)&quot;</Command>


This will add an entry to the Run menu: Run > Run MapBasic Application (with the shortcut key Ctrl+2).


Please note: it is not possible to modify the shortcuts.xml file while Notepad++ is running (because it is locked by the program). So you have to use another text editor to do this (or you can copy the file to another location; modify it ; close Notepad++; copy the file back and restart Notepad++).


Conflicting shortcut keys / Notepad++ Shortcut Mapper


Please note: the shortcut key we use here - Ctrl+2 - was still available way back in 2008. Nowadays - from Notepad++ 5.x onwards - this key is assigned to default Notepad++ functionality (Search > Jump down > 2nd Style). To resolve this conflict, you can use the Shortcut Mapper in Notepad++ (Settings > Shortcut Mapper...) to modify or disable either one of the shortcut keys.




^^^^^^^^^^^^^^^^^^^^^^^^
Search MapBasic Help with keywords from within Notepad++

Now that you have configured Notepad++ to be your MapBasic Program Source editor, you may wish to be able to search MapBasic Help with keywords from within Notepad++. So you would like to open the MapBasic.chm file and immediately search for a certain keyword. The default program which is used to open CHM files is hh.exe (Microsoft HTML Help Executable). Unfortunately hh.exe does not support the use of keywors;-(


To get the job done, you need an additional little tool: KeyHH.exe. KeyHH.exe from KeyWorks Software is available for free. After you have downloaded and installed KeyHH.exe (in the Windows folder), you can use the command line option -#klink to search for a keyword.


Let's say you want to search the MapBasic.chm on the keyword Tables. In a DOS window you would enter the following command:

keyhh -#klink Tables "C:\Program Files\MapInfo\MapBasic\MapBasic.chm"


How to use this in Notepad++?

Configure Notepad++ to call KeyHH.exe by modifying the file shortcuts.xml. You will find this file in the folder %USERPROFILE%\Application Data\Notepad++ (i.e. C:\Documents and Settings\my_user_name\Application Data\Notepad++\shortcuts.xml). Add the following line within the <UserDefinedCommands> tag:


<Command name="Search MapBasic Help" Ctrl="yes" Alt="no" Shift="no" Key="51">keyhh -#klink $(CURRENT_WORD) &quot;C:\Program Files\MapInfo\MapBasic\MapBasic.chm&quot;</Command>


This will add an entry to the Run menu: Run > Search MapBasic Help (with the shortcut key Ctrl+3).


Please note: it is not possible to modify the shortcuts.xml file while Notepad++ is running (because it is locked by the program). So you have to use another text editor to do this (or you can copy the file to another location; modify it ; close Notepad++; copy the file back and restart Notepad++).


Conflicting shortcut keys / Notepad++ Shortcut Mapper


Please note: the shortcut key we use here - Ctrl+3 - was still available way back in 2008. Nowadays - from Notepad++ 5.x onwards - this key is assigned to default Notepad++ functionality (Search > Jump down > 3rd Style). To resolve this conflict, you can use the Shortcut Mapper in Notepad++ (Settings > Shortcut Mapper...) to modify or disable either one of the shortcut keys.


Of course, this tip about KeyHH.exe is not confined to the MapBasic.chm. You can use it for other help files as well;-)
