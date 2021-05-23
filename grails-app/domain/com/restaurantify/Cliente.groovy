package com.restaurantify

import groovy.transform.ToString

import java.time.LocalDate

/**
 * Clase dominio, que representa al Cliente.
 * El Cliente esta relacionado con el resto de Dominios,
 * ya que es el que realizara las operaciones. El cliente
 * tiene el rol que define las operaciones que puede realizar.
 * @author Martín Jesús Mañas Rivas
 * @since 5/04/2021
 * @version 1.0
 */
@ToString
class Cliente {
    // Columnas
    String nombre
    String apellidos
    String email
    String password
    String dni
    Integer cp
    String provincia
    String localidad
    String calle
    LocalDate fechaDeNacimiento
    LocalDate fechaDeAlta = LocalDate.now()
    String imagen = "img_usuario.png"
    Integer rol = 0 // Por defecto es usuario normal, 1 admin, 2 restaurante
    Boolean bloqueado = false
    Boolean verificado = false
    String token = ""

    // Restricciones
    static constraints = {
        nombre size: 1..30, blank: false
        apellidos size: 1..30, blank: false
        email maxSize: 320, email: true, blank: false, unique: true
        password size: 6..255, blank: false, password: true
        dni blank: false, unique: true, display: false
        provincia blank: false
        localidad blank: false
        calle blank: false
        fechaDeNacimiento date: true, max: LocalDate.now(), blank: false
        fechaDeAlta date: true, max: LocalDate.now()
        rol blank: false, inList: [0, 1] // 0 = usuario, 1 = admin
        token maxSize: 32
    }
}