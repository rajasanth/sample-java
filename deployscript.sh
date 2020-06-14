#!/bin/bash
aws ecs update-service --cluster aws-fargate-raja-test --service hello-world-demo --force-new-deployment --region us-east-1
taskArn=$(aws ecs list-tasks --cluster aws-fargate-raja-test --service-name hello-world-demo |  jq -r '.taskArns[]')
aws ecs describe-tasks --tasks '$taskArn' --region us-east-1 --cluster aws-fargate-raja-test | jq -r '.tasks[].attachments[].details[] | select(.name|test("privateIPv4Address")) | .value'
