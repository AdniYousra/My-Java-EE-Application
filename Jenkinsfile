node {
    def appName = 'my-javaee-app'
    def dockerImageName = 'my-javaee-app-image'
    
    try {
        stage('Checkout') {
            checkout scm
        }

        stage('Build') {
           
            sh "mvn clean package"
        }

        stage('Test') {
           
            sh "mvn test"
        }

        stage('Deploy') {
            
            sh "cp target/${appName}.war $WORKSPACE"
            
           
            sh "docker build -t ${dockerImageName} ."

           
            sh "docker run -d -p 8080:8080 ${dockerImageName}"
        }

    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
        archiveArtifacts artifacts: "target/${appName}.war", allowEmptyArchive: true

        
        if (currentBuild.resultIsBetterOrEqualTo('SUCCESS')) {
            echo 'CI/CD pipeline completed successfully!'
        } else {
            echo 'CI/CD pipeline failed!'
        }
    }
}