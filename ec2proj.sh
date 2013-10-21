#!/bin/bash

REGION='us-west-1'

INST_ID=$(ec2-run-instances --region $REGION -t t1.micro -g bootcamp ami-acf9cde9 -k Ubuntu1 -f /home/vs/newuserdata | grep INSTANCE | cut -s -f2)
#ec2-run-instances --region $REGION -t t1.micro -g bootcamp ami-acf9cde9 -k Ubuntu1
sleep 120
#INST_ID=$(ec2-describe-instances $INST_ID | grep INSTANCE | cut -s -f2)
PUBLIC_IP=$(ec2-describe-instances $INST_ID | grep INSTANCE | cut -s -f4)
echo "INST_ID=" $INST_ID
echo "PUBLIC IP=" $PUBLIC_IP
exit
#scp -i /home/vs/Ubuntu1.pem site.pp ubuntu@${PUBLIC_IP}:/etc/puppet/manifests
AMI_ID=$(ec2-create-image $INST_ID -n master-ami | cut -s -f2)
sleep 60
#ec2-copy-image --region us-west-2 -r $REGION -s $AMI_ID
ec2-terminate-instances $INST_ID
sleep 120
ec2-run-instances --region $REGION -t t1.micro -g bootcamp -k Ubuntu1 $AMI_ID

