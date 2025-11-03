(deftemplate smartphone
    (slot producto-id)
    (slot marca)
    (slot modelo)
    (slot color)
    (slot precio)
    (slot existencias)
)

(deftemplate computadora
    (slot producto-id)
    (slot marca)
    (slot modelo)
    (slot color)
    (slot precio)
    (slot existencias)
)

(deftemplate accesorio
    (slot producto-id)
    (slot tipo)
    (slot marca)
    (slot color)
    (slot precio)
    (slot existencias)
)

(deftemplate cliente
    (slot cliente-id)
    (multislot nombre)
    (multislot direccion)
    (slot telefono)
)

(deftemplate tarjetacred
    (slot banco)
    (slot grupo)
    (slot cliente-id)
    (slot exp-date)
)

(deftemplate orden
    (slot cliente-id)
    (slot orden-id)
    (slot producto-id)
    (slot cantidad)
    (slot forma-pago)
)

(deftemplate vale
    (slot cliente-id)
    (slot vale-id)
    (slot tipo)
    (slot descuento)
)