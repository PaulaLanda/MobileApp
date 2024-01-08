package com.DanceRoma.servicies;

import com.DanceRoma.entities.Disco;
import com.DanceRoma.entities.User;
import com.DanceRoma.repositories.DiscoRepository;
import com.DanceRoma.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DiscoService {

    @Autowired
    private DiscoRepository discoRepository;

    @Autowired
    private UserRepository userRepository;

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

    public Disco create(Disco disco) throws Exception {
        Optional<Disco> discoByName = discoRepository.findByName(disco.getName());
        if (discoByName.isPresent()) {
            throw new Exception("Already exists a disco with the name <" + disco.getName() + ">");
        }
        return discoRepository.save(disco);
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
