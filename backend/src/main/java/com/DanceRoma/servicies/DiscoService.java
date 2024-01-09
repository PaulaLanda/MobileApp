package com.DanceRoma.servicies;

import com.DanceRoma.converters.DtoToEntityConverter;
import com.DanceRoma.dtos.DiscoInDto;
import com.DanceRoma.dtos.TicketDto;
import com.DanceRoma.entities.Disco;
import com.DanceRoma.entities.Ticket;
import com.DanceRoma.entities.User;
import com.DanceRoma.repositories.DiscoRepository;
import com.DanceRoma.repositories.TicketRepository;
import com.DanceRoma.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class DiscoService {

    @Autowired
    private DiscoRepository discoRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private DtoToEntityConverter dtoToEntityConverter;

    public List<Disco> findAll() {
        return (List<Disco>) discoRepository.findAll();
    }

    public List<Disco> findAllByUserId(Long id) throws Exception {
        Optional<User> user = userRepository.findById(id);
        if (user.isEmpty()) {
            throw new Exception("There is not any user with id <" + id + ">");
        }
        return discoRepository.findAllByUser_id(id);
    }

    public Disco create(DiscoInDto disco) throws Exception {
        Optional<User> owner = userRepository.findByEmail(disco.getUserEmail());
        if (owner.isEmpty()) {
            throw new Exception("Owner not found <" + disco.getUserEmail() + ">");
        }

        Optional<Disco> discoByName = discoRepository.findByName(disco.getName());
        if (discoByName.isPresent()) {
            throw new Exception("Already exists a disco with the name <" + disco.getName() + ">");
        }

        List<Ticket> tickets = new ArrayList<>();
        for(TicketDto ticketDto: disco.getTicketDtos()) {
            Optional<Ticket> existingTicket = ticketRepository.findByDescriptionAndPriceAndDrinksNumber(ticketDto.getDescription(), ticketDto.getPrice(), ticketDto.getDrinksNumber());

            if (existingTicket.isPresent()) {
                tickets.add(existingTicket.get());
            } else {
                Ticket toCreate = dtoToEntityConverter.convert(ticketDto);
                tickets.add(ticketRepository.save(toCreate));
            }
        }

        Disco toCreate = dtoToEntityConverter.convert(disco);
        toCreate.setUser(owner.get());
        toCreate.setTickets(tickets);
        return discoRepository.save(toCreate);
    }

    public Disco update(Long id, Disco toUpdate) throws Exception {
        Optional<Disco> disco = discoRepository.findById(id);
        if (disco.isEmpty()) {
            throw new Exception("There is not any disco with id <" + id + ">");
        }
        toUpdate.setId(id);
        return discoRepository.save(toUpdate);
    }
}
