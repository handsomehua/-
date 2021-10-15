;-------------------屏蔽Win键弹出菜单--------------------------------
~LWin::Send {Blind}{vk07}
return

;-------------------【空格+y】--------------------------------
space & y:: ;解压缩到当前文件夹
	if BeforeActionDo_CheckMode("TMylistBox","LCLListBox") 
	{
		Clipboard := ""
		Send,^c
		ClipWait, 1
		candyselected=%clipboard%
		IntUnZip_Many_In_FirstLevel:=0
		IntUnZip_Folder_In_FirstLevel:=0
		aaaa:=""
		bbbb:=""
		Count:=1
		IntUnZip_FileLists=%a_temp%\wannianshuyao_IntUnZip_%a_now%.txt
		7Z=H:\文件压缩解压\7-Zip\7z.exe
		7ZG=H:\文件压缩解压\7-Zip\7zG.exe
		Splitpath ,CandySelected,,IntUnZip_FileDir,,IntUnZip_FileNameNoExt,IntUnZip_FileDrive
		DriveSpaceFree , IntUnZip_FreeSpace, %IntUnZip_FileDrive%
		FileGetSize, IntUnZip_FileSize, %CandySelected%, M
		;If ( IntUnZip_FileSize > IntUnZip_FreeSpace )
		;{
		;	MsgBox 磁盘空间不足,请检查后再解压。`n------------`n压缩包大小为%IntUnZip_FileSize%M`n剩余空间为%IntUnZip_FreeSpace%M
		;	Return
		;}
		Runwait, %Comspec% /C %7Z% L "%CandySelected%" `>"%IntUnZip_FileLists%",,hide
		Loop,read,%IntUnZip_FileLists%
		{
			If(regexmatch(a_loopreadline,"^\d{4}-\d{2}-\d{2}"))
			{
				If( Instr(a_loopreadline,"d")=21 Or Instr(a_loopreadline,"\"))  ;本行如果包含\或者有d标志，则判定为文件夹
				{
					IntUnZip_Folder_In_FirstLevel=1
				}
				aaaa:=RegExReplace(A_LoopReadLine,"^\d{4}-\d{2}-\d{2}.{43}(.*?)(\\.*|$)","$1")
				If(bbbb != aaaa  And  bbbb!="" )
				{
					IntUnZip_Many_In_FirstLevel=1
					Break
				}
				bbbb:=aaaa
			}
		}
		Filedelete,%IntUnZip_FileLists%
		If(IntUnZip_Many_In_FirstLevel=0 && IntUnZip_Folder_In_FirstLevel=0 )   ;压缩文件内，首层有且仅有一个文件
		{
			Run, %7Zg% X "%CandySelected%" -O"%IntUnZip_FileDir%"    ;覆盖还是改名，交给7z
		}
		Else If(IntUnZip_Many_In_FirstLevel=0 && IntUnZip_Folder_In_FirstLevel=1 )   ;压缩文件内，首层有且仅有一个文件夹
		{
			IntUnzip_FilePath:=IntUnZip_FileDir "\" aaaa
			If not	FileExist(IntUNzip_FilePath)  ;不存在同名文件夹？则直接解压
			{
				Run, %7Zg% X "%CandySelected%" -O"%IntUnZip_FileDir%"
			}
			Else  ;存在同名文件夹？则加一个后缀。遗憾的是，这样的话，一定会生成”多余“文件夹。
			{
				IntUnzip_FilePath_test:=IntUnzip_FilePath
				While,fileexist(IntUnzip_FilePath)
				{
					IntUnzip_FilePath:=IntUnzip_FilePath_test "(" Count ")"
					Count+=1
				}
				Run %7Zg% X  "%CandySelected%" -O"%IntUnzip_FilePath%"
			}
		}
		Else  ;压缩文件内，首层有多个文件(夹)，此时不论怎么的，都得生成 “压缩文件名”为名的文件夹。
		{
			IntUnzip_FilePath :=IntUnZip_FileDir "\" IntUnZip_FileNameNoExt
			IntUnzip_FilePath_test:=IntUnzip_FilePath
			While,fileexist(IntUnzip_FilePath)
			{
				IntUnzip_FilePath:=IntUnzip_FilePath_test "(" Count ")"
				Count+=1
			}
			Run %7Zg% X  "%CandySelected%" -O"%IntUnzip_FilePath%"
		}
		Return
	}
	else
		Send %A_ThisHotkey%
return





BeforeActionDo_CheckMode(ControlNames*)  {  ;ControlNames为当前需要使用vim模式的控件（可以仅为控件名称开头部分），逗号隔开，返回值1表示vim模式可用
	ControlGetFocus,OutputVar
	if WinExist("ahk_class #32768") ;是否存在菜单窗口
		return 0
	if !OutputVar    ;变量为空，没有获取到控件名称
		return 2
	for index,ControlName in ControlNames
	{
		ListName:= ControlNames[index]
		if OutputVar contains %ListName%
			Return 1	
	}
	Return 0
}



space & i::
Send ^{x}
Sleep, 200
Loop
{
StringReplace, clipboard, clipboard,",',UseErrorLevel
if ErrorLevel = 0
break
}

Loop
{
StringReplace, clipboard, clipboard,',\",UseErrorLevel
if ErrorLevel = 0
break
}
clipboard := clipboard
Send ^v
;----------------重置alt+tab为最近两个窗口切换--------------------
#Persistent
SetTimer, Alert1, 500
WindowList:=[]
return
 
Alert1:
	Value := WindowList.Pop()
	if (Value=WinExist("A"))
	{
		WindowList.push(WinExist("A"))
	}
	else
	{
		if (value!="")
			WindowList.push(Value)
		WindowList.push(WinExist("A"))
	}
return

  ;-------------------【空格+f】切换#3--------------------------------
space &  f::
Send #{3}
return

space &  r::
Switch := ((Switch = 1) ? 0 : 1)
If Switch{
	Send #{1}
	return 
}Else{
    	Send #{2}
	return
}





;--------------------【shift+x】关闭或关机---------------------------------
+x:: send !{f4}
return
;------------------------【shift+q】计时器-------------------------
+q::
var := 0
InputBox,time,请输入一个时间（单位分钟）
time := time*60000
Sleep,%time%
loop,16
{
var += 180
SoundBeep,var,500
}
msgbox , , 啦啦啦, 该休息了, 5
return
;-------------------【shift+r】打开任务管理器---------------------------------
+r::
Run taskmgr
return
;-------------------【shift+l】打开网络链接---------------------------------
+l::
run ::{7007acc7-3202-11d1-aad2-00805fc1270e}
Return
;-------------------【shift+n】打开我的电脑---------------------------------
+n::
Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d}
Return


;-------------------【shift+a】暗屏---------------------------------
+a:: 
Sleep 1000  ; 让用户有机会释放按键 (以防释放它们时再次唤醒显视器).
SendMessage, 0x112, 0xF170, 2,, Program Manager  ; 0x112 为 WM_SYSCOMMAND, 0xF170 为 SC_MONITORPOWER.
return
;------------------【shift】复制路径-----------------------------
+f::
send ^c
sleep,200
clipboard=%clipboard% ;windows 复制的时候，剪贴板保存的是“路径”。只是路径不是字符串，只要转换成字符串就可以粘贴出来了
tooltip,%clipboard% ;提示文本
sleep,500
tooltip,
return
;--------------------【shift+c】创建文件夹-----------------------------------
+c::
send ^+{n}
return
;-------------------【shift+d】切换桌面--------------------------------
+d::
send #{d}
return
;-------------------【shift+z】最大化窗口--------------------------------
+z::
WinGet,S,MinMax,A
if S=0
    WinMaximize,A
else
    WinRestore,A
return

;-------------------【shift+s】打开方式--------------------------------
+s::
send {AppsKey}{w}{h}
return
;---------------【ctrl+shift】打开选中路径------------------------
^+::
send ^c 
clipwait 
Clipboard := Trim(clipboard,A_Space) 
Run  %clipboard%
return



;-------------------浏览器--------------------------------
;-------------------【shift+w】后退-------------------------------
+w::
Send , {BROWSER_BACK}
return
;-------------------【shift+e】前进-------------------------------
+e::
Send , {BROWSER_FORWARD}
return
;-------------------【shift+y】运行-------------------------------
+y::
Send #{r}
return
;-------------------【shift+h】打开环境变量-------------------------------
+h::
Run control sysdm.cpl
return
;--------------------【shift+CapsLock】最小化---------------------------------
+CapsLock:: 
{
	If WinActive("ahk_class TFoxMainFrm.UnicodeClass") 
	or WinActive("ahk_class YodaoMainWndClass")
	or WinActive("ahk_class NeteaseYoudaoYNoteMainWnd")
	{
		WinClose, A	; "A" for current window.
		Return
	}

	WinMinimize, A
	Return
}





;--------------------------LEFT-------------------------
!h::
Run C:\Windows\System32\drivers\etc
return
!s::
Run C:\Users\hua\.ssh
return
!p::
Run C:\Users\hua\AppData\Roaming\Code\User\snippets
return
!e::
Run C:\Users\hua\AppData\Roaming\Code\User\settings.json
return

;--------------------------RIGHT-------------------------
!d::
Run G:\goproject\-
return

!t::
Run T:\goproject\-\public\static\images
return

!g::
Run G:\goproject
return

!r::
Run H:\
return

!q::
Run D:\
return





CapsLock & w:: Send {Pgup}
CapsLock & s:: Send {Pgdn}
CapsLock & a:: Send {home}
CapsLock & d:: Send {end}

CapsLock & i:: Send {up}
CapsLock & k:: Send {down}
CapsLock & j:: Send {left}
CapsLock & l:: Send {right}    


;---------------- 【CL+q】取色----------------------------------------------
CapsLock & q::
    MouseGetPos, mouseX, mouseY
    ; 获得鼠标所在坐标，把鼠标的 X 坐标赋值给变量 mouseX ，同理 mouseY
    PixelGetColor, color, %mouseX%, %mouseY%, RGB
    ; 调用 PixelGetColor 函数，获得鼠标所在坐标的 RGB 值，并赋值给 color
    StringRight color,color,6
    ; 截取 color（第二个 color）右边的6个字符，因为获得的值是这样的：#RRGGBB，一般我们只需要 RRGGBB 部分。把截取到的值再赋给 color（第一个 color）。
    clipboard = #%color%	;把 color 的值发送到剪贴板    
    ;msgbox 当前坐标RGB颜色值的十六进制值为#%color%.
return
;------------------【CL+y】扩展名显示隐藏-----------------------------
CapsLock & y::
If value = 0
value = 1
Else
value = 0
RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, HideFileExt, %Value%
send { AppsKey } e
return
;-------------【CL+h】打开回收站--------------------
CapsLock & h::
Run ::{645ff040-5081-101b-9f08-00aa002f954e}  
;-------------------【CL+c】创建文件--------------------------------
CapsLock & c::
send {AppsKey}{w}{n}{down}{down}{down}{down}{down}{enter}
return
;--------------------【CL+e】资源管理器上一级------------------------
CapsLock & e::
Send !{Up} 
return

;-------------------【CL+z】7z解压--------------------------------
CapsLock & z::
send {AppsKey}{w}{7}{down}{down}{down}{enter}
return
;-------------------【CL+r】小任务栏--------------------------------
CapsLock & r::
send #{b}{enter}
return

;-------------------【CL+t】打开磁盘管理--------------------------------
CapsLock & t::
run,diskmgmt.msc
Return
;------------------【CL+b】选中百度搜索-----------------------------
CapsLock & b::
    Send ^c
    sleep,100
    run https://www.baidu.com/s?wd=%clipboard%
return
;---------------【CL+n】显示隐藏文件:如.git--------------------------------
CapsLock & n::
If value = 1
value = 2
Else
value = 1
RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, Hidden, %Value%
send { AppsKey } e
return
;-------------------【CL+tab】enter--------------------------------
CapsLock & tab::
send {enter}
return
;---------------【CL+F】打开选中路径------------------------
CapsLock & f::
send ^c 
clipwait 
Clipboard := Trim(clipboard,A_Space) 
Run  %clipboard%
return
;-------------------【CL+v】vscode启动或唤醒-------------------
CapsLock & v:: 
Send #{1}
return
;-------------------【CL+g】谷歌启动或唤醒-------------------
CapsLock & g:: 
Send #{2}
return
;-------------------【shift+k】打开注册表---------------------------------
CapsLock & p::
run,regedit.exe
Return
;------------------------空格键---------------------------      
;enter::space
;        return
;space & enter::  
;send {enter}
;Return   

space::
send {space}
return      
  

tab::
send {tab}
return      

;!tab::
;send !{tab}
;return      	


;-------------------【空格+v】vscode启动或唤醒-------------------
space & v:: 
Send #{1}
return 
;-------------------------【空格+e】Edge浏览器-------------------------      
space & F3::
Run, explorer.exe shell:Appsfolder\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge ;打开edge浏览器
return
;-------------------【空格】VsCode映射--------------------------------
;-------------------【空格 +CL】映射ctrl   /---------------------------------
#if WinActive("ahk_exe Code.exe")


space & CapsLock::
send ^{/}
return
;-------------------【空格 +[1-8]】映射alt + [1-8]---------------------------------
space & 1::send !{1}
space & 2::send !{2}
space & 3::send !{3}
space & 4::send !{4}
space & 5::send !{5}
space & 6::send !{6}
space & 7::send !{7}
space & 8::send !{8}

;-------------------【空格 + shift】活动栏切换---------------------------------
space & shift::send !{v}{down}{down}{enter}{down}

;-------------------【空格 + a】选中一行---------------------------------
space & a::
Send {Home}
Send +{End}
return
;-------------------【空格+h】行尾行首切换---------------------------------
space & h::
Switch := ((Switch = 1) ? 0 : 1)
If Switch{
  	Send {Home}
  	return
}Else{
   	Send {End}
  	return
}


;-------------------【alt】VsCode映射--------------------------------

;-------------------【alt +tab】映射ctrl  + b---------------------------------
!tab::send ^{b}

;-------------------【alt+F1】映射shift+alt+i--------------------------------
!F1::
send +!{i}
DllCall("SendMessage" , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,WinExist("A")), UInt, 0x0283   ,  Int, 0x002  ,  Int, 0x00) 
send \n
return
;-------------------【alt+F2】输出\n--------------------------------
; !F2::
; 	DllCall("SendMessage" , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,WinExist("A")), UInt, 0x0283   ,  Int, 0x002  ,  Int, 0x00) 
; 	send \n
; 	return
;-------------------【alt+F3】映射_ctrl+shift+a---------------------------------
!F2::send ^+{a}




