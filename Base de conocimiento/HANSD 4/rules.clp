(defrule caminar-a-caja
  (declare (salience 40))
  (mono-pos (lugar ?m))
  (caja-pos (lugar ?c))
  (test (neq ?m ?c))
  =>
  (printout t "[ACCION] El mono camina de " ?m " a " ?c crlf)
  (retract (mono-pos (lugar ?m)))
  (assert (mono-pos (lugar ?c)))
)

(defrule empujar-caja-a-banana
  (declare (salience 35))
  (mono-pos (lugar ?c))
  (caja-pos (lugar ?c))
  (banana-pos (lugar ?b))
  (test (neq ?c ?b))
  (mono-altura (nivel suelo))
  =>
  (printout t "[ACCION] El mono empuja la caja de " ?c " a " ?b crlf)
  (retract (caja-pos (lugar ?c)))
  (assert (caja-pos (lugar ?b)))
  (retract (mono-pos (lugar ?c)))
  (assert (mono-pos (lugar ?b)))
)

(defrule subir-a-la-caja
  (declare (salience 30))
  (mono-pos (lugar ?x))
  (caja-pos (lugar ?x))
  (banana-pos (lugar ?x))
  (mono-altura (nivel suelo))
  =>
  (printout t "[ACCION] El mono se sube a la caja en " ?x crlf)
  (retract (mono-altura (nivel suelo)))
  (assert (mono-altura (nivel caja)))
)

(defrule tomar-banana
  (declare (salience 25))
  (mono-pos (lugar ?x))
  (caja-pos (lugar ?x))
  (banana-pos (lugar ?x))
  (mono-altura (nivel caja))
  (tiene-banana (valor no))
  =>
  (printout t "[ACCION] El mono toma la banana en " ?x " 🍌" crlf)
  (retract (tiene-banana (valor no)))
  (assert (tiene-banana (valor si)))
)

(defrule meta
  (declare (salience 100))
  (tiene-banana (valor si))
  =>
  (printout t "[META] ¡El mono ya tiene la banana!" crlf)
  (halt)
)