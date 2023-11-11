;; (use-modules (haunt reader skribe))
(use-modules (haunt asset)
             (haunt builder blog)
             (haunt builder atom)
             (haunt builder assets)
             (haunt reader commonmark)
             (haunt site))

(site #:title "Notes"
      #:domain "carnotweat.github.io"
      #:default-metadata
      '((author . "Sameer Gupta")
        (email  . "jasitis@gmail.com"))
      #:readers (list commonmark-reader)
      #:builders (list (blog)
                       (atom-feed)
                       (atom-feeds-by-tag)
                        ;; (static-directory "images") ;
                       ))
