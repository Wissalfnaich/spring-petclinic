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
                sh 'javac -version'
                sh 'mvn package'
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
               echo 'deploing'
            }
        }
    }
     stage('Deploy to Azure') {
            steps {
                echo "Deploy to Azure"
                azureWebAppPublish appName: 'petclinic1', resourceGroup: 'ppp', credentialsId: 'Azure_cred', publishType: 'jar', filePath: 'target/spring-petclinic-3.0.0-SNAPSHOT.jar'
            }
        }
    
}