;-------------------【tab】VsCode映射--------------------------------
;-------------------【空格+t】映射ctrl+h---------------------------------
space & u::send ^{h}

;-------------------【空格+z】映射shift+alt+r---------------------------------
space & z::send +!{r}

;-------------------【tab+F4】映射delete---------------------------------
tab & F4::send {delete}

;-------------------【空格+j】打开文件夹---------------------------------
space & j::send !{f}{down}{down}{down}{down}{enter}

;-------------------【tab+2】打开最近的文件---------------------------------
tab & 2::send !{f}{down}{down}{down}{down}{down}{down}{enter}
return
;-------------------【空格+x】新建窗口---------------------------------
space & x::send ^+{n}

;-------------------【空格+s】搜索文件---------------------------------
space & s::send ^{p}


;-------------------【空格+n】创建文件---------------------------------
space & n::
    mouseclick, right
	send,{down}{down}{enter}
	return
;-------------------【空格+m】创建文件夹---------------------------------
space & m::
    mouseclick, right
	send,{down}{down}{down}{enter}
	return
#if
		


;-------------------ctrl键映射--------------------------------    

space & s::send ^s
space & x::send ^x	
;space & c::send ^c
;-------------------【空格+d】关闭标签---------------------------------
space & d::send ^{w}
;-------------------【空格+c】唤醒任务栏---------------------------------
space & c::WinActivate ahk_class Shell_TrayWnd
return

