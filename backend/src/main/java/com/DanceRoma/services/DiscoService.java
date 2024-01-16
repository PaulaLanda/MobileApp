package com.DanceRoma.services;

import com.DanceRoma.converters.DtoToEntityConverter;
import com.DanceRoma.dtos.DiscoInDto;
import com.DanceRoma.dtos.ReviewInDto;
import com.DanceRoma.dtos.TicketDto;
import com.DanceRoma.entities.*;
import com.DanceRoma.repositories.DiscoRepository;
import com.DanceRoma.repositories.ReviewRepository;
import com.DanceRoma.repositories.TicketRepository;
import com.DanceRoma.repositories.UserRepository;
import org.junit.platform.commons.logging.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

@Service
public class DiscoService {

    @Autowired
    private DiscoRepository discoRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private DtoToEntityConverter dtoToEntityConverter;

    /**
     * Returns a list with all discos
     *
     * @return list with all discos
     */
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


    /**
     * Creates a disco by passing a DiscoInDto instance
     *
     * @param disco with properties
     * @return the created Disco instance
     * @throws Exception if the owner does not exist, already is a disco
     *                   with that name
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
        for (TicketDto ticketDto : disco.getTicketDtos()) {
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
        toCreate.setReviews(new ArrayList<>());
        return discoRepository.save(toCreate);
    }

    /**
     * Updates some aspect of a disco
     *
     * @param id    ID of the disco
     * @param disco disco with desired parameters
     * @return Disco instance with new properties
     * @throws Exception no disco exists with that id
     */
    public Disco update(Long id, DiscoInDto disco) throws Exception {
        Optional<User> owner = userRepository.findByEmail(disco.getUserEmail());
        if (owner.isEmpty()) {
            throw new Exception("Owner not found with name <" + disco.getUserEmail() + ">");
        }

        List<Ticket> tickets = new ArrayList<>();
        for (TicketDto ticketDto : disco.getTicketDtos()) {
            Optional<Ticket> existingTicket = ticketRepository.findByDescriptionAndPriceAndDrinksNumber(ticketDto.getDescription(), ticketDto.getPrice(), ticketDto.getDrinksNumber());

            if (existingTicket.isPresent()) {
                tickets.add(existingTicket.get());
            } else {
                Ticket toCreate = dtoToEntityConverter.convert(ticketDto);
                tickets.add(ticketRepository.save(toCreate));
            }
        }

        Disco toUpdate = dtoToEntityConverter.convert(disco);
        toUpdate.setId(id);
        toUpdate.setUser(owner.get());
        toUpdate.setTickets(tickets);

        if (toUpdate.getReviews() == null) {
            toUpdate.setReviews(new ArrayList<>());
        }

        return discoRepository.save(toUpdate);
    }

    public List<Review> addReview(ReviewInDto reviewInDto) throws Exception {
        Optional<Disco> disco = discoRepository.findById(reviewInDto.getDiscoId());
        if (disco.isEmpty()) {
            throw new Exception("There is not any disco with ID <" + reviewInDto.getDiscoId() + ">");
        }

        Optional<User> user = userRepository.findById(reviewInDto.getUserId());
        if (user.isEmpty()) {
            throw new Exception("There is not any user with ID <" + reviewInDto.getUserId() + ">");
        }

        Disco toUpdate = disco.get();

        Review reviewToAdd = dtoToEntityConverter.convert(reviewInDto);
        reviewToAdd.setDisco(toUpdate);
        reviewToAdd.setUser(user.get());
        reviewRepository.save(reviewToAdd);

        List<Review> actualReviews = toUpdate.getReviews();
        actualReviews.add(reviewToAdd);
        toUpdate.setReviews(actualReviews);
        return discoRepository.save(toUpdate).getReviews();
    }

    public Disco getDisco(Long id) throws Exception {
        Optional<Disco> d = discoRepository.findById(id);
        if (d.isEmpty()) {
            throw new Exception("No disco with that id");
        }
        return d.get();
    }

}
