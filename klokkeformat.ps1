# Erik Grøtnes
# April 2026
# Set the clock to display in a Norwegian format.
reg add "HKCU\Control Panel\International" /v sShortDate /t REG_SZ /d "dd.MM.yyyy" /f
reg add "HKCU\Control Panel\International" /v sLongDate /t REG_SZ /d "dddd d. MMMM yyyy" /f
reg add "HKCU\Control Panel\International" /v sShortTime /t REG_SZ /d "HH:mm" /f
reg add "HKCU\Control Panel\International" /v sTimeFormat /t REG_SZ /d "HH:mm:ss" /f
reg add "HKCU\Control Panel\International" /v sDate /t REG_SZ /d "." /f
reg add "HKCU\Control Panel\International" /v sTime /t REG_SZ /d ":" /f
