package com.DanceRoma.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "ticket")
public class Ticket {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "description")
  private String description;

  @Column(name= "price", nullable = false)
  private Integer price;

  @Column(name = "drinks_number", nullable = false)
  private Integer drinksNumber;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public Integer getPrice() {
    return price;
  }

  public void setPrice(Integer price) {
    this.price = price;
  }

  public Integer getDrinksNumber() {
    return drinksNumber;
  }

  public void setDrinksNumber(Integer drinksNumber) {
    this.drinksNumber = drinksNumber;
  }
}

