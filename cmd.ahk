#SingleInstance, Force
#NoEnv
#Include Z:\Maciek\testy\zmienne_hasla_na_Z.ahk

DetectHiddenWindows,On
SetTitleMatchMode,2
SetControlDelay,50
SetBatchLines,1
SetWinDelay,10


		;~ ****************************************************************
		;~ ************				stałe				*******************
		;~ ****************************************************************


	; WLASCICIELE------------------------------------------
ilosc_wlascicieli:=3
ilosc_wlasc:=ilosc_wlascicieli-1
	; KONIEC WLASCICIELE-----------------------------------

	; RATA ------------------------------------------------
bo_rok:=1
bo_rat:=2
bo_ratminus1:=bo_rat-1
bo_ratpozostala:=4-bo_rat
bo_kwota:="444,44"
bo_rata:="222,22"								; bo_rata:=bo_kwota/bo_rat		; czeka na zmianę kropki na przecinek .->,
	; KONIEC RATA -----------------------------------------

												; sprawdzać czy kwota podzielna, jesli nie - kwota niepodzielna
data_up:="20120817"
data_tw:="20120818"

pnier34:="34"
soe44:="44"
wnier46:="46"
	;~ dyski, UTF lub ANSI
dysko:="O:\ratusz60c.bat"						; luna i klienci (ee8mswin1250)
dysks:="O:\ratusz60cS.bat"						; test (utf8)
dyskw:="W:\ratusz60cW.bat"						; wysyłkowy (ee8mswin1250)

wysokosc_start:="722"

p:="{Right}"
d:="{Down}"
e:="{Enter}"


	; ********************
	; **** dane z gui ****
	; ********************
	
	;~ #dane podstawowe
datadekl:="2010-02-06"							; te daty będą w msgbox
datapowst:="2010-02-07"
nieruchomosc_grupa:=3
nieruchomosc_polozenie:=3

nieruchomosc_sposob:="11"
nieruchomosc_podstawa:="39,11"


		;~ ****************************************************************
		;~ ************				funkcje				*******************
		;~ ****************************************************************


	;~ *********************************
	;~ ***** alt, palt, dalt, ealt *****
	;~ *********************************

malt(r1,d1)
{
	SendInput,{Alt}
	SendInput,{Right %r1%}
	SendInput,{Down %d1%}
	SendInput,{Enter}
	Sleep,100
}
malt2(r1,d1,r2,d2)
{
	SendInput,{Alt}
	SendInput,{Right %r1%}
	SendInput,{Down %d1%}
	SendInput,{Right %r2%}
	SendInput,{Down %d2%}
	SendInput,{Enter}
	Sleep,100
}
tsalt(t)
{
	SendInput,{Tab %t%}
	SendInput,{Space}
	Sleep,100
}
	;~ do dokończenia, alt inteligentny, if var then use loop else return

	;~ *********************************
	;~ *******  koniec altów    ********
	;~ *********************************

