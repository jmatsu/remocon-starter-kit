# Remocon Starter Kit

This repository is a sample but production usage of [jmatsu/remocon](https://github.com/jmatsu/remocon) with CircleCI.

## What this will do

*Feature branches*

- Validate config files which are built by `parameters.yml` and `conditions.yml` for each projects

*Master branch*

- Push built config files when merged into master if needed
- Create a PR to update etag files

*Daily job*

- Check the remote configs
- Pull changes and create a PR if changed

## Getting Started

1. Please duplicate this repository

Forked repository cannot be private so that you need to duplicate this repository

- Create a *private* repository in your account or organization (e.g. remote-config-management)
- Run the script below

```
cd /path/to/workspace

git clone git@github.com:jmatsu/remote-config-management.git remote-config-management

cd remote-config-management

git remote set-url origin git@github.com:<your name>/remote-config-management.git
git push origin master
```

2. Set up your Github token and a ssh key for write access

*Github token*

https://github.com/jmatsu/remocon-starter-kit/blob/master/bin/create_pr.bash uses a token to create a PullRequest.
`GH_TOKEN` is assumed variable name but you can use any name.

*A ssh key for write access*

Some of CI jobs will push changes to your repository before creating PRs.
https://github.com/jmatsu/remocon-starter-kit/blob/master/.circleci/config.yml#L53

For the security reason, you should create a new ssh key and add it with repository-scope.

ref: https://circleci.com/docs/2.0/add-ssh-key/ , https://developer.github.com/v3/guides/managing-deploy-keys/

3. Replace some placeholders

These are what you need to modify.

See https://github.com/jmatsu/remocon-starter-kit/search?q=%22%3Cedit+here%3E%22&unscoped_q=%22%3Cedit+here%3E%22

4. Set up your firebase projects

First, please install gems.

```
cd /path/to/repo
bundle install --path=vendor/bundle
```

Let's say you already have a firebase project whose id is `remocon-sample`.
Then you need to download the service account json file from `https://console.firebase.google.com/u/0/project/<firebase project id>/settings/serviceaccounts/adminsdk` and save it to `projects/remocon-sample/service-account.json`.

After that, please run the following script.

```
export REMOCON_PREFIX="projects"
export REMOCON_FIREBASE_PROJECT_ID="remocon-sample"
export REMOCON_FIREBASE_ACCESS_TOKEN=$(bundle exec remocon token --service-json=$(bin/get_service_account_json.bash))

bundle exec remocon pull
```

`remocon-sample`'s configs will be saved like below.

```
/path/to/repo
  - projects
    - remocon-sample
      - config.json
      - conditions.yml
      - parameters.yml
      - etag
```

You will manage files with following this structure.

5. Enable your project in CircleCI

yay, now you can manage remote configs by code!

## NOTE

*About service account json files*

For some security reasons, I don't recommend you to save service account json files in the repository. 
It would be better to encrypt them and decrypt them in CI services.

*About visibility of the repository*

`private` is recommended. In other words, `public` is not expected.

---

If you have any questions, please feel free to open issues.
 https://github.com/jmatsu/remocon-starter-kit/issues
