pipeline {

    agent {
        node {
            label 'master'
        }
    }

    stages {
        
        stage('Cleanup Workspace') {
            steps {
                cleanWs()
                sh """
                echo "Cleaned Up Workspace For Project"
                """
            }
        }

        stage('Code Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/master']], 
                    userRemoteConfigs: [[url: 'https://github.com/felipej9805/proyectoGit.git']]
                ])
            }
        }

        stage(' Terraform init') {
            steps {
                sh """
                terraform init
                """
            }
        }

    }   
}