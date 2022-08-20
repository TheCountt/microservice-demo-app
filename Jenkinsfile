pipeline {
    agent any
    tools {
       terraform 'terraform'
    }

      options {
  timestamps ()
  buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '10', numToKeepStr: '4')
  }
  
   parameters {
        string(name: 'variables.tf', defaultValue: 'terraform.tfvars', description: 'variables file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }
    
    environment {
        ACCESS_KEY_ID     = credentials('ACCESS_KEY_ID')
        SECRET_ACCESS_KEY = credentials('SECRET_ACCESS_KEY')
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


        stage('Plan') {
            steps {
                script {
                    currentBuild.displayName = params.version
                }
                    sh 'terraform init'
                    sh "terraform plan -out tfplan --var-file=${params.variables}"
                    sh "terraform show -no-color tfplan > tfplan.txt"
            }
        }


        // stage('Approval') {
        //     when {
        //         not {
        //             equals expected: true, actual: params.autoApprove
        //         }
        //     }

        //     steps {
        //         script {
        //             def plan = readFile 'tfplan.txt'
        //             input message: "Do you want to apply the plan?",
        //                 parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
        //         }
        //     }
        // }

    }    

}