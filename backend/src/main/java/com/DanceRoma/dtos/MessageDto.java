package com.DanceRoma.dtos;

import java.sql.Date;

public class MessageDto {
    private String message;
    private Long id;
    private String senderMail;
    private String receptorMail;
    private Date date;

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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getSenderMail() {
        return senderMail;
    }

    public void setSenderMail(String senderMail) {
        this.senderMail = senderMail;
    }

    public String getReceptorMail() {
        return receptorMail;
    }

    public void setReceptorMail(String receptorMail) {
        this.receptorMail = receptorMail;
    }
}
