; 1) Verificar stock
(defrule verificar-stock
   (orden (orden-id ?oid) (producto-id ?pid) (cantidad ?c))
   (or (smartphone (producto-id ?pid) (existencias ?e))
       (computadora (producto-id ?pid) (existencias ?e))
       (accesorio  (producto-id ?pid) (existencias ?e)))
   (test (> ?c ?e))
 =>
   (printout t "[ERROR] Stock insuficiente para producto " ?pid
                 " (ord " ?oid ", pide " ?c ", hay " ?e ")" crlf)
)

; 3) Smartphone
(defrule descontar-inv-smartphone
  (declare (salience -50))
  ?o <- (orden (orden-id ?oid) (producto-id ?id) (cantidad ?c))
  ?s <- (smartphone (producto-id ?id) (existencias ?e) (modelo ?m) (color ?co))
  (test (<= ?c ?e))
=>
  (modify ?s (existencias (- ?e ?c)))
  (printout t "[ORDEN " ?oid "] Existencias de " ?m " " ?co
              " antes: " ?e ", ahora: " (- ?e ?c) crlf)
  (retract ?o))

; 4) Computadora 
(defrule descontar-inv-computadora
  (declare (salience -50))
  ?o <- (orden (orden-id ?oid) (producto-id ?id) (cantidad ?c))
  ?s <- (computadora (producto-id ?id) (existencias ?e) (modelo ?m))
  (test (<= ?c ?e))
=>
  (modify ?s (existencias (- ?e ?c)))
  (printout t "[ORDEN " ?oid "] Existencias de computadora " ?m
              " antes: " ?e ", ahora: " (- ?e ?c) crlf)
  (retract ?o))

; 5) Accesorio
(defrule descontar-inv-accesorio
  (declare (salience -50))
  ?o <- (orden (orden-id ?oid) (producto-id ?id) (cantidad ?c))
  ?s <- (accesorio (producto-id ?id) (existencias ?e) (tipo ?t) (marca ?m))
  (test (<= ?c ?e))
=>
  (modify ?s (existencias (- ?e ?c)))
  (printout t "[ORDEN " ?oid "] Existencias " ?t " " ?m
              " antes: " ?e ", ahora: " (- ?e ?c) crlf)
  (retract ?o))


; 6) Clasificar mayorista
(defrule clasificar-mayorista
  (orden (cliente-id ?cid) (cantidad ?qty&:(> ?qty 10)))
 =>
  (printout t "[CLASIF] Cliente " ?cid " -> MAYORISTA (cantidad " ?qty ")" crlf)
)

; 7) Clasificar menudista
(defrule clasificar-menudista
  (orden (cliente-id ?cid) (cantidad ?qty&:(<= ?qty 10)))
 =>
  (printout t "[CLASIF] Cliente " ?cid " -> MENUDISTA (cantidad " ?qty ")" crlf)
)

; 8) Banamex + iPhone
(defrule banamex-iphone
  (orden (cliente-id ?cid) (producto-id ?pid) (forma-pago tarjeta))
  (smartphone (producto-id ?pid) (marca apple))
  (tarjetacred (cliente-id ?cid) (banco banamex))
 =>
  (printout t "[PROMO] Cliente " ?cid
     " - iPhone/Apple: 12 MSI con tarjeta Banamex." crlf)
)

; 9) Accesorio 50% misma marca 
(defrule descuento-accesorio-50-misma-marca
  (declare (salience 5))
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?id1))
  (orden (orden-id ?oid) (producto-id ?id2))
  (smartphone (producto-id ?id1) (marca ?brand))
  (accesorio  (producto-id ?id2) (marca ?brand))
  (test (and (neq ?id1 ?id2)
             (>= ?id1 100) (<= ?id1 199)
             (>= ?id2 300) (<= ?id2 399)))
 =>
  (crear-vale ?cid promo-marca 50)
  (printout t "[PROMO] Orden " ?oid
            " - Celular + accesorio marca " ?brand
            ": accesorio al 50%." crlf)
)

; 10) Vale $500 por subtotal alto 
(defrule vale-subtotal-alto-500
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?pid) (cantidad ?c))
  (or (smartphone (producto-id ?pid) (precio ?p))
      (computadora (producto-id ?pid) (precio ?p))
      (accesorio  (producto-id ?pid) (precio ?p)))
  (test (>= (* ?p ?c) 20000))
 =>
  (crear-vale ?cid subtotal-500 500)
  (printout t "[PROMO] Orden " ?oid
            " - Subtotal " (* ?p ?c) " ≥ 20000 → vale $500." crlf)
)

; 11) Aviso de vales por cliente 
(defrule aviso-vales-cliente
  (cliente (cliente-id ?cid) (nombre $?nombre))
  (vale (cliente-id ?cid) (vale-id ?vid) (tipo ?t) (descuento ?d))
 =>
  (printout t "[AVISO] Cliente " (implode$ ?nombre)
             " (ID " ?cid ") tiene un vale disponible: "
             ?t " = " ?d
             (if (eq ?t porcentaje) then "%" else "$") crlf)
)

; 12) Accesorio 5 o más iguales → 40% 
(defrule desc-40-accesorio-5-iguales
  (declare (salience 30))
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?pid) (cantidad ?q&:(>= ?q 5)))
  (accesorio (producto-id ?pid) (precio ?p))
 =>
  (crear-vale ?cid porcentaje-40 40)
  (printout t "[PROMO] Orden " ?oid
            " - Accesorio x" ?q " → 40% de descuento (vale emitido)." crlf)
)

