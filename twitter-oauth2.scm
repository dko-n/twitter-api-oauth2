; oauth認証2.0 - twitter api
; https://developer.twitter.com/en/docs/basics/authentication/overview/application-only

(define-module twitter-oauth2
  (use rfc.http) (use rfc.json)
  (use rfc.uri) (use rfc.base64)
  (export get-bearer-token)
)

(select-module twitter-oauth2)

(define twitter-server "api.twitter.com")
(define oauth2-token "/oauth2/token")
(define query '(("grant_type" "client_credentials")))
(define content-type "application/x-www-form-urlencoded;charset=UTF-8")
(define success "200")
(define bearer-token-key "access_token")

; Export Proc
(define (get-bearer-token consumer-key consumer-secret-key)
  (get-value 
    (get-bearer-token-response twitter-server oauth2-token query 
      (base64-encode consumer-key consumer-secret-key)
    )
    bearer-token-key
  ) 
)

; Encode Base64.
(define (base64-encode consumer-key consumer-secret-key)
  (string-append "Basic " 
    (base64-encode-string 
      (string-append (uri-encode-string consumer-key) ":" (uri-encode-string consumer-secret-key))
      :line-width #f
    )
  )
)

; POST oauth2-token.
(define (get-bearer-token-response host path query base64)
  (receive (status header body) 
    (http-post host path query :secure #t :Authorization base64 :Content-Type content-type) status header body
      ; ここの処理ちょっとまだ迷っている
      ; (if (string=? status success)
        (parse-json-string body)
      ; )
  )
)

; find only bearer token S expression.
(define (get-value json key)
  (find (lambda (x) (string=? (car x) key)) json)
)

(provide "twitter-oauth2")