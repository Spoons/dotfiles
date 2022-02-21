#!/usr/bin/env zsh
alias zla='zfs list -t all | grep -v "zroot/var/lib/docker/"'
alias zlk='sudo zfs load-key -a'
alias zlks='sudo zfs get -p keystatus'
alias zl='zfs list -o name,available,used,usedbychildren,usedbysnapshots,usedbydataset -H | grep -v "zroot/var/lib/docker/" | column -t -N name,available,used,children,snapshots,dataset'
alias zma='sudo zfs mount -a'
