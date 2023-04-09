pipeline{

	tools {
		maven 'maven-3.5.2'
	}

	environment {
		DOCKERHUB_CREDENTIALS=credentials('jenkins-dockerhub')
		REGISTRY = "jose10000/dev-grupo3"
		DockerImage = ''
		SNYK_TOKEN=credentials('snykID')
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

		stage('Scan') {

			steps {
				echo 'Scanning..'
				sh "mvn install"
				script {
					snykSecurity severity: 'critical', snykInstallation: 'snyk', snykToken: snykID
					def snykReport = sh(
						script: 'snyk container test jose10000/dev-grupo3:v1.$BUILD_NUMBER --severity-threshold=critical',
						returnStatus: true)

				echo "Snyk report: ${snykReport}"
				if (snykReport != 0) {
					error('Snyk found critical vulnerabilities')
				}
			}
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
	}
	
	post {
        always {
        // Se eliminan las imagenes creadas
            echo 'Se elimina la imagen creada'
            sh "docker rmi $REGISTRY:v1.$BUILD_NUMBER"
        }
    }
}

