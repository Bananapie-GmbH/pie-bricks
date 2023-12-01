#!/bin/bash
# make the script fail when something fails
set -o errexit

username="root"
password="12345678"
hostname="localhost"
port="3306"

while getopts u:P:d:h:p:n: OPT
do
    case $OPT in
        "u" ) username="$OPTARG" ;;
        "P" ) password="-p $OPTARG" ;;
        "h" ) hostname="$OPTARG" ;;
        "p" ) port="-P $OPTARG" ;;
        "d" ) database="$OPTARG" ;;
        "n" ) number="$OPTARG" ;;
    esac
done

if [ -z "${database}" ]; then
    echo "ERROR: database is not specified"
    echo "$0 -d database"
    exit 1
fi

cd $(dirname $0)

touch ~/.my.cnf
echo -e "[client]\nuser=${username}\npassword=${password}\nhost=${hostname}" > ~/.my.cnf
chmod 0600 ~/.my.cnf

if [ -z "${number}" ]; then
    for migration_file in *.sql
    do
        echo "Running ${migration_file} on ${database}..."
        mysql -h ${hostname} -U ${username} -w ${database} -f ${migration_file}
    done
else
    prefix=`echo ${number} | awk '{printf("%04d", $1)}'`
    mysql -h ${hostname} -U ${username} -w ${database} -f ${prefix}_*.sql
fi
