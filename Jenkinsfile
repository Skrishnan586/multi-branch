pipeline {
    agent any
    tools {
        maven 'maven3' 
    }
    stages {
      stage ('Build') {
        steps {
          script{
            def mvnHome = tool name: 'maven3', type: 'maven'
            sh "mvn package"
            //sh 'mv target/onlinebookstore*.war target/newbook.war'
          }
        }
      }
      stage ('SonarQube'){
        steps{
          script{
            def mvnHome =  tool name: 'maven3', type: 'maven'
            withSonarQubeEnv('sonar-pro') {
              sh "${mvnHome}/bin/mvn sonar:sonar"
            }
          }
        }
      }
      stage('Docker Build') {
        steps{
          script{
            sh 'docker build -t harikrishnan586/multi:v1 .'
            //sh 'docker images'
          }
        }
      }
      stage('Docker push'){
        steps{
          script{
            withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPassword')]) {
              sh "docker login -u harikrishnan586 -p ${dockerPassword}"
              sh 'docker push harikrishnan586/multi:v1'
              sh 'docker rmi harikrishnan586/multi:v1'
            }
          }
        }
      }
      stage('Deploy on k8s') {    
        steps {
          script{
            withKubeCredentials(kubectlCredentials: [[ credentialsId: 'kubernetes', namespace: 'ms' ]]) {
                sh 'kubectl create namespace ms'
                sh 'kubectl apply -f kube.yaml'
            }
          }
        }
      }
    }
}
