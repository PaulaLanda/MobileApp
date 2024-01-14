package com.DanceRoma.services;

import com.DanceRoma.dtos.LoginDto;
import com.DanceRoma.dtos.UserDto;
import com.DanceRoma.entities.Disco;
import com.DanceRoma.entities.User;
import com.DanceRoma.repositories.DiscoRepository;
import com.DanceRoma.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private DiscoRepository discoRepository;

    /**
     * Returns all users in the database
     * @return list of all users
     */
    public List<User> findAll() {
        return (List<User>) userRepository.findAll();
    }

    /**
     * Creates a user
     * @param user to be created with all its properties
     * @return created user
     * @throws Exception already exists a user with that email
     */
    public User register(User user) throws Exception {
        Optional<User> userByEmail = userRepository.findByEmail(user.getEmail());
        if (userByEmail.isPresent()) {
            throw new Exception("Ya existe un usuario con el correo <" + user.getEmail() + ">");
        }
        return userRepository.save(user);
    }

    /**
     * Updates some data of a user
     * @param user with new data
     * @return updated user
     * @throws Exception no user with that email exists
     */
    public User update(Long id, User user) throws Exception {
        Optional<User> existingUser = userRepository.findById(id);
        if (existingUser.isEmpty()) {
            throw new Exception("There is not any user with ID <" + id + ">");
        }
        user.setId(id);
        return userRepository.save(user);
    }

    /**
     * Passes a login instance and returns whether the user is a client or
     * an owner
     * @param loginDto
     * @return CLIENT or OWNER
     * @throws Exception user or password (or both) is incorrect
     */
    public User login(LoginDto loginDto) throws Exception {
        Optional<User> userLogged = userRepository.findByEmailAndPassword(loginDto.getUser(), loginDto.getPassword());
        if (userLogged.isEmpty()) {
            throw new Exception("User or password incorrect");
        }
        return userLogged.get();
    }

    /**
     * Adds to favourite some disco for some user and returns the list of
     * discos the user has marked as favourites
     * @param discoId Disco ID to add to favourites
     * @param userId User ID
     * @return list of favourite discos of that user
     * @throws Exception no user with that id
     */
    public List<Disco> addToFav(Long discoId, Long userId) throws Exception {
        Optional<User> user = userRepository.findById(userId);
        if (user.isEmpty()) {
            throw new Exception("There is not any user with ID <" + userId + ">");
        }

        Optional<Disco> disco = discoRepository.findById(discoId);
        if (disco.isEmpty()) {
            throw new Exception("There is not any disco with ID <" + discoId + ">");
        }

        List<Disco> actualFavs = discoRepository.findAllByUser_id(userId);

        if(actualFavs.stream().anyMatch(favDisco -> Objects.equals(favDisco.getId(), discoId))) {
            throw new Exception("Disco with ID <" + discoId + "> is already in favs for user with ID <" + userId + ">");
        }

        actualFavs.add(disco.get());
        user.get().setFavoriteDiscos(actualFavs);
        userRepository.save(user.get());
        return actualFavs;
    }

    /**
     * Deletes a certain disco from the list of favourite discos of that user
     * @param discoId Disco ID to add to favourites
     * @param userId User ID
     * @return list of favourite discos
     * @throws Exception no user with that id
     */
    public List<Disco> deleteFromFav(Long discoId, Long userId) throws Exception {
        Optional<User> user = userRepository.findById(userId);
        if (user.isEmpty()) {
            throw new Exception("There is not any user with ID <" + userId + ">");
        }

        Optional<Disco> disco = discoRepository.findById(discoId);
        if (disco.isEmpty()) {
            throw new Exception("There is not any disco with ID <" + discoId + ">");
        }

        User userToDeleteFav = user.get();
        Disco toDelete = disco.get();

        if(!userToDeleteFav.getFavoriteDiscos().contains(toDelete)) {
            throw new Exception("Disco with ID <" + discoId + "> is not in favs for user with ID <" + userId + ">");
        }

        userToDeleteFav.getFavoriteDiscos().remove(toDelete);
        return userRepository.save(userToDeleteFav).getFavoriteDiscos();
    }




    /**
     * Returns whether the user has marked that disco as favourite
     * @param discoId Disco ID to add to favourites
     * @param userId User ID
     * @return true (disco is fav), false
     * @throws Exception no user with that id
     */
    public boolean isFav(Long discoId, Long userId) throws Exception {
        Optional<User> user = userRepository.findById(userId);
        if (user.isEmpty()) {
            throw new Exception("There is not any user with ID <" + userId + ">");
        }

        Optional<Disco> disco = discoRepository.findById(discoId);
        if (disco.isEmpty()) {
            throw new Exception("There is not any disco with ID <" + discoId + ">");
        }

        List<Disco> favDiscos = discoRepository.findAllByUser_id(userId);
        return favDiscos.stream().anyMatch(favDisco -> Objects.equals(favDisco.getId(), discoId));
    }

}