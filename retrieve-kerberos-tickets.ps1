# By Erik Grøtnes
# From https://learn.microsoft.com/en-us/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal%2Cregkey&WT.mc_id=AZ-MVP-5004159#configure-the-clients-to-retrieve-kerberos-tickets
# To make VMs use Kerberos tickets to reach FSLogix storage account.
reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters /v CloudKerberosTicketRetrievalEnabled /t REG_DWORD /d 1
