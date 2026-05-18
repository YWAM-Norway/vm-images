########################
# Disable BitLocker    #
# By Erik Grøtnes      #
########################

# This will add a registry key to disable bitlocker. To be used when creating a new image.
reg add HKLM\SYSTEM\CurrentControlSet\Control\BitLocker /v PreventDeviceEncryption /t REG_DWORD /d 1 /f
