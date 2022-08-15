
;; sip010-token
;; <add a description here>

(impl-trait .sip010-ft-trait.sip010-ft-trait)

;; constants

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))

;; define fungible token
(define-fungible-token bubbles-token)

;; data maps and vars
;;

;; read-only functions

;; get-name function
(define-read-only (get-name)
    (ok "Bubbles Token")
)

;; get-symbol function
(define-read-only (get-symbol)
    (ok "$BUB")
)

;; get-decimals function
(define-read-only (get-decimals)
    (ok u6)
)

;; get-balance function
(define-read-only (get-balance (owner principal))
    (begin
        (ok (ft-get-balance bubbles-token owner))
    )
)

;; get-total-supply function
(define-read-only (get-total-supply)
    (ok (ft-get-supply bubbles-token))
)

;; get-token-uri function
(define-read-only (get-token-uri)
    ;; should return a link to metadata for the nft
    (ok none)
)

;; public functions

;; mint function
(define-public (mint (amount uint) (recipient principal))
     ;; checks that the transaction sender is the owner, as only they should have permission to mint new FTs
    (begin
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (ft-mint? bubbles-token amount recipient)
    )
)

;; transfer function
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
    ;; should assert that sender = tx-sender to prevent principals from transferring tokens they do not own
    (if (is-eq tx-sender sender) 
        (begin
            (try! (ft-transfer? bubbles-token amount sender recipient))
            (print memo)
            (ok true)
        )
        (err u4)
    )
)


