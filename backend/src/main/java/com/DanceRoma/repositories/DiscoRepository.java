package com.DanceRoma.repositories;

import com.DanceRoma.entities.Disco;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DiscoRepository extends CrudRepository<Disco, Long> {
    //flag
    Optional<Disco> findByName(String name);
    List<Disco> findAllByUser_id(Long id);
    Optional<Disco> findById(Long id);
}
