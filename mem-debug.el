;; some code to debug memory leak
(setq
 hmz-last-cons-cells-consed cons-cells-consed
 hmz-last-floats-consed floats-consed
 hmz-last-vector-cells-consed vector-cells-consed
 hmz-last-symbols-consed symbols-consed
 hmz-last-string-chars-consed string-chars-consed
 hmz-last-misc-objects-consed misc-objects-consed
 hmz-last-intervals-consed intervals-consed
 hmz-last-strings-consed strings-consed
 )
(add-hook 'post-gc-hook
          (lambda ()
            (message "
                              cons-cells-consed: %s
                              floats-consed: %s
                              vector-cells-consed: %s
                              symbols-consed: %s
                              string-chars-consed: %s
                              misc-objects-consed: %s
                              intervals-consed: %s
                              strings-consed: %s"
                     (- hmz-last-cons-cells-consed cons-cells-consed)
                     (- hmz-last-floats-consed floats-consed)
                     (- hmz-last-vector-cells-consed vector-cells-consed)
                     (- hmz-last-symbols-consed symbols-consed)
                     (- hmz-last-string-chars-consed string-chars-consed)
                     (- hmz-last-misc-objects-consed misc-objects-consed)
                     (- hmz-last-intervals-consed intervals-consed)
                     (- hmz-last-strings-consed strings-consed))

            (setq
             hmz-last-cons-cells-consed cons-cells-consed
             hmz-last-floats-consed floats-consed
             hmz-last-vector-cells-consed vector-cells-consed
             hmz-last-symbols-consed symbols-consed
             hmz-last-string-chars-consed string-chars-consed
             hmz-last-misc-objects-consed misc-objects-consed
             hmz-last-intervals-consed intervals-consed
             hmz-last-strings-consed strings-consed
             )
            ))

(message "Garbage Collections: %s" gcs-done)
;; Go back to sane values
(setq gc-cons-threshold 1000000)
