package com.DanceRoma.entities;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "disco")
public class Disco {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "name", unique = true, nullable = false)
  private String name;

  @Column(name= "address", nullable = false)
  private String address;

  @ManyToOne
  @JoinColumn(name = "user_id")
  private User user;

  @Column(name = "monday_schedule", nullable = false)
  private String mondaySchedule;

  @Column(name = "tuesday_schedule", nullable = false)
  private String tuesdaySchedule;

  @Column(name = "wednesday_schedule", nullable = false)
  private String wednesdaySchedule;

  @Column(name = "thursday_schedule", nullable = false)
  private String thursdaySchedule;

  @Column(name = "friday_schedule", nullable = false)
  private String fridaySchedule;

  @Column(name = "saturday_schedule", nullable = false)
  private String saturdaySchedule;

  @Column(name = "sunday_schedule", nullable = false)
  private String sundaySchedule;

  @ManyToMany(mappedBy = "favoriteDiscos")
  private List<User> favoritedByUsers;

  @OneToMany(mappedBy = "disco")
  private List<Review> reviews;

  @Column(name="photoUrl")
  private String photoUrl;

  @ManyToMany
  @JoinTable(
          name = "disco_ticket",
          joinColumns = @JoinColumn(name = "disco_id"),
          inverseJoinColumns = @JoinColumn(name = "ticket_id")
  )
  private List<Ticket> tickets;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public String getMondaySchedule() {
    return mondaySchedule;
  }

  public void setMondaySchedule(String mondaySchedule) {
    this.mondaySchedule = mondaySchedule;
  }

  public String getTuesdaySchedule() {
    return tuesdaySchedule;
  }

  public void setTuesdaySchedule(String tuesdaySchedule) {
    this.tuesdaySchedule = tuesdaySchedule;
  }

  public String getWednesdaySchedule() {
    return wednesdaySchedule;
  }

  public void setWednesdaySchedule(String wednesdaySchedule) {
    this.wednesdaySchedule = wednesdaySchedule;
  }

  public String getThursdaySchedule() {
    return thursdaySchedule;
  }

  public void setThursdaySchedule(String thursdaySchedule) {
    this.thursdaySchedule = thursdaySchedule;
  }

  public String getFridaySchedule() {
    return fridaySchedule;
  }

  public void setFridaySchedule(String fridaySchedule) {
    this.fridaySchedule = fridaySchedule;
  }

  public String getSaturdaySchedule() {
    return saturdaySchedule;
  }

  public void setSaturdaySchedule(String saturdaySchedule) {
    this.saturdaySchedule = saturdaySchedule;
  }

  public String getSundaySchedule() {
    return sundaySchedule;
  }

  public void setSundaySchedule(String sundaySchedule) {
    this.sundaySchedule = sundaySchedule;
  }

  public List<Ticket> getTickets() {
    return tickets;
  }

  public void setTickets(List<Ticket> tickets) {
    this.tickets = tickets;
  }
  //flag
  public List<Review> getReviews() {
    return reviews;
  }

  public void setReviews(List<Review> reviews) {
    this.reviews = reviews;
  }

  public String getPhotoUrl() {
    return photoUrl;
  }

  public void setPhotoUrl(String photoUrl) {
    this.photoUrl = photoUrl;
  }
}