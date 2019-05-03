twitter-api-oauth2
====

Overview

## Description
twitter apiのアクセストークンをoauth2で取得します。

## Preparing
事前にtwitterアプリの登録を行い、「API key」と「API secret key」を取得してください。

## Usage
```
; sample.scm

(require "./twitter-oauth2")
(import twitter-oauth2)
(define cons-key API-key)
(define sec-key API-secret-key)

(define result (get-bearer-token cons-key sec-key))
(print result)
>>> (access_token . YOUR_APP_ACCESS_TOKEN)

```
