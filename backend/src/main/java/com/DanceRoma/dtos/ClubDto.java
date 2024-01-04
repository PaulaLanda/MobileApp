package com.DanceRoma.dtos;

import java.util.List;

public class ClubDto {

    private Long id;
    private String nombre;
    private String direccion;
    private List<TicketDto> tickets;
    private List<DayDto> horario;

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

    public List<TicketDto> getTickets() {
        return tickets;
    }

    public void setTickets(List<TicketDto> tickets) {
        this.tickets = tickets;
    }

    public List<DayDto> getHorario() {
        return horario;
    }

    public void setHorario(List<DayDto> horario) {
        this.horario = horario;
    }
}