;-------------------------【空格+,】【空格+.】加减音量-------------------------
space & ,::
WinActivate ahk_class Shell_TrayWnd
Send {Volume_Up 1}
return

space & .::
WinActivate ahk_class Shell_TrayWnd
Send {Volume_Down 3}
return

;-------------------FFFFFFFFF--------------------------------    

;-------------------【空格+F1】结束当前进程--------------------------------
space & F1::
WinGet, active_id, PID, A
run, taskkill /PID %active_id% /F,,Hide
return

;-------------------【空格+F2】禁用启用AHK--------------------------------
space & F2::Suspend ; Win + scrollLock
return
;-------------------【空格+F4】删除目录文件--------------------------------
space & F4::Send {delete}
return
;-------------------【空格+esc】关机--------------------------------
space & esc::
Shutdown, 1 
return

;-------------------【空格+F5】静音-------------------
space & F5::
Send , {VOLUME_MUTE}
return

;-------------------【空格 +F6】锁屏+暗屏---------------------------------
space & F6::
{
Sleep, 200
DllCall("LockWorkStation")
Sleep, 200
SendMessage,0x112,0xF170,2,,Program Manager
}
return
;-------------------【空格+F8】锁定英文小写--------------------------------
space & F8::
	SetCapsLockState,off
	switchime(0)
