pipeline {
    agent any
    
    tools {
        jdk 'openJDK'
        maven 'Maven'
    }
    
    stages {
        stage('Set JAVA_HOME') {
            steps {
                timestamps {
                    script {
                        env.JAVA_HOME = '/usr/lib/jvm/openjdk-17' 
                    }
                }
            }
        }
        
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
        }
        
      
        
    stage('Deploy') {
    steps {
        script {
            def imageName = 'wissaaal/my-repo:jma-2.0'
            def nginxContainerId = sh(returnStdout: true, script: 'docker ps -q --filter "id=a83410bd2444"').trim()
            
            // Poussez l'image Docker vers Docker Hub
            sh "docker push docker.io/${imageName}"
            
            // Récupérez l'image Docker depuis Docker Hub dans le conteneur Nginx
            sh "docker exec ${nginxContainerId} docker pull ${imageName}"
            
            // Redémarrez le conteneur Nginx pour utiliser la nouvelle image
            sh "docker restart ${nginxContainerId}"
        }
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
