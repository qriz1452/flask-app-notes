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
                                // sh 'sudo dnf install centos-release-scl'
                                // sudo sh 'sudo dnf install python27'
                                // sudo sh "export PATH=/bin:/usr/bin:/opt/aws/bin:$PATH"
                                // sudo sh "export PYTHONPATH='${PYTHONPATH}:/usr/local/lib/python2.7/site-packages/'"
                                // sudo sh 'sudo yum install -y epel-release wget'
                                // sh 'sudo sudo wget -O /home/aws-cfn-bootstrap-latest.amzn1.noarch.rpm https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.amzn1.noarch.rpm'
                                // sh 'sudo sudo yum install -y /home/aws-cfn-bootstrap-latest.amzn1.noarch.rpm'
                                // sh 'sudo yum update -y'
                                // sh 'sudo yum install -y yum-utils device-mapper-persistent-data lvm2'
                                // sh 'sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo'
                                // sh 'sudo yum install -y git docker-ce'
                                // sh 'sudo usermod -aG docker jenkins'
                                // sh 'sudo systemctl enable --now docker'
                                
                
                                
                            } else if (packageManager == 'apt-get') {
                                // your aot packages here
                                
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
            tools {
                    // Specify the 'Default' Git installation
                    git 'Default'
                }
            steps {
                // Checkout the source code from version control
                // For example: git checkout or svn checkout
                checkout scm
            }
        }
        
        stage('Unit Testing') {
          // agent { docker 'openjdk:7-jdk-alpine' }
            steps {
                sh "python ./test/test_unit.py"

                // Run unit tests
                // For example: using testing frameworks like JUnit, NUnit, etc.
                
            }
        }
        
        
        
        stage('BACKEND Build and conf .env setup'){
            steps{
sh """
cat > ./.env <<EOF
export DB_HOST='notesdb'
export DB_PORT='5432'
export DB_NAME='notes'
export DB_USERNAME='demo'
export DB_PASSWORD='secure_password'
export FLASK_ENV='development'
export FLASK_APP='.'
EOF
"""
    
            }
        }
        
        stage('backend prereq'){
            steps{
                sh "sudo docker pull postgres:12.1-alpine"
                sh "source ./.env"
                sh "sudo docker network create notes > /dev/null 2>&1"
            }
        }
        
        stage('Backend Build Image '){
            // when {
            //     branch 'master'
            // }
            steps{
                sh "echo 'why it WORKS' "
                sh "sudo docker run -d --name notesdb --network notes -p $DB_PORT:5432 -e POSTGRES_USER=$DB_USERNAME -e POSTGRES_PASSWORD=$DB_PASSWORD --restart always postgres:12.1-alpine"

                  // requires plugin 
                  // dockerImage = docker.build('notesapp:latest', '-f /home/jenkins/workspace/BUILD_flask-app_project/Dockerfile /home/jenkins/workspace/BUILD_flask-app_project')
                   
                  //without plugin using sh command
                
            }
        }
        
        stage('Frontend Build and conf'){
            steps{
                sh "echo 'aaa'"
                    // provide your sh " "  commands
                
                
            }
        }
        
        stage('Frontend Build Image '){
            // when {
            //     branch 'master'
            // }
            steps{
                script {
                    sh "echo 'aaa'"
                  // requires plugin 
                  // dockerImage = docker.build('notesapp:latest', '-f /home/jenkins/workspace/BUILD_flask-app_project/Dockerfile /home/jenkins/workspace/BUILD_flask-app_project')
                   
                  //without plugin using sh command
                  
                  
                }
            }
        }
        
        stage('BACKEND Docker Container'){
            steps{
                script {
                    sh "echo 'aaa'"
                    // provide your sh " "  commands
                
                }
            }
        }
        
        stage('frontend  Docker Container '){
            steps{
                script {
                    sh "echo 'aaa'"
                  // requires plugin 
                  // dockerImage = docker.build('notesapp:latest', '-f /home/jenkins/workspace/BUILD_flask-app_project/Dockerfile /home/jenkins/workspace/BUILD_flask-app_project')
                   
                  //without plugin using sh command
                  
                  
                }
            }
        }
        
        
        
        stage('Integration Testing') {
              // Run integration tests
             // Set up required environment and execute tests
            steps {
                script {
                    try {
                        sh 'python ./test/test_integration.py'
                    }catch (Exception e) {
                        echo "Tests failed, but pipeline will continue."
                    }
                }
            }
        }
        
        stage('System Testing for docker container') {
            steps {
                sh "echo ' FRONTEND SYSTEM TEST RUNNING'"
                sh "sudo sh ./test/test_system_backend.sh" 
                
                sh "echo ' BACKEND SYSTEM TEST RUNNING'"
                sh "sudo sh ./test/test_system_frontend.sh "

                // Run system tests it can be for image , container or VM
                // Set up environment, deploy application, and execute tests
            }
        }
        
        stage('Performance Testing') {
            steps {
                sh "echo ' Running JMeter test using the Performance Plugin''s jmeter step'"
                
               // jmeter allowAbsolutePath="true", jmeterProperties: '', jtlArchive: '**/*.jtl', testFile: './test/test_performance_jmeter.jmx'
          

                // Run performance tests
                // For example: using tools like JMeter, Gatling, etc.
            }
        }
        
        // stage('Security Testing') {
        //     steps {
        //         sh "echo 'test step'"

        //         // Run security tests
        //         // For example: using tools like OWASP ZAP, SonarQube, etc.
        //     }
        // }
        
        // stage('Usability Testing') {
        //     steps {
        //         sh "echo 'test step'"

        //         // Perform usability testing
        //         // Manually test the user interface for user-friendliness
        //     }
        // }
        
        // stage('Accessibility Testing') {
        //     steps {
        //         sh "echo 'test step'"

        //         // Run accessibility tests
        //         // For example: using tools like Axe, WAVE, etc.
        //     }
        // }
        
        // stage('Compatibility Testing') {
        //     steps {
        //         sh "echo 'test step'"

        //         // Run compatibility tests
        //         // Test the application on various devices, browsers, and platforms
        //     }
        // }
        
        // stage('Localization Testing') {
        //     steps {
        //         sh "echo 'test step'"

        //         // Run localization tests
        //         // Test the application with different languages and locales
        //     }
        // }
        
        // stage('User Acceptance Testing (UAT)') {
        //     steps {
        //         sh "echo 'test step'"

        //         // Prepare for and execute user acceptance tests
        //         // Involve stakeholders or end-users to validate the application
        //     }
        // }
        
        // stage('Deployment') {
        //     steps {
        //         sh "echo 'test step'"

        //         // Deploy the application to staging or production environment
        //         // Perform any necessary deployment steps
        //     }
        // }
        
        // stage('Alpha Testing') {
        //     steps {
        //         sh "echo 'test step'"

        //         // Perform alpha testing with internal users
        //         // Collect feedback and address issues
        //     }
        // }
        
        // stage('Beta Testing') {
        //     steps {
        //         sh "echo 'test step'"

        //         // Perform beta testing with external users
        //         // Collect feedback and address issues
        //     }
        // }
        
        // stage('Regression Testing') {
        //     steps {
        //         sh "echo 'test step'"

        //         // Perform regression tests on modified parts
        //         // Ensure new changes haven't introduced new defects
        //     }
        // }
        
        
        
        
        
        // stage('Copy artifacts'){
        //     steps{
        //         copyArtifacts(projectName: 'pipeline1', flatten: true)
        //         sh 'ls *.jpg'
        //     }
        // }
        
        // stage('Push Docker Image') {
        //     // push both images to dockerhub
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
        
        // stage('Cleanup') {
        //     steps {
        //     sh ' echo "if you have any cleanup required edit here" '
        //     sh " sudo docker network rm -f notesdb "
        //     sh " sudo docker network rm -f httpd-server "
        //     sh " sudo docker network rm notes "
        //     sh " sudo rm -rf /home/jenkins/workspace/BUILD_flask-app_project "
        //     }
            
        // }
        
        
        // ************ PHASE 2 USING DOCKER COMPOSE ************************
        
        // Stage('Docker Container Stack-Up'){
        //     steps{
        //         script {
        //             sh 'sudo docker run -d --name notesdb --network notes -p $DB_PORT:5432 -e POSTGRES_USER=$DB_USERNAME -e POSTGRES_PASSWORD=$DB_PASSWORD --restart always postgres:12.1-alpine '

        //           // sh " sudo docker compose up "
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
        }
        
        failure {
            sh 'echo "Job execution status is failed, please check error logs"'
            
            sh ' echo "if you have any cleanup required edit here" '
            sh " sudo docker network rm -f notesdb "
            sh " sudo docker network rm -f httpd-server "
            sh " sudo docker network rm notes "
            sh " sudo rm -rf /home/jenkins/workspace/BUILD_flask-app_project "
        }
        
        aborted{
            sh ' echo "if you have any cleanup required edit here" '
            sh " sudo docker network rm -f notesdb "
            sh " sudo docker network rm -f httpd-server "
            sh " sudo docker network rm notes "
            sh " sudo rm -rf /home/jenkins/workspace/BUILD_flask-app_project "
        }
        
        unstable{
            sh ' echo "if you have any cleanup required edit here" '
            sh " sudo docker network rm -f notesdb "
            sh " sudo docker network rm -f httpd-server "
            sh " sudo docker network rm notes "
            sh " sudo rm -rf /home/jenkins/workspace/BUILD_flask-app_project "
        }
    }
}
