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

dnf install nginx -y &>>$LOGFILE
Validate $? "Installig nginx service"

systemctl enable nginx &>>$LOGFILE
Validate $? "enablig nginx service"

systemctl start nginx &>>$LOGFILE
Validate $? "starting nginx service"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
Validate $? "removing existing content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
Validate $? "downloading html code"

cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$LOGFILE
Validate $? "Extracting frontend code"

cp /home/ec2-user/expenses_project/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
Validate $? "copied frontend services"

systemctl restart nginx &>>$LOGFILE
Validate $? "Restarted nginx services"