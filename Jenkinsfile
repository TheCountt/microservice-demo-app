/* groovylint-disable GStringExpressionWithinString, NestedBlockDepth */
pipeline {
    agent any
    tools {
        terraform 'terraform'
    }

    options {
        timestamps()
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '10', numToKeepStr: '4')
    }

    parameters {
        string(name: 'variables', defaultValue: 'terraform.auto.tfvars', description: 'variables file to use for deployment')
        // booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', credentialsId: 'local-exec', url: 'https://github.com/TheCountt/microservice-demo-app.git'
            }
        }

        // stage('SonarQube Quality Gate') {
        //     when { branch pattern: '^main*|^isaac*', comparator: 'REGEXP' }
        //         environment {
        //             scannerHome = tool 'SonarQubeScanner'
        //         }
        //         steps {
        //             withSonarQubeEnv(credentialsId: 'sonaqube-token', installationName: 'sonarqube') {
        //                 sh '${scannerHome}/bin/sonar-scanner -Dproject.settings=sonar-project.properties'
        //             }
        //                 timeout(time: 3, unit: 'MINUTES') {
        //                     waitForQualityGate abortPipeline: true
        //                 }
        //         }
        // }

        // stage('Terraform init & Dry Run') {
        //     steps {
        //         script {
        //             currentBuild.displayName = params.version
        //         }
        //             sh 'terraform init'
        //             sh "terraform plan -out tfplan --var-file=${params.variables}"
        //             sh 'terraform show -no-color tfplan > tfplan.txt'
        //     }
        // }

        // stage('Approval') {
        //     when {
        //         not {
        //             equals expected: true, actual: params.autoApprove
        //         }
        //     }

        //     steps {
        //         script {
        //             def plan = readFile 'tfplan.txt'
        //             input message: 'Do you want to apply the plan?',
        //                 parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
        //         }
        //     }
        // }

        stage('Apply') {
            steps {
                // sh 'terraform apply -input=false tfplan'
                sh 'terraform init'
                sh "terraform plan --var-file=${params.variables}"
                sh 'terraform apply -auto-approve'
            }
        }

        // stage('Post') {
        //     steps {
        //         post {
        //             always {
        //                 archiveArtifacts artifacts: 'tfplan.txt'
        //             }
        //         }
        //     }
        // }

        stage('Destroy') {
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}
