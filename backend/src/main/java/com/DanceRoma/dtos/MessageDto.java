package com.DanceRoma.dtos;

import java.time.LocalDateTime;

public class MessageDto {

    private String message;
    private Long id;
    private UserDto sender;
    private UserDto receptor;
    private LocalDateTime date;

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

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public UserDto getSender() {
        return sender;
    }

    public void setSender(UserDto senderMail) {
        this.sender = senderMail;
    }

    public UserDto getReceptor() {
        return receptor;
    }

    public void setReceptor(UserDto receptorMail) {
        this.receptor = receptorMail;
    }
}