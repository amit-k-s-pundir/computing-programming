(module testing-plt-for-email mzscheme
  (require (lib "smtp.ss" "net")
           (lib "head.ss" "net"))
   
  (let ([from "sonupundir@gmail.org"]
        [to '("seekmit@hotmail.com")])
    (smtp-send-message 
     "smtp.googlemail.com"
     from
     to
     (standard-message-header from to null null "Hello, this is email from plt")
     (list
      "Hi Myself,"
      "I tried the example, and it worked!")
     #:port-no 465 #:auth-user "sonupundir@gmail.com"
     #:auth-passwd "a19m15i14t21" #:tls-encode   ports-ssl-ports)))
