(deffacts inventario
    (smartphone (producto-id 101) (marca apple) (modelo iPhone16) (color rojo) (precio 27000) (existencias 25))
    (smartphone (producto-id 102) (marca samsung) (modelo GalaxyS23) (color negro) (precio 22000) (existencias 30))
    (smartphone (producto-id 103) (marca xiaomi) (modelo RedmiNote13) (color azul) (precio 8500) (existencias 45))
    (smartphone (producto-id 104) (marca motorola) (modelo Edge50) (color plata) (precio 14000) (existencias 20))
    (smartphone (producto-id 105) (marca huawei) (modelo P60Pro) (color dorado) (precio 19500) (existencias 15))
    (smartphone (producto-id 106) (marca apple) (modelo iPhone15) (color azul) (precio 24000) (existencias 18))
    (smartphone (producto-id 107) (marca samsung) (modelo GalaxyA55) (color gris) (precio 12000) (existencias 28))
    (smartphone (producto-id 108) (marca xiaomi) (modelo PocoX6) (color negro) (precio 9800) (existencias 40))
    (smartphone (producto-id 109) (marca oppo) (modelo Reno11) (color verde) (precio 13000) (existencias 22))
    (smartphone (producto-id 110) (marca motorola) (modelo G54) (color azul) (precio 8900) (existencias 26))

    (computadora (producto-id 201) (marca apple) (modelo MacBookPro) (color gris) (precio 47000) (existencias 10))
    (computadora (producto-id 202) (marca hp) (modelo Pavilion15) (color negro) (precio 17000) (existencias 14))
    (computadora (producto-id 203) (marca lenovo) (modelo ThinkPadE14) (color negro) (precio 18500) (existencias 9))
    (computadora (producto-id 204) (marca dell) (modelo Inspiron3520) (color plata) (precio 19000) (existencias 12))
    (computadora (producto-id 205) (marca asus) (modelo VivoBook16) (color azul) (precio 16500) (existencias 15))
    (computadora (producto-id 206) (marca acer) (modelo Aspire5) (color gris) (precio 15500) (existencias 18))
    (computadora (producto-id 207) (marca apple) (modelo MacBookAir) (color plata) (precio 33000) (existencias 7))
    (computadora (producto-id 208) (marca hp) (modelo EnvyX360) (color dorado) (precio 28000) (existencias 5))
    (computadora (producto-id 209) (marca lenovo) (modelo IdeaPad3) (color gris) (precio 14500) (existencias 20))
    (computadora (producto-id 210) (marca dell) (modelo XPS13) (color blanco) (precio 41000) (existencias 6))
    (computadora (producto-id 211) (marca acer) (modelo Nitro5) (color negro) (precio 28500) (existencias 9))

    (accesorio (producto-id 301) (marca apple) (tipo funda) (color negro) (precio 350) (existencias 50))
    (accesorio (producto-id 302) (marca samsung) (tipo cargador) (color blanco) (precio 480) (existencias 40))
    (accesorio (producto-id 303) (marca xiaomi) (tipo audifonos) (color negro) (precio 700) (existencias 60))
    (accesorio (producto-id 304) (marca motorola) (tipo funda) (color azul) (precio 320) (existencias 35))
    (accesorio (producto-id 305) (marca apple) (tipo cableusb) (color blanco) (precio 290) (existencias 70))
    (accesorio (producto-id 306) (marca samsung) (tipo micas) (color transparente) (precio 150) (existencias 80))
    (accesorio (producto-id 307) (marca xiaomi) (tipo powerbank) (color gris) (precio 900) (existencias 25))
    (accesorio (producto-id 308) (marca huawei) (tipo cargador) (color blanco) (precio 450) (existencias 33))
    (accesorio (producto-id 309) (marca motorola) (tipo audifonos) (color negro) (precio 650) (existencias 55))
    (accesorio (producto-id 310) (marca apple) (tipo teclado) (color plata) (precio 2800) (existencias 12))
)

(deffacts cliente-tarjeta

    (cliente 
        (cliente-id 1)
        (nombre "Francisco Perez")
        (direccion "Av. Juarez 345, Guadalajara")
        (telefono 3312457890)
    )

    (cliente 
        (cliente-id 2)
        (nombre "Maria Lopez")
        (direccion "Calle Hidalgo 112, Zapopan")
        (telefono 3319874561)
    )

    (cliente 
        (cliente-id 3)
        (nombre "Juan Gonzalez")
        (direccion "Av. Patria 890, Tonala")
        (telefono 3321598745)
    )

    (cliente 
        (cliente-id 4)
        (nombre "Ana Torres")
        (direccion "Privada Reforma 25, Guadalajara")
        (telefono 3314789652)
    )

    (cliente 
        (cliente-id 5)
        (nombre "Luis Ramirez")
        (direccion "Col. Americana 78, Guadalajara")
        (telefono 3334781209)
    )

    (cliente 
        (cliente-id 6)
        (nombre "Fernanda Garcia")
        (direccion "Av. Naciones Unidas 145, Zapopan")
        (telefono 3326147895)
    )

    (cliente 
        (cliente-id 7)
        (nombre "Carlos Diaz")
        (direccion "Av. Vallarta 3000, Guadalajara")
        (telefono 3347851204)
    )

    (cliente 
        (cliente-id 8)
        (nombre "Laura Mendoza")
        (direccion "Calle Morelos 99, Tlaquepaque")
        (telefono 3314782215)
    )

    (cliente 
        (cliente-id 9)
        (nombre "Jorge Gutierrez")
        (direccion "Av. Lopez Mateos 200, Zapopan")
        (telefono 3314597820)
    )

    (cliente 
        (cliente-id 10)
        (nombre "Claudia Rivas")
        (direccion "Calle San Juan 120, Tonala")
        (telefono 3312489635)
    )

    (tarjetacred (banco banamex) (grupo visa) (cliente-id 1) (exp-date 01-12-25))
    (tarjetacred (banco bbva) (grupo mastercard) (cliente-id 3) (exp-date 01-07-26))
    (tarjetacred (banco santander) (grupo visa) (cliente-id 6) (exp-date 01-05-27))
    (tarjetacred (banco liverpool) (grupo visa) (cliente-id 4) (exp-date 01-09-25))
    (tarjetacred (banco hsbc) (grupo mastercard) (cliente-id 5) (exp-date 01-02-26))

)

