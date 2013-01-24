(define (bind-socket addr port unixsocket uid gid mode)
    (let ((fcgi-in (socket af/inet sock/stream))
          (fcgi-un (socket af/unix sock/stream)))
      (if (unixsocket)
          (unix-listen unixsocket)
          

