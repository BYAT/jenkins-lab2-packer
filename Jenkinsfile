pipeline { 
    agent{ 
        docker {
	    image "bryandollery/terraform-packer-aws-alpine"
            args "-u root"
	}
        }
    options {
        skipStagesAfterUnstable()

    }
    stages {
        stage('test') {
            steps {
                git(url: 'https://github.com/BYAT/jenkins-lab2-packer', branch: 'master')
            }
        }
        stage ('release') {
            environment {
                CREDS = credentials('bashayr')
                AWS_ACCESS_KEY_ID= "${CREDS_USR}"
                AWS_SECRET_ACCESS_KEY = "${CREDS_PSW}"
                TF_NAMESPACE='bashayr'
                OWNER='bashayr'
                PROJECT_NAME="${JOB_NAME}"
            }
            steps {
                sh "whoami"
                sh "docker login -u ${CREDS_USR} -p ${CREDS_PSW}"
            }
        }
        stage('build') {
            steps {
                timeout(time: 1, unit:'MINUTES'){
                sh 'packer build packer.json'
                }
            }
        }
        
      
    }
}
