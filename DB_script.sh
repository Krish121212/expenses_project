#!/bin/bash/

userid=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d '.' -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
Red="\e[31m"
Green="\e[32m"
Yellow="\e[33m"
Nor="\e[0m"

Validate(){
if [ $userid != 0 ]
then
    echo "please run package with super user access: failure"
    exit 1
else
    echo -e "you are super user: $Green SUCCESS $Nor"
fi
}

dnf install mysql -y &>>$LOGFILE
Validate $? echo -e "Installing mysql: $Green SUCCESS $Nor"

systemctl enable mysqld &>>$LOGFILE
Validate $? echo -e "enabling mysql: $Green SUCCESS $Nor"

systemctl start mysqld &>>$LOGFILE
Validate $? echo -e "starting mysql: $Green SUCCESS $Nor"

mysql_secure_installation --set-root-pass Krish@1212 &>>$LOGFILE
Validate $? echo -e "starting mysql: $Green SUCCESS $Nor"

