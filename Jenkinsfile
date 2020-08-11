pipeline { 
    agent{ 
        docker {
            image 'alpine:3.7'
            }
        }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('build') {
            steps {
                timeout(time: 1, unit:'MINUTES'){
                sh 'packer build packer.json'
                }
            }
        }
        stage('test') {
            steps {
                git(url: 'https://github.com/BYAT/jenkins-lab2-packer', branch: 'master')
            }
        }
        stage ('release') {
            environment {
                CREDS = credentials('bashayr')
            }
            steps {
                sh "whoami"
                sh "docker login -u ${CREDS_USR}"
            }
        }
    }
}
