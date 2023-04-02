pipeline{

	environment {
		DOCKERHUB_CREDENTIALS=credentials('jenkins-dockerhub')
		REGISTRY = "jose10000/dev-grupo3"
		DockerImage = ''
	}

	agent any

	stages {
		stage('gitclone') {

			steps {
				git branch: 'main', url: 'https://github.com/jose-10000/dev-grupo3.git'
			}
		}

		stage('Build') {

			steps {
				echo 'Building..'
				sh 'docker build -t jose10000/dev-grupo3:v1.$BUILD_NUMBER .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push jose10000/dev-grupo3:v1.$BUILD_NUMBER'
			}
		}
		post {
        always {
        // Se eliminan las imagenes creadas
            echo 'Se elimina la imagen creada'
            sh "docker rmi $REGISTRY:v1.$BUILD_NUMBER"
            sh "docker rmi registry.hub.docker.com/$REGISTRY:v1.$BUILD_NUMBER"
            
        }
        }
	}
}

