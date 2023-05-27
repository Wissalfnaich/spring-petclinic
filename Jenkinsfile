pipeline {
    agent any
    tools {
        maven 'Maven'
      
    }
        
    stages {
        stage("build jar") {
            steps {
               echo "building the application..."
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
    
}
