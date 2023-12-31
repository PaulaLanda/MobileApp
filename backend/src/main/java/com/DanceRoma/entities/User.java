package com.DanceRoma.entities;

import jakarta.persistence.Entity;

import jakarta.persistence.*;

@Entity
@Table(name = "usuarios")
public class User {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "nombre",nullable = false)
  private String nombre;


  @Column(name= "apellido",nullable = false)
  private String apellido;

  @Column(name = "contrasena",unique = true,nullable = false)
  private String contrasena;


  @Column(name = "correo")
  private String correo;

  @Column(name="TIPO_USUARIO")
  private String tipo;

  // Getters y setters

  public String getCorreo() {
    return correo;
  }

  public void setCorreo(String correo) {
    this.correo = correo;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getNombre() {
    return nombre;
  }

  public void setNombre(String nombre) {
    this.nombre = nombre;
  }

  public String getApellido() {
    return apellido;
  }

  public void setApellido(String apellido) {
    this.apellido = apellido;
  }

  public String getTipo() {
    return tipo;
  }

  public void setTipo(String tipo) {
    this.tipo = tipo;
  }

}

