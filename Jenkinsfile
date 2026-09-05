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




// pipeline {
//     agent any

//     environment {
//         FLUTTER_IMAGE = 'ghcr.io/adrianjagielak/flutter:3.47.0'

//         // Persistent cache directories on the Jenkins machine
//         GRADLE_CACHE = "${HOME}/.jenkins/docker-cache/gradle"
//         ANDROID_CACHE = "${HOME}/.jenkins/docker-cache/android"
//         PUB_CACHE = "${HOME}/.jenkins/docker-cache/pub"
//     }

//     stages {

//         stage('Build Flutter') {
//             steps {
//                 sh '''
//                     echo "Creating cache directories..."

//                     mkdir -p "$GRADLE_CACHE"
//                     mkdir -p "$ANDROID_CACHE"
//                     mkdir -p "$PUB_CACHE"

//                     echo "Starting Flutter Docker build..."

//                     docker run --rm \
//                       --platform linux/amd64 \
//                       -v "$WORKSPACE:/app" \
//                       -v "$GRADLE_CACHE:/root/.gradle" \
//                       -v "$ANDROID_CACHE:/root/.android" \
//                       -v "$PUB_CACHE:/root/.pub-cache" \
//                       -w /app \
//                       "$FLUTTER_IMAGE" \
//                       flutter build apk --release
//                 '''
//             }
//         }
//     }

    
// }




// node{
//         stage("Build") {
            
//                 echo "======== Build ========"

//                 sh '''
//                 docker build -t myapp .
//                 docker run --rm myapp
//                 '''
      
//         }

//         stage("Testing") {
      
//                 echo "======== Testing ========"

                
     
//         }

//         stage("Deployment") {
           
//                 echo "======== Deployment ========"

//                 sh '''
//                     echo "Deploying application..."
//                 '''
   
//         }
// }



