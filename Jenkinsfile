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
                    sh 'javac -version'
                    sh 'mvn clean package'
                }
            }
        }
         stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    script {
                        def scannerHome = tool 'sonarqube'
                        sh "${scannerHome}/bin/sonar-scanner \
                            -Dsonar.login=admin \
                            -Dsonar.password=Wissal12345 \
                           -Dsonar.projectKey=sonarqube \
                           -Dsonar.projectName='sonarqube' \
                           -Dsonar.host.url=https://172.17.0.3:9000/ \
                           -Dsonar.token=sqp_6e441ce14adc4ea8020d692422982f0282c4f5b8 "

                    }
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
