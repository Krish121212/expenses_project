#!/bin/bash/

userid=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d '.' -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
Red="\e[31m"
Green="\e[32m"
Yellow="\e[33m"
Nor="\e[0m"

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

dnf module disable nodejs -y &>>$LOGFILE
Validate $? "diabling deafult nodejs version"

dnf module enable nodejs:20 -y &>>$LOGFILE
Validate $? "enabling nodejs new version "

dnf install nodejs -y &>>$LOGFILE
Validate $? "installing nodejs"

id expense
    if [ $? != 0 ]
    then
        useradd expense
        Validate $? "creating expense user"
    else
        echo "Expense usr already created $Yellow Skipping $Nor"
    fi
    


