// pipeline {
//     agent any

//     stages {

//         stage("Clone Stage") {
//             steps {
//                 echo "Cloning done"
//             }
//         }

//         stage("Dependencies") {
//             steps {
//                 echo "Dependencies"
//                 sh '''
//                     flutter clean
//                     flutter pub get
//                 '''
//             }
//         }

//         stage("Test Stage") {
//             steps {
//                 sh 'flutter test'
//             }
//         }

//         stage("Build Stage") {
//             steps {
//                 echo "Build the APK"

//                 sh '''
//                     flutter build apk --release
//                 '''
//             }
//         }

//         stage("Deployment") {
//             steps {
//                 sh '''
//                     mkdir -p ~/Desktop/Builds

//                     DATE=$(date +"%d-%m-%Y_%H-%M-%S")

//                     cp build/app/outputs/flutter-apk/app-release.apk \
//                     ~/Desktop/Builds/$DATE.apk
//                 '''

//                 echo "Successfully deployed"
//             }
//         }
//     }


//    post 
//    {
//     success {




//         mail(
//             subject: "✅ Jenkins Build Successful - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
//             body: """
//                 Hello,

//                 The Flutter APK was successfully built and deployed.

//                 Job: ${env.JOB_NAME}
//                 Build Number: #${env.BUILD_NUMBER}
//                 Status: SUCCESS

//                 APK Location:
//                 ~/Desktop/Builds/

//                 Jenkins Build:
//                 ${env.BUILD_URL}

//                 Regards,
//                 Jenkins
//             """,
//             to: "jahan665577@gmail.com",
//             // attachments: "build-info.txt"
//         )
//     }

//     failure {
//         mail(
//             subject: "❌ Jenkins Build Failed - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
//             body: """
//                 Hello,

//                 The Jenkins build has failed.

//                 Job: ${env.JOB_NAME}
//                 Build Number: #${env.BUILD_NUMBER}
//                 Status: FAILURE

//                 Check the Jenkins console output:
//                 ${env.BUILD_URL}

//                 Regards,
//                 Jenkins
//             """,
//             to: "jahan665577@gmail.com"
//         )
//     }
//  }


// }





pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Flutter') {
            steps {
                sh '''
                    docker run --rm \
                    -v "$WORKSPACE:/app" \
                    -w /app \
                    fischerscode/flutter \
                    flutter pub get
                '''
            }
        }

    }
}