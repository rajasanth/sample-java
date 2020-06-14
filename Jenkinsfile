node {
    stage ('Checkout scm') {
        checkout scm
    }
    stage ('Build') {
        def mvn_home = tool 'maven'
        sh "$mvn_home/bin/mvn clean install"
    }
    stage ('Publish') {
        sh 'docker build -t java-image .'
        sh 'docker tag java-image rajaguru948/hello-world:latest'
        sh 'docker push rajaguru948/hello-world:latest'
    }
}