; 13) Promo lenovo + liverpool
(defrule computadora-liverpool
  (orden (cliente-id ?cid) (producto-id ?pid) (forma-pago tarjeta))
  (computadora (producto-id ?pid) (marca lenovo))
  (tarjetacred (cliente-id ?cid) (banco liverpool))
 =>
  (printout t "[PROMO] Cliente " ?cid
     " - lenovo: 24 MSI con tarjeta liverpool." crlf)
)

; 14) Promo dell + bbva
(defrule descuento-dell
  (orden (cliente-id ?cid) (producto-id ?pid) (forma-pago tarjeta))
  (computadora (producto-id ?pid) (marca dell))
  (tarjetacred (cliente-id ?cid) (banco bbva))
 =>
  (printout t "[PROMO] Cliente " ?cid
     " - DELL: 12 MSI con tarjeta BBVA." crlf)
)

; 15) Descuento por volumen en computadoras (5+)
(defrule descuento-computadora
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?pid) (cantidad ?can&:(>= ?can 5)))
  (computadora (producto-id ?pid))
 =>
  (printout t "[PROMO] Cliente " ?cid
     " en la compra de mas de 5 computadoras obtiene un 5% de descuento" crlf)
)


; 16) Xiaomi + BBVA → 10% 
(defrule desc-xiaomi-bbva-10
  (declare (salience 50))
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?pid) (forma-pago tarjeta))
  (smartphone (producto-id ?pid) (marca xiaomi))
  (tarjetacred (cliente-id ?cid) (banco bbva))
=>
  (crear-vale ?cid porcentaje-10 10)
  (printout t "[PROMO] Orden " ?oid " - Xiaomi + BBVA → 10% de descuento (vale emitido)." crlf))

; 17) Motorola + HSBC → 15% 
(defrule desc-motorola-hsbc-15
  (declare (salience 50))
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?pid) (forma-pago tarjeta))
  (smartphone (producto-id ?pid) (marca motorola))
  (tarjetacred (cliente-id ?cid) (banco hsbc))
=>
  (crear-vale ?cid porcentaje-15 15)
  (printout t "[PROMO] Orden " ?oid " - Motorola + HSBC → 15% de descuento (vale emitido)." crlf))

; 18) Combo Samsung + Cargador (mismo pedido) → 20%
(defrule combo-samsung-cargador-20
  (declare (salience 50))
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?ph))
  (orden (orden-id ?oid) (producto-id ?ac))
  (smartphone (producto-id ?ph) (marca samsung))
  (accesorio  (producto-id ?ac) (tipo cargador))
  (test (neq ?ph ?ac))
=>
  (crear-vale ?cid porcentaje-20 20)
  (printout t "[PROMO] Orden " ?oid " - Samsung + cargador → 20% (vale emitido)." crlf))

; 19) Combo funda + micas (mismo pedido) → vale $100
(defrule combo-funda-micas-100
  (declare (salience 50))
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?a1))
  (orden (orden-id ?oid) (producto-id ?a2))
  (accesorio (producto-id ?a1) (tipo funda))
  (accesorio (producto-id ?a2) (tipo micas))
  (test (neq ?a1 ?a2))
=>
  (crear-vale ?cid monto-100 100)
  (printout t "[PROMO] Orden " ?oid " - Combo funda+micas → vale $100 (vale emitido)." crlf))

; 20) Teclado (accesorio) 2 o más → vale $150
(defrule teclado-2u-vale150
  (declare (salience 50))
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?pid) (cantidad ?q&:(>= ?q 2)))
  (accesorio (producto-id ?pid) (tipo teclado))
=>
  (crear-vale ?cid monto-150 150)
  (printout t "[PROMO] Orden " ?oid " - Teclado x" ?q " → vale $150 (vale emitido)." crlf))

; 21) Computadora Apple con subtotal de línea ≥ 40000 → 5%
(defrule mac-subtotal-40000-5
  (declare (salience 50))
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?pid) (cantidad ?c))
  (computadora (producto-id ?pid) (marca apple) (precio ?p))
  (test (>= (* ?p ?c) 40000))
=>
  (crear-vale ?cid porcentaje-5 5)
  (printout t "[PROMO] Orden " ?oid " - Mac subtotal " (* ?p ?c) " ≥ 40000 → 5% (vale emitido)." crlf))

; 22) Smartphone color negro + micas transparentes (mismo pedido) → 10%
(defrule negro-mas-micas-10
  (declare (salience 50))
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?ph))
  (orden (orden-id ?oid) (producto-id ?mk))
  (smartphone (producto-id ?ph) (color negro))
  (accesorio  (producto-id ?mk) (tipo micas) (color transparente))
  (test (neq ?ph ?mk))
=>
  (crear-vale ?cid porcentaje-10 10)
  (printout t "[PROMO] Orden " ?oid " - Smartphone negro + micas transparentes → 10% (vale emitido)." crlf))

; 23) Audífonos Xiaomi (2 o más) → 15%
(defrule audifonos-xiaomi-2-15
  (declare (salience 50))
  (orden (orden-id ?oid) (cliente-id ?cid) (producto-id ?pid) (cantidad ?q&:(>= ?q 2)))
  (accesorio (producto-id ?pid) (tipo audifonos) (marca xiaomi))
=>
  (crear-vale ?cid porcentaje-15 15)
  (printout t "[PROMO] Orden " ?oid " - Audífonos Xiaomi x" ?q " → 15% (vale emitido)." crlf))