return

switchime(ime := "A")
{
    if (ime = 1){
        DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,"00000804", UInt, 1))
    }else if (ime = 0)
    {
        DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
    }else if (ime = "A")
    {
        ;ime_status:=DllCall("GetKeyboardLayout","int",0,UInt)
        Send, #{Space}
    }
}
;-------------------【空格+F9】重启--------------------------------
space & F9::
Shutdown, 2 
return
;-------------------网站--------------------------------
space & 1:: Run www.baidu.com
space & 2:: Run https://search.bilibili.com/?from_source=web_search
space & 3:: Run https://translate.google.cn/
space & 4:: Run https://github.com/ 
space & 5:: Run https://www.aliyun.com/ 
space & 6:: Run https://www.iconfont.cn/
space & 7:: Run https://mail.qq.com/ 
space & 8:: Run http://localhost:8080/
space & 9:: Run http://99cc.vip/public/tools/vscode_snippet/index.html
space & 0:: Run http://localhost/index.php/go/go?id=1

;-------------------php web-------------------------------


#1:: run http://localhost/index.php/web/web.html?id=1
#2:: run http://localhost:88/index.php/admin/login/index.html
return
;-------------------程序--------------------------------
;-------------------标签左--------------------------------
space & q::

	Send,^{PgUp}
