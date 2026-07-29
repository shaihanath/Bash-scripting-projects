#!/bin/bash

######################################################
# Author : shaihanath
# Date   : 27-07-2026
#
# AWS Resource Tracker
######################################################

set -e

echo "        AWS RESOURCE TRACKER"

echo ""
echo " S3 Buckets "
aws s3 ls

echo ""
echo " EC2 Instances "
aws ec2 describe-instances \
    --query 'Reservations[].Instances[].[InstanceId,State.Name,InstanceType]' \
    --output table

echo ""
echo " Lambda Functions "
aws lambda list-functions \
    --query 'Functions[].FunctionName' \
    --output table

echo ""
echo " IAM Users "
aws iam list-users \
    --query 'Users[].UserName' \
    --output table

echo ""
echo " Report Generated Successfully "
