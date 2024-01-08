package com.DanceRoma.dtos;

import java.util.List;

public class DiscoDto {

    private Long id;
    private String nombre;
    private String direccion;
    private UserDto userDto;
    private String horarioLunes;
    private String horarioMartes;
    private String horarioMiercoles;
    private String horarioJueves;
    private String horarioViernes;
    private String horarioSabado;
    private String horarioDomingo;
    private List<TicketDto> ticketDtos;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public UserDto getUserDto() {
        return userDto;
    }

    public void setUserDto(UserDto userDto) {
        this.userDto = userDto;
    }

    public String getHorarioLunes() {
        return horarioLunes;
    }

    public void setHorarioLunes(String horarioLunes) {
        this.horarioLunes = horarioLunes;
    }

    public String getHorarioMartes() {
        return horarioMartes;
    }

    public void setHorarioMartes(String horarioMartes) {
        this.horarioMartes = horarioMartes;
    }

    public String getHorarioMiercoles() {
        return horarioMiercoles;
    }

    public void setHorarioMiercoles(String horarioMiercoles) {
        this.horarioMiercoles = horarioMiercoles;
    }

    public String getHorarioJueves() {
        return horarioJueves;
    }

    public void setHorarioJueves(String horarioJueves) {
        this.horarioJueves = horarioJueves;
    }

    public String getHorarioViernes() {
        return horarioViernes;
    }

    public void setHorarioViernes(String horarioViernes) {
        this.horarioViernes = horarioViernes;
    }

    public String getHorarioSabado() {
        return horarioSabado;
    }

    public void setHorarioSabado(String horarioSabado) {
        this.horarioSabado = horarioSabado;
    }

    public String getHorarioDomingo() {
        return horarioDomingo;
    }

    public void setHorarioDomingo(String horarioDomingo) {
        this.horarioDomingo = horarioDomingo;
    }

    public List<TicketDto> getTicketDtos() {
        return ticketDtos;
    }

    public void setTicketDtos(List<TicketDto> ticketDtos) {
        this.ticketDtos = ticketDtos;
    }
}
