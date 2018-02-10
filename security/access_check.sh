#!/bin/sh

function echo_01(){
        echo "$1"
}
#Invalid user Access
echo_01 "*** Invalid Number ***"
grep -c invalid /var/log/secure*
#SSH Login Failed
echo_01 "*** Failed Number ***"
grep -c Failded /var/log/secure*
#SSH Login Accepted
echo_01 "*** Accepted Number ***"
grep -c Accepted /var/log/secure*
echo_01 "*** Logined User List ***"
last | head -5
