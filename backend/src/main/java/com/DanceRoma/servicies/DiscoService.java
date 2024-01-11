package com.DanceRoma.servicies;

import com.DanceRoma.converters.DtoToEntityConverter;
import com.DanceRoma.dtos.DiscoInDto;
import com.DanceRoma.dtos.TicketDto;
import com.DanceRoma.entities.Disco;
import com.DanceRoma.entities.Review;
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

    /**
     * Returns a list with all discos
     * @return list with all discos
     */
    public List<Disco> findAll() {
        return (List<Disco>) discoRepository.findAll();
    }

    /**
     * Returns all the discos that a user has marked as favourites
     * @param id of the user
     * @return list with the discos
     * @throws Exception if there's no user with that id
     */
    public List<Disco> findAllByUserId(Long id) throws Exception {
        Optional<User> user = userRepository.findById(id);
        if (user.isEmpty()) {
            throw new Exception("There is not any user with id <" + id + ">");
        }
        return discoRepository.findAllByUser_id(id);
    }

    /**
     * Creates a disco by passing a DiscoInDto instance
     * @param disco with properties
     * @return the created Disco instance
     * @throws Exception if the owner does not exist, already is a disco
     * with that name
     */
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

    /**
     * Updates some aspect of a disco
     * @param id of the disco to update
     * @param disco disco with desired parameters
     * @return Disco instance with new properties
     * @throws Exception no disco exists with that id
     */
    public Disco update(Long id, DiscoInDto disco) throws Exception {
        Optional<User> owner = userRepository.findById(id);
        if (owner.isEmpty()) {
            throw new Exception("Owner not found with id <" + disco.getId() + ">");
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

        Disco toUpdate = dtoToEntityConverter.convert(disco);
        toUpdate.setId(disco.getId());
        toUpdate.setUser(owner.get());
        toUpdate.setTickets(tickets);
        return discoRepository.save(toUpdate);
    }

    public List<Disco> addToFav(Disco d, Long id) throws Exception {
        Optional<User> user = userRepository.findById(id);
        if (user.isEmpty()) {
            throw new Exception("There is not any user with id <" + id + ">");
        }
        List<Disco> l = findAllByUserId(id);
        if(l.contains(d))
            throw new Exception("Disco with name "+ d.getName()+" already in fav");
        l.add(d);
        return l;
    }

    public List<Disco> deleteFromFav(Disco d, Long id) throws Exception {
        Optional<User> user = userRepository.findById(id);
        if (user.isEmpty()) {
            throw new Exception("There is not any user with id <" + id + ">");
        }
        List<Disco> l = findAllByUserId(id);
        if(!l.contains(d))
            throw new Exception("Disco with name "+ d.getName()+" not in fav");
        l.remove(d);
        return l;
    }


}
