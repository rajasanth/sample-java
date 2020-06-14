node {
    stage ('Checkout scm') {
        checkout scm
    }
    stage ('Build') {
        def mvn_home = tool 'maven'
        sh "$mvn_home/bin/mvn clean install"
    }
    stage ('Publish') {
        docker.withRegistry('https://hub.docker.com', 'docker-credentials') {

        def customImage = docker.build("rajaguru948/hello-world:latest")

        /* Push the container to the custom Registry */
        customImage.push()
    }
        //sh 'docker build -t java-image .'
        //sh 'docker tag java-image rajaguru948/hello-world:latest'
        //sh 'docker push rajaguru948/hello-world:latest'
    }
}
