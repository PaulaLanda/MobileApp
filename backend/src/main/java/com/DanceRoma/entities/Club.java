package com.DanceRoma.entities;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "clubs")
public class Club {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nombre",nullable = false)
    private String nombre;


    @Column(name= "direccion",nullable = false)
    private String direccion;
    //No se que anotacion debo ponerle a las listas
    private List<Ticket> tickets;
    private List<Day> timetable;

    public List<Ticket> getTickets() {
        return tickets;
    }

    public void setTickets(List<Ticket> tickets) {
        this.tickets = tickets;
    }

    public List<Day> getTimetable() {
        return timetable;
    }

    public void setTimetable(List<Day> timetable) {
        this.timetable = timetable;
    }

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
}
