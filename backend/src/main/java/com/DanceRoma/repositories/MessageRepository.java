package com.DanceRoma.repositories;

import com.DanceRoma.entities.Message;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MessageRepository extends CrudRepository<Message,Long> {
    Optional<Message> findById(Long id);
    List<Message> findAllBySender_id(Long senderId);
    List<Message> findAllByReceptor_id(Long receptorId);
}
//flag