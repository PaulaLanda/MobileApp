package com.DanceRoma.dtos;

public class TicketDto {

  private Long id;
  private String description;
  private Integer price;
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

