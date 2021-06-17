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

        stage(' Terraform init') {
            steps {
                sh """
                terraform init
                """
            }
        }

        stage('Terraform plan') {
            steps {
                sh """
                terraform plan
                """
            }
        }

    }   
}