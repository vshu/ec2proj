#!/bin/bash

REGION='us-west-1'

#ec2-run-instances --region $REGION -t t1.micro -g bootcamp ami-acf9cde9 -k Ubuntu1 -f /home/vs/userdata;
INST_ID=$(ec2-run-instances --region $REGION -t t1.micro -g bootcamp ami-acf9cde9 -k Ubuntu1 \
| grep INSTANCE | cut -s -f2)
echo $INST_ID
sleep 60
PUBLIC_IP=$(ec2-describe-instances $INST_ID | grep INSTANCE | cut -s -f4)
echo $PUBLIC_IP
scp -i /home/vs/Ubuntu1.pem setup.sh ubuntu@${PUBLIC_IP}:~/
scp -i /home/vs/Ubuntu1.pem site.pp ubuntu@${PUBLIC_IP}:/etc/puppet/manifests/
ssh -i /home/vs/Ubuntu1.pem ubuntu@$PUBLIC_IP "/bin/bash ~/setup.sh"
sleep 90
AMI_ID=$(ec2-create-image $INST_ID -n test-ami | cut -s -f2)
ec2-copy-image --region us-west-2 -r $REGION -s $AMI_ID
ec2-terminate-instances $INST_ID
sleep 90
ec2-run-instances --region $REGION -t t1.micro -g bootcamp -k Ubuntu1 $AMI_ID