przywroc(wysokosc)								; 722
{
	WinMove,,,-5,-5,1021,%wysokosc%
	Sleep,100
}
czuwaj(title,text,milisek)						; nazwa okna, słowo, zwłoka
{
	Sleep,200
	WinWait,%title%,%text%,60
	WinActivate,%title%,%text%
	Sleep,200
	Sleep,%milisek%
}
czuwaj_kom(title,text,milisek,czuw)				; nazwa okna, słowo, zwłoka, ile czuwa
{
	Sleep,200
	WinWait,%title%,%text%,%czuw%
	WinActivate,%title%,%text%
	Sleep,200
	Sleep,%milisek%
}
uruchomienie(title,text,dysk,wysokosc)			; dysk dla run
{
	Run,%dysk%
	Sleep,100
	czuwaj(title,text,50)
	przywroc(wysokosc)
	Sleep,100
}
przejscie(z_title,z_text,system,do_title,do_text)
{
	Sleep,300
	czuwaj(z_title,z_text,50)
	SendInput,{Tab}
	SendInput,%system%
	SendInput,{Enter 2}
	Sleep,300
	czuwaj(do_title,do_text,50)
}
danepodstawowe(ddekl,dpowst,gr,pol)
{
	SendInput,%ddekl%
	SendInput,{Tab}
	SendInput,%dpowst%
	SendInput,{Tab 3}
	SendInput,{Down %gr%}
	SendInput,{Enter 1}
	SendInput,{Tab 3}
	SendInput,{Down %pol%}
	SendInput,{Enter}
}
klik(przycisk,title,text)
{
	Sleep,300
	ControlClick,%przycisk%,%title%,%text%
	Sleep,100
}
kom(title,text,r1)
{
	czuwaj_kom(title,text,50,0)
	IfWinExist,%title%,%text%
	{
		czuwaj_kom(title,text,50,0)
		SendInput,{Right %r1%}
		SendInput,{Space}
		Sleep,200
	}
}
schowek1(zmienna)
{
	Clipboard=
	SendInput,{CtrlDown}c{CtrlUp}
	ClipWait,1
	Sleep,50
	%zmienna%:=Clipboard
	Sleep,100
}


		;~ ****************************************************************
		;~ *************              działanie             ***************
		;~ ****************************************************************


