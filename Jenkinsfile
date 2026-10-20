pipeline {

    agent any

    environment {
        FLUTTER_IMAGE = 'flutter-builder:3.47.0'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Arshad-ullah/flutter-devops.git'
            }
        }

        stage('Build APK') {
            steps {
                sh '''
                    docker run --rm \
                        --platform linux/amd64 \
                        -v "$WORKSPACE:/workspace" \
                        -v flutter-pub-cache:/root/.pub-cache \
                        -v flutter-gradle-cache:/root/.gradle \
                        -w /workspace \
                        $FLUTTER_IMAGE \
                        bash -c "
                            flutter pub get &&
                            flutter build apk --release
                        "
                '''
            }
        }

        stage('Archive APK') {
            steps {
                archiveArtifacts \
                    artifacts: 'build/app/outputs/flutter-apk/app-release.apk',
                    fingerprint: true
            }
        }
    }
}