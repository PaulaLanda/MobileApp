package com.DanceRoma.converters;

import com.DanceRoma.dtos.ClubDto;
import com.DanceRoma.dtos.DayDto;
import com.DanceRoma.dtos.TicketDto;
import com.DanceRoma.dtos.UserDto;
import com.DanceRoma.entities.Club;
import com.DanceRoma.entities.Day;
import com.DanceRoma.entities.Ticket;
import com.DanceRoma.entities.User;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class EntityToDtoConverter {

    public UserDto convert(User user) {
        UserDto dto = new UserDto();
        dto.setId(user.getId());
        dto.setNombre(user.getNombre());
        dto.setCorreo(user.getCorreo());
        dto.setApellido(user.getApellido());
        dto.setTipo(user.getTipo());
        dto.setContra(user.getContra());
        return dto;
    }

    public ClubDto convert(Club ent) {
        ClubDto dto = new ClubDto();
        dto.setId(ent.getId());
        dto.setNombre(ent.getNombre());
        dto.setDireccion(ent.getDireccion());
        dto.setHorario(convertDay(ent.getTimetable()));
        dto.setTickets(convertTicket(ent.getTickets()));
        return dto;
    }

    private List<DayDto> convertDay(List<Day> timetable) {
        List<DayDto> days = new ArrayList<DayDto>();
        DayDto dto;
        for(Day d:timetable){
            dto = new DayDto();
            dto.setId(d.getId());
            dto.setClubId(d.getClubId());
            dto.setDay(d.getDay());
            dto.setBegin(d.getBegin());
            dto.setEnd(d.getEnd());
            days.add(dto);
        }
        return days;
    }

    private List<TicketDto> convertTicket(List<Ticket> tickets) {
        List<TicketDto> ts = new ArrayList<TicketDto>();
        TicketDto dto;
        for(Ticket t:tickets){
            dto = new TicketDto();
            dto.setId(t.getId());
            dto.setClubId(t.getClubId());
            dto.setDefinition(t.getDef());
            dto.setAmount(t.getAmount());
            dto.setPrice(t.getPrice());
            ts.add(dto);
        }
        return ts;
    }
}