RAlt & 1::										; rejestracja, wybór z KOS
{
	uruchomienie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",dysks,wysokosc_start)
	przejscie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",pnier34,"PNIER - [Podatek od nieruchomości, leśny i rolny]","Podatek od nieruchomości, leśny i rolny")
		;~ F czy P, button1, button	2, button4
		;~ F
	malt("6","2")
	SendInput,{Down 3}{Enter 2}
	malt("1","1")
	czuwaj("PNIER","OTAGO Kartoteka nieruchomości PNIER - osoby fizyczne",50)
	SendInput,{F10}
	malt("0","0")
	czuwaj("PNIER","Nieruchomość - rejestracja",50)
	danepodstawowe(datadekl,datapowst,nieruchomosc_grupa,nieruchomosc_polozenie)
	czuwaj("PNIER","Nieruchomość - rejestracja",200)
	klik("ui60Viewcore_W32224","PNIER","Nieruchomość - rejestracja")
	czuwaj("Komunikat","Tak",50)
	SendInput,{Enter}
	czuwaj("PNIER","Wybór osoby fizycznej. Podsystem [ PNIER ]",50)
	SendInput,`%{Left}
}
return
RAlt & 2::										; dodanie nieruchomości, obliczenie wymiaru, dodanie do notatnika
{
	czuwaj("PNIER","<!>Nieruchomość - rejestracja",50)
	SendInput,{up %ilosc_wlasc%}
	tsalt("2")
	Loop,%ilosc_wlasc%
		{
			SendInput,{Down}
			SendInput,{Space}
			Sleep,50
		}
	SendInput,{up %ilosc_wlasc%}
	tsalt("6")
	SendInput,{CtrlDown}{Tab}{CtrlUp}
	czuwaj("PNIER","<!>Nieruchomość - rejestracja",50)
	SendInput,{Tab}
	czuwaj("ahk_class ui60Modal_W32","Anuluj",50)
	SendInput,{Down %nieruchomosc_sposob%}
	Sendinput,{Enter}
	czuwaj("PNIER","<!>Nieruchomość - rejestracja",50)
	SendInput,{Tab 2}
	SendInput,%nieruchomosc_podstawa%
		; Czy kolejne LEŚNY + ROLNY ?
	czuwaj("PNIER","<!>Nieruchomość - rejestracja",50)
	SendInput,{F4}
	kom("U W A G A","&Tak",1)
	kom("Istnieją nieruchomości dla tych samych właścicieli","&Nie",0)
	kom("Komunikat","&Tak",0)
	czuwaj("PNIER","OTAGO Kartoteka nieruchomości PNIER - osoby fizyczne",50)
	schowek1("kk_numer")
	malt(2,2)
	czuwaj("PNIER","PNIER Wymiar",50)
	SendInput,{F4}
		;~ zwrotki
	czuwaj("PNIER","OTAGO Kartoteka nieruchomości PNIER - osoby fizyczne",50)
	malt(5,0)
	czuwaj("PNIER","ZWROTKI",50)
	SendInput,{ShiftDown}{Tab}{ShiftUp}{ShiftDown}{End}{ShiftUp}{CtrlDown}c{CtrlUp}{Tab}{CtrlDown}v{CtrlUp}
	Loop,%ilosc_wlasc%
		{
			SendInput,{Down}
			SendInput,{ShiftDown}{Tab}{ShiftUp}{ShiftDown}{End}{ShiftUp}{CtrlDown}c{CtrlUp}{Tab}{CtrlDown}v{CtrlUp}
			Sleep,200
		}
	SendInput,{F4}
	Sleep, 200
		;~ ewakuacja - 4 poziomy ;)
	czuwaj_kom("PNIER","OTAGO Kartoteka nieruchomości PNIER - osoby fizyczne",200,2)
	SendInput,{F10}
	czuwaj("PNIER - [Podatek od nieruchomości, leśny i rolny]","Podatek od nieruchomości, leśny i rolny",50)
	SendInput,{F10}
	czuwaj("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",50)
	SendInput,{F10}
	czuwaj("Wywołana została funkcja wyjścia z systemu","Nie",50)
	SendInput,{Space}
	uruchomienie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ", dysks, wysokosc_start)
	przejscie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",wnier46,"Aplikacje Systemu OTAGO - [Windykacja podatku od nieruchomości i leśnego]","Windykacja podatku od nieruchomości i leśnego")
	malt(2,0)
	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	SendInput,{Tab}%kk_numer%{F8}
	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	Sleep,300
	SendInput,{Tab 2}{ShiftDown}{Tab}{ShiftUp}
	schowek1("kk_numer")
	SendInput,{PGDN}{Tab 4}{ShiftDown}{Tab}{ShiftUp}
	schowek1("imie1")
	SendInput,{ShiftDown}{Tab}{ShiftUp}
	schowek1("nazw1")
		; POBRANIE DANYCH i powielenie do notatnika
	if ilosc_wlascicieli=1
		{
			Run, notepad
			czuwaj("Bez tytułu - Notatnik","",50)
			WinMove,Bez tytułu - Notatnik,,955,742,280,180
			czuwaj("Bez tytułu - Notatnik","",50)
			SendInput,TEST`n%kk_numer%`n%nazw1% %imie1%
		}
	if ilosc_wlascicieli=2
		{
			SendInput,{Down}{Tab 2}{ShiftDown}{Tab}{ShiftUp}
			schowek1("imie2")
			SendInput,{ShiftDown}{Tab}{ShiftUp}
			schowek1("nazw2")
			Run, notepad
			czuwaj("Bez tytułu - Notatnik","",50)
			WinMove,Bez tytułu - Notatnik,,955,742,280,180
			czuwaj("Bez tytułu - Notatnik","",50)
			SendInput,TEST`n%kk_numer%`n%nazw1% %imie1%
			SendInput,`n%nazw2% %imie2%
		}
	if ilosc_wlascicieli=3
		{
			SendInput,{Down}{Tab 2}{ShiftDown}{Tab}{ShiftUp}
			schowek1("imie2")
			SendInput,{ShiftDown}{Tab}{ShiftUp}
			schowek1("nazw2")
			SendInput,{Down}{Tab 2}{ShiftDown}{Tab}{ShiftUp}
			schowek1("imie3")
			SendInput,{ShiftDown}{Tab}{ShiftUp}
			schowek1("nazw3")
			Run, notepad
			czuwaj("Bez tytułu - Notatnik","",50)
			WinMove,Bez tytułu - Notatnik,,955,742,280,180
			czuwaj("Bez tytułu - Notatnik","",50)
			SendInput,TEST`n%kk_numer%`n%nazw1% %imie1%
			SendInput,`n%nazw2% %imie2%
			SendInput,`n%nazw3% %imie3%
		}
	if ilosc_wlascicieli=4
		{
			SendInput,{Down}{Tab 2}{ShiftDown}{Tab}{ShiftUp}
			schowek1("imie2")
			SendInput,{ShiftDown}{Tab}{ShiftUp}
			schowek1("nazw2")
			SendInput,{Down}{Tab 2}{ShiftDown}{Tab}{ShiftUp}
			schowek1("imie3")
			SendInput,{ShiftDown}{Tab}{ShiftUp}
			schowek1("nazw3")
			SendInput,{Down}{Tab 2}{ShiftDown}{Tab}{ShiftUp}
			schowek1("imie4")
			SendInput,{ShiftDown}{Tab}{ShiftUp}
			schowek1("nazw4")
			Run, notepad
			czuwaj("Bez tytułu - Notatnik","",50)
			WinMove,Bez tytułu - Notatnik,,955,742,280,180
			czuwaj("Bez tytułu - Notatnik","",50)
			SendInput,TEST`n%kk_numer%`n%nazw1% %imie1%
			SendInput,`n%nazw2% %imie2%
			SendInput,`n%nazw3% %imie3%
			SendInput,`n%nazw4% %imie4%
		}
	if ilosc_wlascicieli=5
		{
			SendInput,{Down}{Tab 2}{ShiftDown}{Tab}{ShiftUp}
			schowek1("imie2")
			SendInput,{ShiftDown}{Tab}{ShiftUp}
			schowek1("nazw2")
			SendInput,{Down}{Tab 2}{ShiftDown}{Tab}{ShiftUp}
			schowek1("imie3")
			SendInput,{ShiftDown}{Tab}{ShiftUp}
			schowek1("nazw3")
			SendInput,{Down}{Tab 2}{ShiftDown}{Tab}{ShiftUp}
			schowek1("imie4")
			SendInput,{ShiftDown}{Tab}{ShiftUp}
			schowek1("nazw4")
			SendInput,{Down}{Tab 2}{ShiftDown}{Tab}{ShiftUp}
			schowek1("imie5")
			SendInput,{ShiftDown}{Tab}{ShiftUp}
			schowek1("nazw5")
			Run, notepad
			czuwaj("Bez tytułu - Notatnik","",50)
			WinMove,Bez tytułu - Notatnik,,955,742,280,180
			czuwaj("Bez tytułu - Notatnik","",50)
			SendInput,TEST`n%kk_numer%`n%nazw1% %imie1%
			SendInput,`n%nazw2% %imie2%
			SendInput,`n%nazw3% %imie3%
			SendInput,`n%nazw4% %imie4%
			SendInput,`n%nazw5% %imie5%
		}
	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	SendInput,{PGUP}{Tab}
}
return
RAlt & 3::										; uzupełnienie BO, UP, TW
{
		; uzupełnienie BO
	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	malt(5,1)
	SendInput,{Enter}
	czuwaj("Aplikacje Systemu OTAGO","Wprowadzanie zaległości sprzed roku instalacji systemu",50)
	SendInput,{Tab}{Down %bo_rok%}{Enter}%bo_kwota%{PGDN}
	sleep,500
	czuwaj("Aplikacje Systemu OTAGO","Wprowadzanie zaległości sprzed roku instalacji systemu",50)
	If (bo_rat<4)
		{
			SendInput,{Tab 6}%bo_rata%
			Loop,%bo_ratminus1%
				{
					SendInput,{Down}%bo_rata%
				}
			Loop,%bo_ratpozostala%
				{
					SendInput,{Down}0
				}
			SendInput,{F4}
		}
	else
		{
			SendInput,{F4}
		}
	Sleep,1000

		; upomnienie

	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	malt(7,1)
	czuwaj("Aplikacje Systemu OTAGO","Wystawianie upomnień",50)
	SendInput,%data_up%
		; zrobić kontrola up? raczej nie
	klik("Button26","Aplikacje Systemu OTAGO","Wystawianie upomnień")
	czuwaj("Aplikacje Systemu OTAGO","Współwłaściciele",50)
		;~ SendInput, {Space}{Tab}{Tab}{Tab}{Tab}{Space}	; zaznaczenie pojedynczej raty [v] z prawej
	SendInput,{F4}
	kom("UWAGA!","&Tak",1)
	czuwaj("Okno wydruków","Drukuj",100)
	SendInput,{Tab 3}{Space}
	Sleep,400
	czuwaj("Okno wydruków","Drukuj",100)
	SendInput,{Tab 3}{Space}
	Sleep,1000

		; Zwrotka upomnienia

	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	malt(5,4)
	czuwaj("Aplikacje Systemu OTAGO","Uzupełnianie pism",50)
	SendInput,{Down %ilosc_wlasc%}
	Loop,%ilosc_wlascicieli%
		{
			SendInput,{Down}
			SendInput,{ShiftDown}{Tab}{ShiftUp}{ShiftDown}{End}{ShiftUp}{CtrlDown}c{CtrlUp}{Tab}{CtrlDown}v{CtrlUp}
			Sleep,200
		}
	czuwaj("Aplikacje Systemu OTAGO","Uzupełnianie pism",50)
	SendInput,{F4}
	Sleep,1000
	
		; TW
	
	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	malt(7,3)
	czuwaj("Aplikacje Systemu OTAGO","Wystawianie tytułów wykonawczych",50)
		; zrobić kontrola TW
	SendInput,%data_tw%
	klik("Button22","Aplikacje Systemu OTAGO","Wystawianie tytułów wykonawczych")
	czuwaj("Aplikacje Systemu OTAGO","Wystawianie tytułów wykonawczych",50)
		; które raty zaznaczyć?
	SendInput,{F4}
	kom("Komunikat","&Tak",0)
		;~ SendInput, {Space}{Tab}{Tab}{Tab}{Tab}{Space}
	czuwaj("Okno wydruków","Drukuj",100)
	SendInput,{Tab 3}{Space}
	Sleep,500
}
return
RAlt & 4::										; przesłanie i pobranie do SOE i dodanie do notatnika info
{
	uruchomienie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ", dysks, wysokosc_start)
	przejscie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",wnier46,"Aplikacje Systemu OTAGO - [Windykacja podatku od nieruchomości i leśnego]","Windykacja podatku od nieruchomości i leśnego")
	Sleep,1000
	malt(4,20)
	czuwaj("Aplikacje Systemu OTAGO","Rejestr",50)
	SendInput,20120102{Tab}20131231{Tab 3}%kk_numer%{Tab}%kk_numer%{Tab	3}{ShiftDown}{Tab}{ShiftUp}{F8}
	czuwaj("Aplikacje Systemu OTAGO","Rejestr tytułów wykonawczych",50)
	SendInput,{Space 2}
	loop, %ilosc_wlasc%
		{
			SendInput,{Down 1}{Space}
		}
	malt(1,0)
	czuwaj("Komunikat","&Tak",50)
	SendInput,{Space}
	Sleep,500
	czuwaj("Aplikacje Systemu OTAGO","Rejestr tytułów wykonawczych",50)
	SendInput,{F10}
	czuwaj("Aplikacje Systemu OTAGO - [Windykacja podatku od nieruchomości i leśnego]","Windykacja podatku od nieruchomości i leśnego",50)
	SendInput,{F10}
	czuwaj("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",50)
	SendInput,{F10}
	czuwaj("Wywołana została funkcja wyjścia z systemu","Nie",50)
	SendInput,{Space}

		; wejście do SOE

	uruchomienie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ", dysks, wysokosc_start)
	przejscie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",soe44,"System obsługi Egzekucji SOE","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ")
	malt(1,10)
	czuwaj("System obsługi Egzekucji SOE","Pobieranie TW z WIND",50)
	SendInput,{F7}
	Sleep,200
	if ilosc_wlascicieli=1
		{
			SendInput,{Tab 3}%A_YYYY%%A_MM%%A_DD%{Tab 4}%nazw1%{Space}%imie1%
		}
		else
			{
				SendInput,{Tab 3}%A_YYYY%%A_MM%%A_DD%
			}
	Sleep,100
	SendInput,{F8}
	Sleep,100
	czuwaj("System obsługi Egzekucji SOE","Pobieranie TW z WIND",50)
	SendInput,{ShiftDown}{Tab}{ShiftUp}{Space}
	loop, %ilosc_wlasc%
		{
			SendInput,{Down 1}{Space}
		}
	malt(0,0)
	kom("Komunikat","&Tak",0)
	kom("Uwaga","&Nie",1)
	czuwaj("System obsługi Egzekucji SOE","Pobieranie TW z WIND",50)
	SendInput,{F10}
	Sleep,200
	czuwaj("System obsługi Egzekucji SOE","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",50)
	malt(0,0)
	czuwaj("System obsługi Egzekucji SOE","Kartoteka",50)
	SendInput,%nazw1%{Tab 2}%imie1%{F8}
	czuwaj("System obsługi Egzekucji SOE","Kartoteka",50)
	Sleep,300
	SendInput,{PGDN}{Tab 10}
	SendInput,{ShiftDown}{Tab}{ShiftUp}
	schowek1("odsetki1")
	SendInput,{ShiftDown}{Tab}{ShiftUp}
	schowek1("kwota1")
	SendInput,{ShiftDown}{Tab}{ShiftUp}
	schowek1("zob1")
	SendInput,{ShiftDown}{Tab 2}{ShiftUp}
	schowek1("datawyst1")
	SendInput,{ShiftDown}{Tab 5}{ShiftUp}
	schowek1("numerTW1")
	czuwaj("Bez tytułu - Notatnik","",50)
	SendInput,`n%numerTW1%`nz %datawyst1% na %zob1%
		;~ SendInput,`n%numerTW1%`nz %datawyst1% na %zob1%`nkwota:%kwota1%`nodsetki:%odsetki1%
	czuwaj("System obsługi Egzekucji SOE","Kartoteka",50)
	SendInput,{PGUP}
}
return
RAlt & 5::											; odpalenie z funkcje zbiorcze PNIER, ważne aby parametr ROMKA był ok
{
	czuwaj("PNIER","<!>Nieruchomość - rejestracja",50)
	SendInput,{up %ilosc_wlasc%}
	tsalt("2")
	Loop,%ilosc_wlasc%
		{
			SendInput,{Down}
			SendInput,{Space}
			Sleep,50
		}
	SendInput,{up %ilosc_wlasc%}
	tsalt("6")
	SendInput,{CtrlDown}{Tab}{CtrlUp}
	czuwaj("PNIER","<!>Nieruchomość - rejestracja",50)
	SendInput,{Tab}
	czuwaj("ahk_class ui60Modal_W32","Anuluj",50)
	SendInput,{Down %nieruchomosc_sposob%}
	Sendinput,{Enter}
	czuwaj("PNIER","<!>Nieruchomość - rejestracja",50)
	SendInput,{Tab 2}
	SendInput,%nieruchomosc_podstawa%
		; Czy kolejne LEŚNY + ROLNY ?
	czuwaj("PNIER","<!>Nieruchomość - rejestracja",50)
	SendInput,{F4}
	kom("U W A G A","&Tak",1)
	kom("Istnieją nieruchomości dla tych samych właścicieli","&Nie",0)
	kom("Komunikat","&Tak",0)
	czuwaj("PNIER","OTAGO Kartoteka nieruchomości PNIER - osoby fizyczne",50)
	schowek1("kk_numer")
		;~ ewakuacja - 4 poziomy ;)
	czuwaj_kom("PNIER","OTAGO Kartoteka nieruchomości PNIER - osoby fizyczne",200,2)
	SendInput,{F10}
	czuwaj("PNIER - [Podatek od nieruchomości, leśny i rolny]","Podatek od nieruchomości, leśny i rolny",50)
	SendInput,{F10}
	czuwaj("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",50)
	SendInput,{F10}
	czuwaj("Wywołana została funkcja wyjścia z systemu","Nie",50)
	SendInput,{Space}
	uruchomienie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",dysks,wysokosc_start)
	przejscie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",pnier34,"PNIER - [Podatek od nieruchomości, leśny i rolny]","Podatek od nieruchomości, leśny i rolny")
		;~ F czy P, button1, button2, button4
		;~ F
	Sleep,200
	malt("6","2")
	czuwaj("Zmiana bieżącego roku podatkowego","Anuluj",50)
	SendInput,{Down 3}{Enter 2}
	czuwaj("PNIER","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",50)
	Sleep,200
	malt("3","1")
	czuwaj("PNIER","PNIER Zbiorcze naliczenie wymiaru",50)
	Sleep,200
	SendInput,%kk_numer%{F8}
	Sleep,200
	malt("0","0")
	Sleep,200
	czuwaj("PNIER","PNIER Zbiorcze naliczenie wymiaru",50)
	SendInput,{F4}
	Sleep,500
	czuwaj("PNIER","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",50)
	Sleep,500
	malt2(4,1,1,1)
	czuwaj("PNIER","Zbiorczy wydruk decyzji wymiarowych",100)
	SendInput,%kk_numer%{Tab}%kk_numer%
	malt(1,0)
	Sleep,300
	czuwaj("Okno wydruków","Drukuj",100)
	SendInput,{Tab 3}{Space}
	Sleep,400
	czuwaj("Wybór zwrotki","Wybór zwrotki:",100)
	SendInput,{Enter}
	czuwaj("Okno wydruków","Drukuj",100)
	SendInput,{Tab 3}{Space}
	Sleep,1000
	kom("Okno wydruków","Drukuj",3)
	Sleep,1000
	kom("Komunikat","&Tak",0)
	kom("Komunikat","&Tak",0)
	kom("Komunikat","&Tak",0)
	kom("Okno wydruków","Drukuj",3)
	Sleep,1000
	SendInput,{F4}
	kom("Komunikat","&Tak",0)
	kom("Komunikat","&Tak",0)
	kom("Komunikat","&Tak",0)

		;~ ewakuacja - 2 poziomy;)

	czuwaj_kom("PNIER","Podatek od nieruchomości, leśny i rolny",200,2)
	SendInput,{F10}
	czuwaj("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",50)
	SendInput,{F10}
	czuwaj("Wywołana została funkcja wyjścia z systemu","Nie",50)
	SendInput,{Space}
	uruchomienie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ", dysks, wysokosc_start)
	przejscie("Aplikacje Systemu OTAGO - [OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ]","OTAGO@TEST Systemowy Uzytkownik Testowy  OTAGO   ",wnier46,"Aplikacje Systemu OTAGO - [Windykacja podatku od nieruchomości i leśnego]","Windykacja podatku od nieruchomości i leśnego")
	malt(2,0)
	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	SendInput,{Tab}%kk_numer%{F8}
	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	malt(5,4)
	czuwaj("Aplikacje Systemu OTAGO","Uzupełnianie pism",50)
	SendInput,{ShiftDown}{Tab}{ShiftUp}{ShiftDown}{End}{ShiftUp}{CtrlDown}c{CtrlUp}{Tab}{CtrlDown}v{CtrlUp}
	Loop,%ilosc_wlasc%
		{
			SendInput,{Down}
			SendInput,{ShiftDown}{Tab}{ShiftUp}{ShiftDown}{End}{ShiftUp}{CtrlDown}c{CtrlUp}{Tab}{CtrlDown}v{CtrlUp}
			Sleep,200
		}
	czuwaj("Aplikacje Systemu OTAGO","Uzupełnianie pism",50)
	SendInput,{F4}
	Sleep, 200

		; upomnienie

	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	malt(7,1)
	czuwaj("Aplikacje Systemu OTAGO","Wystawianie upomnień",50)
	SendInput,%data_up%
		; zrobić kontrola up? raczej nie
	klik("Button26","Aplikacje Systemu OTAGO","Wystawianie upomnień")
	czuwaj("Aplikacje Systemu OTAGO","Współwłaściciele",50)
		;~ SendInput, {Space}{Tab}{Tab}{Tab}{Tab}{Space}	; zaznaczenie pojedynczej raty [v] z prawej
	SendInput,{F4}
	kom("UWAGA!","&Tak",1)
	czuwaj("Okno wydruków","Drukuj",100)
	SendInput,{Tab 3}{Space}
	Sleep,400
	czuwaj("Okno wydruków","Drukuj",100)
	SendInput,{Tab 3}{Space}
	Sleep,1000

		; Zwrotka upomnienia

	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	malt(5,4)
	czuwaj("Aplikacje Systemu OTAGO","Uzupełnianie pism",50)
	SendInput,{ShiftDown}{Tab}{ShiftUp}{ShiftDown}{End}{ShiftUp}{CtrlDown}c{CtrlUp}{Tab}{CtrlDown}v{CtrlUp}
	Loop,%ilosc_wlasc%
		{
			SendInput,{Down}
			SendInput,{ShiftDown}{Tab}{ShiftUp}{ShiftDown}{End}{ShiftUp}{CtrlDown}c{CtrlUp}{Tab}{CtrlDown}v{CtrlUp}
			Sleep,200
		}
	czuwaj("Aplikacje Systemu OTAGO","Uzupełnianie pism",50)
	SendInput,{F4}
	Sleep,1000

		; TW

	czuwaj("Aplikacje Systemu OTAGO","Kartoteka nieruchomości WNIER - osoby fizyczne",50)
	malt(7,3)
	czuwaj("Aplikacje Systemu OTAGO","Wystawianie tytułów wykonawczych",50)
		; zrobić kontrola TW
	SendInput,%data_tw%
	klik("Button22","Aplikacje Systemu OTAGO","Wystawianie tytułów wykonawczych")
	czuwaj("Aplikacje Systemu OTAGO","Wystawianie tytułów wykonawczych",50)
		; które raty zaznaczyć?
	SendInput,{F4}
	czuwaj("Komunikat","Tak",100)
	SendInput,{Space}
		;~ SendInput, {Space}{Tab}{Tab}{Tab}{Tab}{Space}
	czuwaj("Okno wydruków","Drukuj",100)
	SendInput,{Tab 3}{Space}
	Sleep,500
}
return


		;~ Pnier1 wybór kolejnych właścicieli
	/* Czy 2 3 4 ?
	ControlClick, ui60Viewcore_W32241, ahk_class ui60MDIroot_W32	; ++++
	ControlClick, ui60Viewcore_W32223, ahk_class ui60MDIroot_W32	; kolejny W1
	ControlClick, ui60Viewcore_W32223, ahk_class ui60MDIroot_W32	; kolejny W2
	ControlClick, ui60Viewcore_W32222, ahk_class ui60MDIroot_W32	; kolejny W3
	ControlClick, ui60Viewcore_W32221, ahk_class ui60MDIroot_W32	; kolejny W4
	*/
		;~ Pnier3 wybór kolejnych właścicieli
	/*
	SetFormat, FloatFast, 0.6		; niepotrzebne, zamiast tego zamienić wynik matematyczny na "," string?
	*/


	;~ ****************************************************************
	;~ ************				próbka				*******************
	;~ ****************************************************************
/*

*/