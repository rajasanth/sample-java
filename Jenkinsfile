node {
    def mvn_home = tool 'maven'
    stage ('Checkout scm') {
        checkout scm
    }
    try {
    stage ('Build') {
        sh "$mvn_home/bin/mvn clean install"
    }
    } finally {
        println "Publishing Jmeter results"
        step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/*.xml'])
    }
    stage ('Enable Sonar') {
		withSonarQubeEnv(installationName: "sonar-check") {
			sh "$mvn_home/bin/mvn sonar:sonar"
		}
	}
    stage ('owasp') {
	    dependencyCheck additionalArguments: '', odcInstallation: 'owasp'
	    dependencyCheckPublisher pattern: ''
	}
    stage ('Publish') {
        docker.withRegistry('', 'docker-credentials') {

        def customImage = docker.build("rajaguru948/hello-world:latest")

        /* Push the container to the custom Registry */
        customImage.push()
     }
    }
    stage ('Deploy') {
        sh 'chmod +x deployscript.sh'
        sh './deployscript.sh'
       // sh '''aws ecs update-service --cluster aws-fargate-raja-test --service hello-world-demo --force-new-deployment --region us-east-1'''
    }
}
