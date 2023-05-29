pipeline {
    agent any
    tools {
        jdk 'openJDK'
        maven 'Maven'
    }
        
    stages {
        stage('Set JAVA_HOME') {
            steps {
                script {
                    env.JAVA_HOME = '/usr/lib/jvm/openjdk-17' 
                }
            }
        }
        stage("build jar") {
            steps {
                echo "building the application..."
 
                sh 'mvn package'
            }
        }
       stage('Code Coverage') {
            steps {
                // Generate code coverage report
                sh 'mvn jacoco:prepare-agent test jacoco:report'
            }
        }
        stage("build image") {
            steps {
                echo "building the docker image..."
                withCredentials([usernamePassword(credentialsId: 'docker_hub_cred', passwordVariable: 'PASS', usernameVariable: 'USER')]){
                    sh 'docker build -t wissaaal/my-repo:jma-2.0 .'
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh 'docker push wissaaal/my-repo:jma-2.0'
                }
            }
        }
        stage('test') {
            steps {
                echo 'testing'
            }
        }
        stage('deploy') {
            steps {
                echo 'deploying'
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
