def exists_file =  false

def myVariable = "foo"
def myVariable = "foo"
def myVariable = "foo"
def myVariable = "foo"
def myVariable = "foo"



pipeline {

    agent {
        node {
            label 'master'
        }
    }

    stages {
        stage("SETTING ENV VARIABLES") {
            steps {
                sh "printenv"

            }
        }
		
        stage("COMMIT") {
            steps {
		        script {
					env.GIT_COMMIT_MSG = sh (script: 'git log -1 --pretty=%B ${GIT_COMMIT}', returnStdout: true).trim()
				}
            }
        }
		

		
        stage("Env Variables") {
            steps {
			    echo "0 GIT_COMMIT_MSG -- ${env.GIT_COMMIT_MSG}"
                echo "1 GIT_AUTHOR_EMAIL -- ${env.GIT_AUTHOR_EMAIL}"
                echo "2 GIT_COMMITTER_EMAIL -- ${env.GIT_COMMITTER_EMAIL}"
                echo "3  GIT_AUTHOR_NAME -- ${env.GIT_AUTHOR_NAME}"
                echo "4  GIT_CHECKOUT_DIR -- ${env.GIT_CHECKOUT_DIR}"
                echo "5 GIT_LOCAL_BRANCH -- ${env.GIT_LOCAL_BRANCH}"
                echo "6  GIT_BRANCH -- ${env.GIT_BRANCH}"
                echo "7  GIT_COMMIT -- ${env.GIT_COMMIT}"
                echo "---------------------------------------------------"
                echo "8 BRANCH_NAME -- ${env.BRANCH_NAME}"
                echo "9 CHANGE_AUTHOR_DISPLAY_NAME -- ${env.CHANGE_AUTHOR_DISPLAY_NAME}"
                echo "10  CHANGE_AUTHOR -- ${env.CHANGE_AUTHOR}"
                echo "11  CHANGE_AUTHOR_EMAIL -- ${env.CHANGE_AUTHOR_EMAIL}"

                sh 'echo "I can access $BUILD_NUMBER in shell command as well."'
            }
        }
        
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