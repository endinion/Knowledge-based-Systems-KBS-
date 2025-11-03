(deffunction crear-vale (?cid ?tipo ?desc)
  (bind ?vid (gensym*))
  (assert (vale (cliente-id ?cid)
                (vale-id ?vid)
                (tipo ?tipo)
                (descuento ?desc)))
  (printout t "[VALE] Cliente " ?cid " ← " ?tipo " = " ?desc
             (if (str-index "porcentaje" (sym-cat ?tipo))
                 then "%"
                 else "$")
             " (vale-id " ?vid ")" crlf)
  ?vid)
