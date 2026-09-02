# flutter_devops

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



<!-- 
name: flutter-project

on:
  push:
    branches:
      - main

jobs:
  flutter:
    runs-on: ubuntu-latest

    steps:
      - name: checkout-code
        uses: actions/checkout@v7

      - name: setup-flutter
        uses: subosito/flutter-action@v2.14.0
        with:
          channel: stable

      - name: get dependency
        run: flutter pub get

      - name: flutter-test
        run: flutter test

      - name: flutter-apk
        run: flutter build apk --release

      - name: Get Flutter Info
        run: |
          flutter --version

      - name: Rename APK
        run: |
          DATE_TIME=$(date +"%d-%m-%Y_%H-%M-%S")
          APK_NAME="${DATE_TIME}.apk"

          mv build/app/outputs/flutter-apk/app-release.apk \
             build/app/outputs/flutter-apk/$APK_NAME

          echo "APK_NAME=$APK_NAME" >> $GITHUB_ENV

      - name: Create Build Info
        run: |
          cat > build-info.txt <<EOF
          Flutter APK Build Information
          ==============================

          Repository:
          ${{ github.repository }}

          Repository URL:
          
          ${{ github.server_url }}/${{ github.repository }}

          Branch:
          ${{ github.ref_name }}

          Commit:
          ${{ github.sha }}

          Commit URL:
          ${{ github.server_url }}/${{ github.repository }}/commit/${{ github.sha }}

          Workflow:
          ${{ github.workflow }}

          Workflow Run:
          ${{ github.run_number }}

          Workflow Run URL:
          ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}

          Flutter Version:
          $(flutter --version | head -n 1)

          Dart Version:
          $(dart --version 2>&1)

          APK:
          ${{ env.APK_NAME }}

          Build Date:
          $(date)

          ==============================
          Build completed successfully.
          EOF

      - name: Upload APK
        uses: actions/upload-artifact@v4
        with:
          name: flutter-apk
          path: build/app/outputs/flutter-apk/*.apk

      - name: Send mail
        if: success()
        uses: dawidd6/action-send-mail@v3
        with:
          server_address: smtp.gmail.com
          server_port: 465
          secure: true

          username: ${{ secrets.MAIL_USERNAME }}
          password: ${{ secrets.MAIL_PASSWORD }}

          subject: Flutter APK Build Successful

          to: arshadullah.icp@gmail.com

          from: GitHub Actions <jahan665577@gmail.com>

          body: |
            Hello,

            Flutter APK build completed successfully.

            Repository:
            ${{ github.repository }}

            Branch:
            ${{ github.ref_name }}

            Flutter:
            $(flutter --version | head -n 1)

            APK:
            ${{ env.APK_NAME }}

            Download / Workflow:
            ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}

            The APK and build information are attached to this email.

          attachments: |
            
            build-info.txt -->