return
;-------------------标签右--------------------------------

space & e::

	Send,^{PgDn}
return
;-------------------顶部--------------------------------
space & t::
	Send,^{home}
Return
;-------------------底部--------------------------------
space & b::
	Send,^{end}
Return
;-------------------复制文件名--------------------------------
space & o::
	send {F2}
	send ^{c}
	send {esc}
Return
;-------------------【空格+w】微信启动或唤醒窗口--------------------------------
space & w::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run H:\微信\WeChat\WeChat.exe
} return 
;-------------------【空格+g】谷歌启动或唤醒-------------------
space & g:: 
Send #{2}
return

;--------------------【空格+delete】启动卸载---------------------------------
space & delete::
Run H:\卸载工具\geek.exe
return





;-------------------【空格+tab】删除键--------------------------------
space & tab::	
send  {Backspace}
return      


;-------------------必要--------------------------------

;-------------------【alt+j】上一首---------------------------------
;space & j:: 
;Send , {Media_Prev}
;return
;-------------------【alt+k】播放暂停---------------------------------

space & k::
Send , {Media_Play_Pause}
return
;-------------------【alt+l】换一首---------------------------------
space & l:: 
Send , {Media_Next}
return
;-------------------【空格+0】Snipaste--------------------------------
space & Numpad0::
NumpadEnter & Numpad0::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run H:\截图\Snipaste-2.6.6-Beta-x64\Snipaste.exe
} return

