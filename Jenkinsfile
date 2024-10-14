pipeline {
    agent any;
    stages {
        stage ('build') {
            steps {
                sh '''
                aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 010438494499.dkr.ecr.us-east-1.amazonaws.com
                docker build -t sample_docker .
                docker tag sample_docker:latest 010438494499.dkr.ecr.us-east-1.amazonaws.com/sample_docker:${BUILD_NUMBER}
                docker push 010438494499.dkr.ecr.us-east-1.amazonaws.com/sample_docker:${BUILD_NUMBER}
                '''

            }
        }

     
        stage ('deploy') {

             steps {
                 sh ...
                 ssh -i /var/lib/jenkins/naz.pem -o StrictHostKeyChecking=no ubuntu@ec2-54-86-21-160.compute-1.amazonaws.com 'bash -s' < ./deploy.sh \${BUILD_NUMBER}
                 '''

             }

         }
    }
}
