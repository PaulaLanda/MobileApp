package com.DanceRoma.dtos;

public class ReviewInDto {

    private Long id;
    private Long userId;
    private Long discoId;
    private String message;
    private String photoUrl;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getDiscoId() {
        return discoId;
    }

    public void setDiscoId(Long discoId) {
        this.discoId = discoId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }
}
