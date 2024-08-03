# Flutter Web, FastAPI, Docker Composeのサンプルアプリ

## 概要

このプロジェクトは、Flutter Web（フロントエンド）、FastAPI（バックエンド）、およびNginx（リバースプロキシ）を使用したサンプルアプリケーションです。

- フロントエンド: Flutter Web
- バックエンド: FastAPI
- リバースプロキシ: Nginx

各コンポーネントは個別のディレクトリに分離されており、単独でのデプロイが可能です。開発環境では Docker Compose を使用して統合されています。

## アプリケーションのフロー

1. ユーザーはフロントエンドにアクセスします（例：https://localhost:8081）
2. ユーザーがタイマーを開始し終了すると、バックエンドのAPI経由でデータが`app/data/timer_records.json`に書き込まれます。
3. フロントエンドから履歴の閲覧や削除が可能です。

このアプリは、フロントエンドとバックエンドの基本的な連携を検証するためのシンプルなサンプルです。

## セットアップ手順

1. リポジトリをクローンします。

2. 環境設定ファイルを作成します：
   - `frontend/.env.example` を `frontend/.env` にコピーします。
   - `backend/.env.example` を `backend/.env` にコピーします。

3. Docker Compose でアプリケーションを起動します：
   ```
   docker-compose up -d
   ```

## ポート設定の変更（オプション）

ローカルのポートを変更したい場合（現状：8081）：

1. `docker-compose.yml` ファイルの Nginx サービス設定を変更します：
   ```yaml
   nginx:
     ...
     ports:
       - "8081:80"
   ```

2. `frontend/.env` ファイルの `API_URL` を更新します：
   ```
   API_URL=http://localhost:8081/api
   ```

3. 変更後、Docker Compose で再起動します：
   ```
   docker-compose down
   docker-compose up -d
   ```

## 開発

- フロントエンド（Flutter Web）の開発: `frontend/` ディレクトリで行います。
- バックエンド（FastAPI）の開発: `backend/` ディレクトリで行います。
- API仕様の確認: `http://localhost/api/docs` でSwagger UIを確認できます。

## 注意点

- 本番環境へのデプロイ時は、適切なセキュリティ設定を行ってください。
- `app/data/timer_records.json` は永続的なストレージではありません。本番環境では適切なデータベースの使用を検討してください。

## TODO

本番環境へのデプロイ検証はしておらず、全体的に設定を見直す必要があるかもしれません。
