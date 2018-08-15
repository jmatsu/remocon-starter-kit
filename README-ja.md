# Remocon Starter Kit

CircleCIを利用して、[jmatsu/remocon](https://github.com/jmatsu/remocon) によるFirebase Remote Config管理のスターターキットです。

## CIジョブの内容

*Feature branches*

- 各プロジェクトの `parameters.yml` と `conditions.yml` から生成された json ファイルを validate する

*Master branch*

- master にマージされた config ファイルをリモートに反映する。変更されてない場合はスキップされる。
- リモートに反映した際に新しい etag が発行されるため、それを反映する PR を作成する

*Daily job*

- 各プロジェクトの Remote Config の状態をチェックする。
- 変更がある場合、その変更を反映する PR を作成する

## Getting Started

1. リポジトリの複製を行ってください

Fork されたリポジトリは private にすることができないため、fork 以外の手段で複製する必要があります。

- private でリポジトリを新規作成する (e.g. remote-config-management)
- 以下のスクリプトを実行する

```
cd /path/to/workspace

git clone git@github.com:jmatsu/remocon-starter-kit.git remote-config-management

cd remote-config-management

git remote set-url origin git@github.com:<your name>/remote-config-management.git
git push origin master
```

2. PR を作成するために必要な Github API token と write権限を持った ssh keyを用意してください

*Github token*

Github tokenは以下のスクリプト内で使われます。`GH_TOKEN` という名前の変数を想定していますが、自由に変更してください。
https://github.com/jmatsu/remocon-starter-kit/blob/master/bin/create_pr.bash 

*A ssh key for write access*

リポジトリへのpush権が必要なため、ssh鍵を設定します。
https://github.com/jmatsu/remocon-starter-kit/blob/master/.circleci/config.yml#L53

セキュリティの面から、新しい鍵を生成し、かつリポジトリスコープの ssh鍵の利用を推奨します。詳しくは公式に従ってください。

ref: https://circleci.com/docs/2.0/add-ssh-key/ , https://developer.github.com/v3/guides/managing-deploy-keys/

3. プレースホルダの置き換え

いくつかのスクリプトは変更しなければならない箇所があり、`<edit here>` という名前でプレースホルダやアンカーを置いています。

See https://github.com/jmatsu/remocon-starter-kit/search?q=%22%3Cedit+here%3E%22&unscoped_q=%22%3Cedit+here%3E%22

上記の箇所を自分の好みのものに変更してください。

4. Firebase プロジェクトのセットアップ

bundler を使って gemをインストールしてください。

```
cd /path/to/repo
bundle install --path=vendor/bundle
```

例として、 `remocon-sample` という Firebase プロジェクトを持っているとします。
`https://console.firebase.google.com/u/0/project/<firebase project id>/settings/serviceaccounts/adminsdk` からサービスアカウントの認証 JSON ファイルをダウンロードし、`projects/remocon-sample/service-account.json` として保存してください.

次に以下のスクリプトを走らせてください。トークンの発行と Remote Config の取得を行います。

```
export REMOCON_PREFIX="projects"
export REMOCON_FIREBASE_PROJECT_ID="remocon-sample"
export REMOCON_FIREBASE_ACCESS_TOKEN=$(bundle exec remocon token --service-json=$(bin/get_service_account_json.bash))

bundle exec remocon pull
```

`remocon-sample` のコンフィグは以下のディレクトリ構造に従って保存されます。

```
/path/to/repo
  - projects
    - remocon-sample
      - config.json
      - conditions.yml
      - parameters.yml
      - etag
```

このような形式で管理していきます。

5. CircleCI上でそのリポジトリを有効化する

ガイドにしたがって有効化してください。これで設定は終了です。

## NOTE

*About service account json files*

セキュリティの観点からも、直接サービスアカウント JSON ファイルをリポジトリへ保存することは推奨するものではありません。

*About visibility of the repository*

`private` を推奨します。少なくとも `public` にすることは想定していません。

---

何か質問等があれば、Issue を立ててください。 https://github.com/jmatsu/remocon-starter-kit/issues
