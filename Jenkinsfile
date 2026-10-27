pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'baigashev-timur-student-api'
        DOCKER_TAG = 'v1.1-baigashev-timur'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    triggers {
        pollSCM('H/5 * * * *')
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Student: Timur Baigashev'
                echo 'Checking out source code from GitHub'
                checkout scm
                sh 'git log -1 --oneline'
            }
        }

        stage('Build') {
            steps {
                echo 'Building Spring Boot application with Java 17'
                sh '''
                    java -version
                    if [ -x ./mvnw ]; then
                        chmod +x ./mvnw
                        ./mvnw -B -DskipTests package
                    else
                        mvn -B -DskipTests package
                    fi
                '''
            }
        }

        stage('Test') {
            steps {
                echo 'Running automated tests for Timur Baigashev'
                sh '''
                    if [ -x ./mvnw ]; then
                        ./mvnw -B test
                    else
                        mvn -B test
                    fi
                '''
            }
        }

        stage('Docker Build') {
            steps {
                echo "Building ${DOCKER_IMAGE}:${DOCKER_TAG}"
                sh '''
                    docker build \
                      -t "${DOCKER_IMAGE}:${DOCKER_TAG}" .
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    docker image inspect \
                      "${DOCKER_IMAGE}:${DOCKER_TAG}" \
                      --format='Image={{.RepoTags}} Size={{.Size}} bytes Created={{.Created}}'
                '''
                echo 'SUCCESS: Docker image verified for Timur Baigashev'
            }
        }
    }

    post {
        success {
            echo 'PIPELINE SUCCESS: Timur Baigashev Student API'
        }
        failure {
            echo 'PIPELINE FAILED: inspect the stage and console output'
        }
        always {
            echo 'Jenkins pipeline execution finished'
        }
    }
}
