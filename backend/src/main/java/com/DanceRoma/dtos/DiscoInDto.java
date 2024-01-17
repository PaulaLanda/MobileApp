package com.DanceRoma.dtos;


import java.util.List;

public class DiscoInDto {

    private Long id;
    private String name;
    private String address;
    private String userEmail;
    private String mondaySchedule;
    private String tuesdaySchedule;
    private String wednesdaySchedule;
    private String thursdaySchedule;
    private String fridaySchedule;
    private String saturdaySchedule;
    private String sundaySchedule;
    private List<TicketDto> ticketDtos;


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

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
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

    public List<TicketDto> getTicketDtos() {
        return ticketDtos;
    }

    public void setTicketDtos(List<TicketDto> ticketDtos) {
        this.ticketDtos = ticketDtos;
    }
}