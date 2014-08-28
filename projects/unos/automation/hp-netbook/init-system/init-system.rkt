;#lang racket

(module initialize-system racket
  (provide initialize-system)

(define (mount source dest . options)
  (let ((cmd (~a 'mount  (apply ~a "" options #:separator " --")
		 source dest #:separator " ")))
    (process cmd)))
  
(define (initialize-system)
  (map set-up '(mounts networking)))

(define (! cmd options . args)
  (let ((real-cmd (~a cmd options (apply ~a args #:separator " ")
		      #:separator " ")))
;    real-cmd
    (process real-cmd)
))

(define (!/sudo cmd options . args)
  (let ((real-cmd (~a "echo sonu | sudo -S " cmd options (apply ~a
								args
								#:separator
								" ")
		      #:separator " ")))
;    real-cmd
    (process real-cmd)
))

(define (set-up x)
  (case x
    ((mounts)
     (mount /dev/sda5 /mnt/debian)
     (mount 192.168.1.10:/nfs/opt /mnt/nfs/opt)
     (mount /opt /export/opt bind)
     (mount /mnt/debian /export/mnt/debian bind)

     (let ((cmd (string-append ))
	   (mount-spec '((/dev/sda5 /mnt/debian) (/opt /export/opt
						       --bind) (
		
  
)
