package com.DanceRoma.dtos;

import jakarta.persistence.*;

public class TicketDto {

  private Long id;
  private String descripcion;
  private Integer precio;
  private Integer numeroCopas;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getDescripcion() {
    return descripcion;
  }

  public void setDescripcion(String descripcion) {
    this.descripcion = descripcion;
  }

  public Integer getPrecio() {
    return precio;
  }

  public void setPrecio(Integer precio) {
    this.precio = precio;
  }

  public Integer getNumeroCopas() {
    return numeroCopas;
  }

  public void setNumeroCopas(Integer numeroCopas) {
    this.numeroCopas = numeroCopas;
  }
}

