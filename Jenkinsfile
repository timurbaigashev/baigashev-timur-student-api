
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
                    set -eu

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
                echo 'Running PostgreSQL integration tests for Timur Baigashev'

                sh '''
                    set -eu

                    docker rm -f baigashev-timur-test-postgres \
                        >/dev/null 2>&1 || true

                    docker run -d \
                        --name baigashev-timur-test-postgres \
                        -e POSTGRES_DB=student_test \
                        -e POSTGRES_USER=student_test_user \
                        -e POSTGRES_PASSWORD=student_test_password \
                        -p 55432:5432 \
                        postgres:16

                    ready=0

                    for i in $(seq 1 30); do
                        if docker exec baigashev-timur-test-postgres \
                            pg_isready -U student_test_user -d student_test; then
                            ready=1
                            break
                        fi

                        sleep 2
                    done

                    if [ "$ready" -ne 1 ]; then
                        docker logs baigashev-timur-test-postgres
                        exit 1
                    fi

                    export DB_URL='jdbc:postgresql://host.docker.internal:55432/student_test'
                    export DB_USERNAME='student_test_user'
                    export DB_PASSWORD='student_test_password'

                    if [ -x ./mvnw ]; then
                        chmod +x ./mvnw
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
                    set -eu

                    docker build \
                        -t "${DOCKER_IMAGE}:${DOCKER_TAG}" .
                '''
            }
        }

        stage('Verify') {
            steps {
                echo 'Verifying Docker image for Timur Baigashev'

                sh '''
                    set -eu

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
            echo 'PIPELINE FAILED: inspect the failed stage and console output'
        }

        always {
            sh '''
                docker rm -f baigashev-timur-test-postgres \
                    >/dev/null 2>&1 || true
            '''

            echo 'Jenkins pipeline execution finished'
        }
    }
}
