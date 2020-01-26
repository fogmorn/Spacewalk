# spacewalk
## DESCRIPTION
CEFS - CentOS Errata for Spacewalk.  
**cefs** folder contains script - **errata-import.pl** that used for importing CentOS errata into Spacewalk.  
Project site: https://cefs.steve-meier.de/


Custom script **errata-update.pl** is used for loading errata files from Internet and execution of **errata-import.pl**.

## INSTALLATION
Put **cefs** folder into `/root` on spacewalk server and make scripts executable.  
Set cron job:
```
0 7 * * * /usr/bin/perl /root/cefs/errata-update.pl > /root/cefs/errata-update.log 2>&1
```
