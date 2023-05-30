pipeline {
    agent any
    
    tools {
        jdk 'openJDK'
        maven 'Maven'
    }
    
    stages {
        
        stage("build jar") {
            steps {
                timestamps {
                    echo "building the application..."
                    sh 'mvn clean install'
                    sh 'mvn package'
                }
            }
        }
        
        stage('Code Coverage') {
            steps {
                timestamps {
                    // Generate code coverage report
                    sh 'mvn jacoco:prepare-agent test jacoco:report'
                }
            }
        }
        
        stage("build image") {
            steps {
                timestamps {
                    echo "building the docker image..."
                    withCredentials([usernamePassword(credentialsId: 'docker_hub_cred', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'docker build -t wissaaal/my-repo:jma-2.0 .'
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh 'docker push wissaaal/my-repo:jma-2.0'
                    }
                }
            }
    
    post {
        always {
            // Publish code coverage report
            jacoco(
                execPattern: '**/target/jacoco.exec',
                classPattern: '**/classes',
                sourcePattern: '**/src/main/java'
            )
        }
    }
}
