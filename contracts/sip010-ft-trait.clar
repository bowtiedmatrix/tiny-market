
;; sip010-ft-trait
;; <add a description here>

(define-trait sip010-ft-trait
    (
        ;; transfer
        (transfer (uint principal principal (optional (buff 34))) (response bool uint))

        ;; name
        (get-name () (response (string-ascii 32) uint))

        ;; symbol
        (get-symbol () (response (string-ascii 32) uint))

        ;; decimals
        (get-decimals () (response uint uint))

        ;; balance of
        (get-balance (principal) (response uint uint))

        ;; total supply
        (get-total-supply () (response uint uint))

        ;; token uri
        (get-token-uri () (response (optional (string-utf8 256)) uint))

    )
)
