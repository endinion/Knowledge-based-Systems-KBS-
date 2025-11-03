(defrule caminar-a-caja
  ?mp <- (mono-pos (lugar ?m))
  (caja-pos (lugar ?c))
  (test (neq ?m ?c))
  =>
  (printout t "[ACCION] El mono camina de " ?m " a " ?c crlf)
  (modify ?mp (lugar ?c))
)

(defrule empujar-caja-a-banana
  ?mp <- (mono-pos (lugar ?c))
  ?cp <- (caja-pos (lugar ?c))
  (banana-pos (lugar ?b))
  (test (neq ?c ?b))
  (mono-altura (nivel suelo))
  =>
  (printout t "[ACCION] El mono empuja la caja de " ?c " a " ?b crlf)
  (modify ?cp (lugar ?b))
  (modify ?mp (lugar ?b))
)

(defrule subir-a-la-caja
  (mono-pos (lugar ?x))
  (caja-pos (lugar ?x))
  (banana-pos (lugar ?x))
  ?alt <- (mono-altura (nivel suelo))
  =>
  (printout t "[ACCION] El mono se sube a la caja en " ?x crlf)
  (modify ?alt (nivel caja))
)

(defrule tomar-banana
  (mono-pos (lugar ?x))
  (caja-pos (lugar ?x))
  (banana-pos (lugar ?x))
  (mono-altura (nivel caja))
  ?tb <- (tiene-banana (valor no))
  =>
  (printout t "[ACCION] El mono toma la banana en " ?x " 🍌" crlf)
  (modify ?tb (valor si))
)

(defrule meta
  (tiene-banana (valor si))
  =>
  (printout t "[META] ¡El mono ya tiene la banana!" crlf)
  (halt)
)