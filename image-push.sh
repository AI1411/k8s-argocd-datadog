#!/bin/bash

# Google Cloud 設定
PROJECT_ID="planet-4f7c6"
REGION="asia-northeast1"
REPOSITORY_NAME="gke-argocd"

# Dockerの認証設定
gcloud auth configure-docker $REGION-docker.pkg.dev

# ビルドとプッシュ
for dir in cmd/batch/*; do
  # サブディレクトリ名を取得 (例: first, second, ...)
  IMAGE_NAME=$(basename $dir)

  # Dockerイメージのタグ付け
  DOCKER_TAG="$REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY_NAME/$IMAGE_NAME-step:latest"

  # Dockerイメージのプッシュ
  docker push $DOCKER_TAG
done
