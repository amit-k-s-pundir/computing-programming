 ; In "toy-store-sig.ss":
  #lang scheme
  
  (define-signature toy-store^
    (store-color     ; (-> symbol?)
     stock!          ; (integer? -> void?)
     get-inventory)) ; (-> (listof toy?))
  
  (provide toy-store^)