node {
    def appName = 'my-javaee-app'
    def dockerImageName = 'my-javaee-app-image'

    try {
        stage('Checkout') {
            checkout scm
        }

        stage('Build') {
            bat "mvn clean package"
        }

        stage('Test') {
            bat "mvn test"
        }

        stage('Deploy') {
            // Copy the .war file to the Docker build workspace
            bat "xcopy /Y target\\${appName}.war %WORKSPACE%"

            // Build a Docker image
            bat "docker build -t ${dockerImageName} ."

            // Deploy the Docker container (customize for your environment)
            bat "docker run -d -p 8080:8080 ${dockerImageName}"
        }

        stage('Kubernetes Deployment') {
            steps {
                script {
                    def kubeconfigPath = "${env.HOME}/.kube/config" // Path to your kubeconfig file
                    def kubeconfigContent = bat(script: "kubectl config view --raw", returnStdout: true).trim()

                    writeFile file: kubeconfigPath, text: kubeconfigContent

                    bat "kubectl apply -f Deployment.yaml"
                }
            }
        }

        stage('Kubernetes Service') {
            steps {
                script {
                    def kubeconfigPath = "${env.HOME}/.kube/config" // Path to your kubeconfig file
                    def kubeconfigContent = bat(script: "kubectl config view --raw", returnStdout: true).trim()

                    writeFile file: kubeconfigPath, text: kubeconfigContent

                    bat "kubectl apply -f Service.yaml"
                }
            }
        }

    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
        // Archive the artifact
        archiveArtifacts artifacts: "target\\${appName}.war", allowEmptyArchive: true

        // Print a message based on build result
        if (currentBuild.resultIsBetterOrEqualTo('SUCCESS')) {
            echo 'CI/CD pipeline completed successfully!'
        } else {
            echo 'CI/CD pipeline failed!'
        }
    }
}
