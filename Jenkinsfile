pipeline {
    agent any
    tools {
       terraform 'terraform'
    }
    stages {
        stage('Git checkout') {
           steps{
                git branch: 'main', credentialsId: 'local-exec', url: 'https://github.com/TheCountt/microservice-demo-app.git'
            }
        }


        stage('SonarQube Quality Gate') {
            when { branch pattern: "^main*|^isaac*", comparator: "REGEXP"}
                environment {
                    scannerHome = tool 'SonarQubeScanner'
                }
                steps {
                    withSonarQubeEnv(credentialsId: 'sonaqube-token', installationName: 'sonarqube') {
                        sh '${scannerHome}/bin/sonar-scanner -Dproject.settings=sonar-project.properties'
                }
                        timeout(time: 5, unit: 'MINUTES') {
                            waitForQualityGate abortPipeline: true
               }
            }
         }


        stage('terraform format check') {
            steps{
                sh 'terraform fmt'
            }
        }
        stage('Intitialize terraform') {
            steps{
                sh 'terraform init'
            }
        }
        // stage('terraform apply') {
        //     steps{
        //         sh 'terraform apply --auto-approve'
        //     }
        // }
    }

    
}