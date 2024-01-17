package com.DanceRoma.repositories;

import com.DanceRoma.entities.Disco;
import com.DanceRoma.entities.Ticket;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TicketRepository extends CrudRepository<Ticket, Long> {

    Optional<Ticket> findByDescriptionAndPriceAndDrinksNumber(String description, Integer price, Integer drinksNumber);
}
//flag