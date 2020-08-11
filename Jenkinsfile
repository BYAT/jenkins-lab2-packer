pipeline { 
    agent{ 
        docker {
	    image "bryandollery/terraform-packer-aws-alpine"
            args "-u root -entrypoint=''"
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
                AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
                AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
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
