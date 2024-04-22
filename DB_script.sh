#!/bin/bash/

userid=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d '.' -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
Red="\e[31m"
Green="\e[32m"
Yellow="\e[33m"
Nor="\e[0m"
echo "please enter DB password:"
read -s "DB_password"

if [ $userid != 0 ]
then
    echo "please run package with super user access: failure"
    exit 1
else
    echo -e "you are super user: $Green SUCCESS $Nor"
fi

Validate(){
   if [ $1 != 0 ]
   then
        echo -e "$2...$Red FAILURE $Nor"
        exit 1
    else
        echo -e "$2...$Green SUCCESS $Nor"
    fi
}

dnf install mysql-server -y &>>$LOGFILE
Validate $? "Installing mysql server"

systemctl enable mysqld &>>$LOGFILE
Validate $? "enabling mysql"

systemctl start mysqld &>>$LOGFILE
Validate $? "starting mysql"

mysql -h 18.212.230.225 -uroot -p${DB_password} -e "show databases" &>>$LOGFILE
    if [ $? != 0 ]
    then
        mysql_secure_installation --set-root-pass ${DB_password} &>>$LOGFILE
        Validate $? "password is set for mysql: $Green SUCCESS $Nor"
    else       
        echo -e "password is already set for mysql DB $Yellow Skipping $Nor"    
    fi

    