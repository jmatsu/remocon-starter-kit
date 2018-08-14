# Remocon Starter Kit

This repository is a sample usage of [jmatsu/remocon](https://github.com/jmatsu/remocon) with CircleCI.

## Getting Started

1. Fork this repository and clone it

```
git clone git@github.com:<your name>/remocon-starter-kit.git
```

2. Set up your Github token and a ssh key for write access

*Github token*

https://github.com/jmatsu/remocon-starter-kit/blob/master/bin/create_pr.bash uses a token to create a PullRequest.

*A ssh key for write access*

Some of CI jobs will push changes to your repository before creating PRs.
https://github.com/jmatsu/remocon-starter-kit/blob/master/.circleci/config.yml#L53

For the security reason, you should create new ssh key and add it with repository-scope.

3. Remove some placeholders

These are what you need to modify.

See https://github.com/jmatsu/remocon-starter-kit/search?q=%22%3Cedit+here%3E%22&unscoped_q=%22%3Cedit+here%3E%22

4. Follow your project in CircleCI