;-------------------【空格+1】快速下载--------------------------------
space & Numpad1::
NumpadEnter & Numpad1::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run C:\Program Files (x86)\Internet Download Manager\IDMan.exe
} return   

;-------------------【空格+2】百度网盘或唤醒窗口--------------------------------
space & Numpad2::
NumpadEnter & Numpad2::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run H:\百度网盘\BaiduNetdisk\baidunetdisk.exe
} return

;-------------------【空格+3】phpstudy--------------------------------
space & Numpad3::
NumpadEnter & Numpad3::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run H:\phpStudy\phpStudy_64\phpstudy_pro\COM\phpstudy_pro.exe
} return 

;-------------------【空格+4】强制删除--------------------------------
space & Numpad4::
NumpadEnter & Numpad4::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run H:\强制删除\IObit Unlocker\IObitUnlocker.exe
} return    
;-----------------【空格+5】启动cmd或关闭------------------------------------------------
space & Numpad5::
NumpadEnter & Numpad5::
if (onoff := !onoff)
Run %UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk
else
winclose Windows PowerShell
Return 

;-----------------【空格+6】启动utools------------------------------------------------
space & Numpad6::
NumpadEnter & Numpad6::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run C:\Users\hua\AppData\Local\Programs\utools\uTools.exe
} return

;-------------------【空格+7】navicat--------------------------------
space & Numpad7::
NumpadEnter & Numpad7::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run H:\Navicat for MySQL\navicat.exe
} return  

;-------------------【空格+8】docker--------------------------------
space & Numpad8::
NumpadEnter & Numpad8::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run C:\Program Files\Docker\Docker\Docker Desktop.exe
} return

;-------------------【空格+9】xshell--------------------------------
space & Numpad9::
NumpadEnter & Numpad9::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run H:\xshell\Xshell.exe
} return

;-------------------【空格++】启动酷狗或唤醒窗口--------------------------------
space & NumpadAdd::
NumpadEnter & NumpadAdd::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run H:\酷狗\KGMusic\KuGou.exe
} return
;-------------------【空格+-】PotPlayer--------------------------------
space & NumpadSub::
NumpadEnter & NumpadSub::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run H:\视频播放\PotPlayer\PotPlayerMini.exe
} return
;-------------------【空格+*】Everything--------------------------------
space & NumpadMult::
NumpadEnter & NumpadMult::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run H:\win10快速搜索\Everything\Everything.exe
} return
;-------------------【空格+/】有道云笔记--------------------------------
space & NumpadDiv::
NumpadEnter & NumpadDiv::
Process, Exist, hh.exe
if ErrorLevel {
	WinActivate, ahk_class HH Parent
} else {	
	Run H:\有道云\ynote-desktop\有道云笔记Beta版.exe
} return

    


;-------------------【谷歌键映射】--------------------------------
#if WinActive("ahk_exe chrome.exe")
!tab::send ^+{tab} 
space & CapsLock::send ^{h} 
space & shift:: Run C:\Users\hua\Downloads
space & +::send ^{d}
space & `::send {i}{f}
space & ctrl::send ^+{o}

;-------------------【空格+a】光标移到地址栏末尾--------------------------------
space & a::
send {F6}{right}
return


;-------------------【空格+x】关闭标签--------------------------------
CapsLock & x::
send ^w
return

	

;------------------------鼠标放任务栏滚动加减音量--------------------------
#If MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::Send {Volume_Up}
WheelDown::Send {Volume_Down}
 
MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}


















