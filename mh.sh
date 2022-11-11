#!/bin/bash
#MagicHat
#Placeholder bash command script to quickly create http redirectors
#DOES NOT WORK CURRENTLY
module=""
region=""
c2_server=""
count=""

help() {
    echo "Usage:"
    echo " "
    echo "./mh.sh -m http-redirector -r us-east-2 -t 1.1.1.1 -c 2"
    echo " "
    echo "Commands:"
    echo "  -m <module>"
    echo "  -r <aws-region>"
    echo "  -t <target-c2-server>"
    echo "  -c <number of servers>"
    echo "  -h <displays this menu>"
    echo "  -d <delete everything>"
    echo "      Note: You must supply all the other options in addition when deleting nodes"
    echo "      IE: ./mh.sh -m http-redirector -r us-east-2 -t 1.1.1.1 -c 2 -d"
    echo " "
    echo "Current Modules:"
    echo "  - http-redirector"
    echo " "
    echo "First time use make sure and run \"terraform init\" in the install directory to initalize modules"
    echo "Make sure and put your key values in 'magichats.tfvars' or terraform will get real maddd"

}

while getopts ":hm:r:t:c:d" opt; do
    case ${opt} in
        h ) help; exit;;
        m ) module=$OPTARG;;
        r ) region=$OPTARG;;
        t ) c2_server=$OPTARG;;
        c ) count=$OPTARG;;
        d ) del=true;;
        \? ) echo "Invalid Option: -$OPTARG" >&2; exit 1;;
        : ) echo "Invalid Option: -$OPTARG requires an argument" >&2; exit 1;;
        esac
    done
    shift $((OPTIND -1))

if ! [[ -z $module && -z $region && -z $c2_server && -z $count ]]
then
    if [[ -z $del ]]
    then
        terraform apply --target=module.$module -var region=$region -var c2_server=$c2_server -var num_of_instances=$count -var-file=magichats.tfvars -auto-approve
    else
        terraform destroy --target=module.$module -var region=$region -var c2_server=$c2_server -var num_of_instances=$count -auto-approve
    fi
fi
