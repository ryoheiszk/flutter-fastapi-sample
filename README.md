# Flutter Web, FastAPI, Docker Composeのサンプルアプリ

## 概要

このプロジェクトは、Flutter Web（フロントエンド）、FastAPI（バックエンド）、およびNginx（リバースプロキシ）を使用したサンプルアプリケーションです。

- クライアント: Flutter Web
- API: FastAPI
- リバースプロキシ: Nginx

各コンポーネントは個別のディレクトリに分離されており、単独でのデプロイが可能です。開発環境では Docker Compose を使用して統合されています。

## アプリケーションのフロー

1. ユーザーはフロントエンドにアクセスします
2. ユーザーがタイマーを開始し終了すると、バックエンドのAPI経由でデータが`app/data/timer_records.json`に書き込まれます。
3. フロントエンドから履歴の閲覧や削除が可能です。

このアプリは、フロントエンドとバックエンドの基本的な連携を検証するためのシンプルなサンプルです。

## 使い方

- クライアント: http://localhost:8081
- API(Swagger): http://localhost:8081/api/docs
- データベース: `app/data/timer_records.json`

## セットアップ手順

```bash
cp client/.env.example client/.env
cp api/.env.example api/.env
```

```bash
docker-compose up
```

## ポート設定の変更（オプション）

ローカルのポートを変更したい場合: 8081から9000へ

1. `docker-compose.yml` ファイルの Nginx サービス設定を変更します：

   ```yaml
   nginx:
     ...
     ports:
       - "9099:80"
   ```

2. `frontend/.env` ファイルの `API_URL` を更新します：

   ```bash
   API_URL=http://localhost:9099/api
   ```

3. 変更後、Docker Compose で再起動します：

   ```bash
   docker-compose down
   docker-compose up -d
   ```

## TODO

本番環境へのデプロイ検証はしておらず、全体的に設定を見直す必要があるかもしれません。
