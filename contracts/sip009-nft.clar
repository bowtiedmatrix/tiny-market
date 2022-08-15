
;; sip009-nft
;; <add a description here>

(impl-trait .sip009-nft-trait.sip009-nft-trait)

;; constants

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))

;; define non-fungible token
(define-non-fungible-token matrix-token uint)

;; data maps and vars

(define-data-var last-token-id uint u0)

;; read-only functions

;; implement get-last-token-id function
(define-read-only (get-last-token-id)
    (ok (var-get last-token-id))
)

;; implement get-token-uri function
(define-read-only (get-token-uri (token-id uint))
    ;; should return a link to metadata for the nft
    (ok none)
)

;; implement get-owner function
(define-read-only (get-owner (token-id uint))
    (ok (nft-get-owner? matrix-token token-id))
)

;; public functions

;; implement transfer function
(define-public (transfer (token-id uint) (sender principal) (recipient principal))
    ;; should assert that sender = tx-sender to prevent principals from transferring tokens they do not own
    (begin
        (asserts! (is-eq tx-sender sender) err-not-token-owner)
        (nft-transfer? matrix-token token-id sender recipient)
    )
)

;; implement mint function
(define-public (mint (recipient principal))
    (let 
        (
            ;; increments last-token-id variable by 1
            (token-id (+ (var-get last-token-id) u1))
        )
    
        ;; checks that the transaction sender is the owner, as only they should have permission to mint new NFTs
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (try! (nft-mint? matrix-token token-id recipient))
        (var-set last-token-id token-id)
        (ok token-id)
    )
    
)