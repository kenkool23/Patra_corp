pipeline {
  agent any

  tools {
  maven 'Maven3'
  }
  stages {
    stage ('Build') {
      steps {
      sh 'mvn clean install -f MyWebApp/pom.xml'
      }
    }
    stage ('Code Quality') {
      steps {
        withSonarQubeEnv('SonarQube') {
        sh 'mvn -f MyWebApp/pom.xml sonar:sonar'
        }
      }
    }
    stage ('DEV Deploy') {
      steps {
      echo "deploying to DEV Env "
      deploy adapters: [tomcat9(credentialsId: '268c42f6-f2f5-488f-b2aa-f2374d229b2e', path: '', url: 'http://your_public_dns:8090')], contextPath: null, war: '**/*.war'
      }
    }
  
}
