#!/bin/bash
previoustaskArn=$(aws ecs list-tasks --cluster aws-fargate-raja-test --service-name hello-world-demo |  jq -r '.taskArns[]')
previousprivateIp=$(aws ecs describe-tasks --tasks "$previoustaskArn" --region us-east-1 --cluster aws-fargate-raja-test | jq -r '.tasks[].attachments[].details[] | select(.name|test("privateIPv4Address")) | .value')
aws elbv2 deregister-targets --target-group-arn arn:aws:elasticloadbalancing:us-east-1:516968514419:targetgroup/test/ab3b2b4c14153f34 --targets Id="$previousprivateIp"
aws ecs update-service --cluster aws-fargate-raja-test --service hello-world-demo --force-new-deployment --region us-east-1
taskArn=$(aws ecs list-tasks --cluster aws-fargate-raja-test --service-name hello-world-demo |  jq -r '.taskArns[]')
privateIp=$(aws ecs describe-tasks --tasks "$taskArn" --region us-east-1 --cluster aws-fargate-raja-test | jq -r '.tasks[].attachments[].details[] | select(.name|test("privateIPv4Address")) | .value')
aws elbv2 register-targets --target-group-arn arn:aws:elasticloadbalancing:us-east-1:516968514419:targetgroup/test/ab3b2b4c14153f34 --targets Id="$privateIp"
