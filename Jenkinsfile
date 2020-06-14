node {
    stage ('Checkout scm') {
        checkout scm
    }
    try {
    stage ('Build') {
        def mvn_home = tool 'maven'
        sh "$mvn_home/bin/mvn clean install"
    }
    } finally {
        println "Publishing Jmeter results"
        step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/*.xml'])
    }
    stage ('Publish') {
        docker.withRegistry('', 'docker-credentials') {

        def customImage = docker.build("rajaguru948/hello-world:latest")

        /* Push the container to the custom Registry */
        customImage.push()
     }
    }
    stage ('Deploy') {
        sh '''aws ecs update-service --cluster aws-fargate-raja-test --service hello-world-demo --force-new-deployment --region us-east-1'''
    }
}
