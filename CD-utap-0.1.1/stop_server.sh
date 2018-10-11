#!/bin/bash
isExistApp=`pgrep httpd`
if [[ -n  $isExistApp ]]; then
    service httpd stop        
fi

# isExistApp=`pgrep tomcat8`
# if [[ -n  $isExistApp ]]; then
#     service tomcat8 stop        
# fi

/opt/tomcat/bin/shutdown.sh
