;; deal with voiced/unvoiced consonants.

(set!
 ru_vpair_list
 '((b p)
   (bb pp)
   (p b)
   (pp bb)
   (v f)
   (vv ff)
   (f v)
   (ff vv)
   (g k)
   (gg kk)
   (k g)
   (kk gg)
   (d t)
   (dd tt)
   (t d)
   (tt dd)
   (zh sh)
   (sh zh)
   (z s)
   (zz ss)
   (s z)
   (ss zz)))

(define (ru_has_vpair s)
  (if (assoc_string (item.name s) ru_vpair_list)
      "1"
      "0"))

(set!
 ru_vpair_tree
 '((ph_cvox is +)
   ((R:Transcription.n.name is 0)
    ((R:SylStructure.parent.parent.R:Word.gpos is proc)
     ((n.ph_cvox is -)
      ((Y))
      ((N)))
     ((n.ph_cvox is +)
      ((n.name is v)
       ((nn.ph_cvox is +)
        ((nn.name is v)
         ((Y))
         ((nn.name is vv)
          ((Y))
          ((nn.lisp_ru_has_vpair is 1)
           ((N))
           ((Y)))))
        ((Y)))
       ((n.name is vv)
        ((nn.ph_cvox is +)
         ((nn.name is v)
          ((Y))
          ((nn.name is vv)
           ((Y))
           ((nn.lisp_ru_has_vpair is 1)
            ((N))
            ((Y)))))
         ((Y)))
        ((n.lisp_ru_has_vpair is 1)
         ((N))
         ((Y)))))
      ((Y))))
    ((n.ph_cvox is -)
     ((Y))
     ((N))))
   ((R:Transcription.n.name is 0)
    ((R:SylStructure.parent.parent.R:Word.gpos is proc)
     ((n.ph_cvox is +)
      ((n.name is v)
       ((N))
       ((n.name is vv)
        ((N))
        ((n.lisp_ru_has_vpair is 1)
         ((Y))
         ((N)))))
      ((N)))
     ((n.ph_cvox is +)
      ((n.name is v)
       ((nn.ph_cvox is +)
        ((nn.name is v)
         ((N))
         ((nn.name is vv)
          ((N))
          ((nn.lisp_ru_has_vpair is 1)
           ((Y))
           ((N)))))
        ((N)))
       ((n.name is vv)
        ((nn.ph_cvox is +)
         ((nn.name is v)
          ((N))
          ((nn.name is vv)
           ((N))
           ((nn.lisp_ru_has_vpair is 1)
            ((Y))
            ((N)))))
         ((N)))
        ((n.lisp_ru_has_vpair is 1)
         ((Y))
         ((N)))))
      ((N))))
    ((n.ph_cvox is +)
     ((n.name is v)
      ((N))
      ((n.name is vv)
       ((N))
       ((n.lisp_ru_has_vpair is 1)
        ((Y))
        ((N)))))
     ((N))))))

(define (ru_correct_consonants utt)
  (let ((s) (p))
    (set! s (utt.relation.last utt 'Segment))
    (while
     s
     (set! p (assoc_string (item.name s) ru_vpair_list))
     (if
      (and
       p
       (string-equal (wagon_predict s ru_vpair_tree) "Y"))
      (item.set_name s (cadr p)))
     (set! s (item.prev s)))))

(provide 'ru_consonant_vpairs)