def COLOR_MAP = [
	'SUCCESS' : 'good',
	'FAILURE' : 'danger',
]

pipeline {
    agent {
      label 'node-1'
      
    //   docker{
    //         image 'centos:7'
    //         args '-u root'
    //         label 'docker2'
    //     }
    
    //  docker { image 'linuxacademycontent/jenkins_pipelines' }
    
    //  dockerfile true

        
  }
    
    stages {
        
        
        
        stage('Install required packages') {
            steps {
                script {
                    try {
                        def osType = ""
                        
                        // Determine the operating system type
                        if (isUnix()) {
                            osType = sh(script: "uname -s", returnStdout: true).trim()
                        }
                        
                        // Install packages based on the operating system
                        if (osType == 'Linux') {
                            def packageManager = ""
                            
                            if (isUnix()) {
                                // Determine the package manager based on the distribution
                                if (sh(script: "command -v yum", returnStatus: true) == 0) {
                                    packageManager = 'yum'
                                } else if (sh(script: "command -v apt-get", returnStatus: true) == 0) {
                                    packageManager = 'apt-get'
                                }
                            }
                            
                            // Install packages using the determined package manager
                            if (packageManager == 'yum') {
                                sh 'sudo yum -y install python3 python3-pip git'
                            } else if (packageManager == 'apt-get') {
                                sh 'sudo apt-get update && apt-get install -y python3 python3-pip git'
                            }
                        }
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error("An error occurred: ${e.getMessage()}")
                    }
                }
            }
        }
        
        
        stage('Checkout') {
            steps {
                // Checkout the source code from version control
                // For example: git checkout or svn checkout
                checkout scm
            }
        }
        
        stage('Unit Testing') {
           // agent { docker 'openjdk:7-jdk-alpine' }
            steps {
                sh "python /home/jenkins/workspace/BUILD_flask-app_project/test/test_unit.py"

                // Run unit tests
                // For example: using testing frameworks like JUnit, NUnit, etc.
                
            }
        }
        
        
        stage('Build Docker image'){
            steps{
                script {
                   // requires plugin 
                   // dockerImage = docker.build('notesapp:latest', '-f /home/jenkins/workspace/BUILD_flask-app_project/Dockerfile /home/jenkins/workspace/BUILD_flask-app_project')
                   
                   sh ' sudo    docker build -t notesapp:multistage /home/jenkins/workspace/BUILD_flask-app_project/ '
                   
                   
                }
            }
        }
        
        stage('Docker Container Stack-Up'){
            steps{
                script {
                    sh "echo '123'"
                }
            }
        }
        
        // stage('Copy artifacts'){
        //     steps{
        //         copyArtifacts(projectName: 'pipeline1', flatten: true)
        //         sh 'ls *.jpg'
        //     }
        // }
        
        stage('Integration Testing') {
            steps {
                script {
                    try {
                        sh 'python /home/jenkins/workspace/BUILD_flask-app_project/test/test_integration.py'
                    }catch (Exception e) {
                        echo "Tests failed, but pipeline will continue."
                    }
		   
                    
                    
                }
                
                // Run integration tests
                // Set up required environment and execute tests
            }
        }
        
        // stage('Build Docker Image') {
        //     when {
        //         branch 'master'
        //     }
        //     steps {
        //         script {
        //             app = docker.build(DOCKER_IMAGE_NAME)
        //             app.inside {
        //                 sh 'echo Hello, World!'
        //             }
        //         }
        //     }
        // }
        
        stage('System Testing for docker container') {
            steps {
                sh "echo 'test step'"

                // Run system tests it can be for image , container or VM
                // Set up environment, deploy application, and execute tests
            }
        }
        
        stage('Performance Testing') {
            steps {
                sh "echo 'test step'"

                // Run performance tests
                // For example: using tools like JMeter, Gatling, etc.
            }
        }
        
        stage('Security Testing') {
            steps {
                sh "echo 'test step'"

                // Run security tests
                // For example: using tools like OWASP ZAP, SonarQube, etc.
            }
        }
        
        stage('Usability Testing') {
            steps {
                sh "echo 'test step'"

                // Perform usability testing
                // Manually test the user interface for user-friendliness
            }
        }
        
        stage('Accessibility Testing') {
            steps {
                sh "echo 'test step'"

                // Run accessibility tests
                // For example: using tools like Axe, WAVE, etc.
            }
        }
        
        stage('Compatibility Testing') {
            steps {
                sh "echo 'test step'"

                // Run compatibility tests
                // Test the application on various devices, browsers, and platforms
            }
        }
        
        stage('Localization Testing') {
            steps {
                sh "echo 'test step'"

                // Run localization tests
                // Test the application with different languages and locales
            }
        }
        
        stage('User Acceptance Testing (UAT)') {
            steps {
                sh "echo 'test step'"

                // Prepare for and execute user acceptance tests
                // Involve stakeholders or end-users to validate the application
            }
        }
        
        stage('Deployment') {
            steps {
                sh "echo 'test step'"

                // Deploy the application to staging or production environment
                // Perform any necessary deployment steps
            }
        }
        
        stage('Alpha Testing') {
            steps {
                sh "echo 'test step'"

                // Perform alpha testing with internal users
                // Collect feedback and address issues
            }
        }
        
        stage('Beta Testing') {
            steps {
                sh "echo 'test step'"

                // Perform beta testing with external users
                // Collect feedback and address issues
            }
        }
        
        stage('Regression Testing') {
            steps {
                sh "echo 'test step'"

                // Perform regression tests on modified parts
                // Ensure new changes haven't introduced new defects
            }
        }
        
        stage('Cleanup') {
            steps {
                sh "echo 'test step'"

                // Perform cleanup tasks after testing
                // Stop services, release resources, etc.
            }
            
        }
        
        
        // stage('Push Docker Image') {
        //     when {
        //         branch 'master'
        //     }
        //     steps {
        //         script {
        //             docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
        //                 app.push("${env.BUILD_NUMBER}")
        //                 app.push("latest")
        //             }
        //         }
        //     }
        // }
        
        // stage('CanaryDeploy') {
        //     when {
        //         branch 'master'
        //     }
        //     environment { 
        //         CANARY_REPLICAS = 1
        //     }
        //     steps {
        //         kubernetesDeploy(
        //             kubeconfigId: 'kubeconfig',
        //             configs: 'train-schedule-kube-canary.yml',
        //             enableConfigSubstitution: true
        //         )
        //     }
        // }
        //  stage('DeployToProduction') {
        //     when {
        //         branch 'master'
        //     }
        //     environment { 
        //         CANARY_REPLICAS = 0
        //     }
        //     steps {
        //         input 'Deploy to Production?'
        //         milestone(1)
        //         kubernetesDeploy(
        //             kubeconfigId: 'kubeconfig',
        //             configs: 'train-schedule-kube-canary.yml',
        //             enableConfigSubstitution: true
        //         )
        //         kubernetesDeploy(
        //             kubeconfigId: 'kubeconfig',
        //             configs: 'train-schedule-kube.yml',
        //             enableConfigSubstitution: true
        //         )
        //     }
        // }
        
        
        
        // stage('DeployToStaging') {
        //     when {
        //         branch 'master'
        //     }
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'webserver_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
        //             sshPublisher(
        //                 failOnError: true,
        //                 continueOnError: false,
        //                 publishers: [
        //                     sshPublisherDesc(
        //                         configName: 'staging',
        //                         sshCredentials: [
        //                             username: "$USERNAME",
        //                             encryptedPassphrase: "$USERPASS"
        //                         ], 
        //                         transfers: [
        //                             sshTransfer(
        //                                 sourceFiles: 'dist/trainSchedule.zip',
        //                                 removePrefix: 'dist/',
        //                                 remoteDirectory: '/tmp',
        //                                 execCommand: 'sudo /usr/bin/systemctl stop train-schedule && rm -rf /opt/train-schedule/* && unzip /tmp/trainSchedule.zip -d /opt/train-schedule && sudo /usr/bin/systemctl start train-schedule'
        //                             )
        //                         ]
        //                     )
        //                 ]
        //             )
        //         }
        //     }
        // }
        // stage('DeployToProduction') {
        //     when {
        //         branch 'master'
        //     }
        //     steps {
        //         input 'Does the staging environment look OK?'
        //         milestone(1)
        //         withCredentials([usernamePassword(credentialsId: 'webserver_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
        //             sshPublisher(
        //                 failOnError: true,
        //                 continueOnError: false,
        //                 publishers: [
        //                     sshPublisherDesc(
        //                         configName: 'production',
        //                         sshCredentials: [
        //                             username: "$USERNAME",
        //                             encryptedPassphrase: "$USERPASS"
        //                         ], 
        //                         transfers: [
        //                             sshTransfer(
        //                                 sourceFiles: 'dist/trainSchedule.zip',
        //                                 removePrefix: 'dist/',
        //                                 remoteDirectory: '/tmp',
        //                                 execCommand: 'sudo /usr/bin/systemctl stop train-schedule && rm -rf /opt/train-schedule/* && unzip /tmp/trainSchedule.zip -d /opt/train-schedule && sudo /usr/bin/systemctl start train-schedule'
        //                             )
        //                         ]
        //                     )
        //                 ]
        //             )
        //         }
        //     }
        // }
    }
    
    post {
        always{
            sh 'echo "Job execution complete."'
            
            echo 'slack notification'
			slackSend channel : '#flask-notes-app',
				color : COLOR_MAP[currentBuild.currentResult],
					message : "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More Infor at : ${env.BUILD_URL}"
		
        }
        success {
            sh "echo 'Job Successfully Executed'"
            sh 'echo "$BUILD_ID"'
            sh 'echo "$BUILD_NUMBER"'
            //archiveArtifacts artifacts: '*watermarked.jpg'

            // Actions to perform when the pipeline completes successfully
            // For example: sending notifications, archiving artifacts, etc.
        }
        failure {
            sh 'echo "Job execution status is failed, please check error logs"'
            sh 'echo "$BUILD_ID"'
            sh 'echo "$BUILD_NUMBER , ${WORKSPACE}"'

            // Actions to perform when the pipeline fails
            // For example: sending notifications, logging errors, etc.
        }
        cleanup{
            echo 'Cleaning up environment'
            sh ' echo "if you have any cleanup required edit here" '
            //sh 'rm -rf content-pipelines-cje-labs *.jpg'
        }
    }
}
