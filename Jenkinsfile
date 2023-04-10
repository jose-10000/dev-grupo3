pipeline{

	environment {
		DOCKERHUB_CREDENTIALS=credentials('jenkins-dockerhub')
		REGISTRY = "jose10000/dev-grupo3:v1.$BUILD_NUMBER"
		DockerImage = ''
		GITHUB_CREDENTIALS=credentials('github-jenkins')
		ISSUE_TITLE = "$JOB_NAME $BUILD_DISPLAY_NAME falló"
		NPM_REPORT_FILE = "npm_audit_report.txt"
		URL_REPO = "https://github.com/jose-10000/dev-grupo3.git"
	//	SNYK_TOKEN=credentials('snykID') si usas esto da error
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
				sh 'docker build -t $REGISTRY .'
			}
		}

    stage('Scan') {
        steps {
        echo 'Scanning...'
        snykSecurity(
            snykInstallation: 'Snyk-grupo3',
            snykTokenId: 'snykID',
			severity: 'high',
			failOnError: 'false',
			failOnIssues: 'false',
          // place other parameters here
			additionalArguments: '--docker $REGISTRY'
        )
        }
    }

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push $REGISTRY'
			}
		}

	}
	post {
        always {
        // Se eliminan las imagenes creadas
            echo 'Se elimina la imagen creada'
            sh "docker rmi $REGISTRY"
        }
    }
}