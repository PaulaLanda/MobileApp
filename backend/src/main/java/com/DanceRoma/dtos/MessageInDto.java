package com.DanceRoma.dtos;

import java.time.LocalDate;

public class MessageInDto{

    private String message;
    private Long id;
    private Long senderId;
    private Long receptorId;
    private LocalDate date;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Long getSenderMail() {
        return senderId;
    }

    public void setSenderMail(Long senderMail) {
        this.senderId = senderMail;
    }

    public Long getReceptorMail() {
        return receptorId;
    }

    public void setReceptorMail(Long receptorMail) {
        this.receptorId = receptorMail;
    }
}