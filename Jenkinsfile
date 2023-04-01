pipeline{

	environment {
		DOCKERHUB_CREDENTIALS=credentials('jenkins-dockerhub')
		APP_NAME = 'dev-grupo3'
		DOCKER_IMAGE = 'jose10000/$APP_NAME:v1.$BUILD_NUMBER'
	}

	agent any

	stages {
		stage('gitclone') {

			steps {
				git branch: 'main', url: 'https://github.com/jose-10000/$APP_NAME.git'
			}
		}

		stage('Build') {

			steps {
				echo 'Building..'
				sh 'docker build -t $DOCKER_IMAGE .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push $DOCKER_IMAGE'
			}
		}
	}
}

