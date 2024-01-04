package com.DanceRoma.dtos;

public class DayDto {
    //Monday, tuesday, etc...
    private String day;
    //CLOSED or 23:00 (example)
    private String begin;
    //Can be null if begin=closed
    private String end;
    private Long id;
    private Long clubId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getClubId() {
        return clubId;
    }

    public void setClubId(Long clubId) {
        this.clubId = clubId;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getBegin() {
        return begin;
    }

    public void setBegin(String begin) {
        this.begin = begin;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }



}
