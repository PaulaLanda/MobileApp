package com.DanceRoma.dtos;


public class MessageInDto{

    private String message;
    private Long id;
    private Long senderId;
    private Long receptorId;
    private String date;

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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
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