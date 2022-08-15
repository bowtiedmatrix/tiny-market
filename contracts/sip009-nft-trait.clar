
;; sip009-nft-trait
;; <add a description here>

(define-trait sip009-nft-trait
    (
        ;; last token id, limited to uint range 
        (get-last-token-id () (response uint uint))
        
        ;; URI for metadata associated with the token
        (get-token-uri (uint) (response (optional (string-ascii 256)) uint))

        ;; owner of a given token identifier
        (get-owner (uint) (response (optional principal) uint))

        ;; transfer form the sender to a new principal
        (transfer (uint principal principal) (response bool uint))
    )
)

;; constants
;;

;; data maps and vars
;;

;; private functions
;;

;; public functions
;;
