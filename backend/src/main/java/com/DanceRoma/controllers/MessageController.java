package com.DanceRoma.controllers;

import com.DanceRoma.dtos.MessageDto;
import com.DanceRoma.dtos.MessageInDto;
import com.DanceRoma.dtos.UserDto;
import com.DanceRoma.entities.Message;
import com.DanceRoma.entities.User;
import com.DanceRoma.converters.EntityToDtoConverter;
import com.DanceRoma.services.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/messages")
@CrossOrigin
public class MessageController {

    @Autowired
    private EntityToDtoConverter entitytoDtoConverter;
    @Autowired
    private MessageService messageService;
    //flag
    @PostMapping("/create")
    public ResponseEntity<?> createMessage(@RequestBody MessageInDto messageDto){
        ResponseEntity<?> toReturn;
        try{
            Message messageCreated = messageService.create(messageDto);
            MessageDto messagedto = entitytoDtoConverter.convert(messageCreated);
            toReturn = ResponseEntity.ok(messagedto);
        }catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteMessage(@PathVariable Long id) {
        ResponseEntity<?> toReturn;
        try {
            messageService.deleteMessage(id);
            toReturn = ResponseEntity.ok("Message deleted successfully");
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }


    @GetMapping("/by-sender/{id}")
    public ResponseEntity<?> getMessageBySender(@PathVariable Long id) {
        ResponseEntity<?> toReturn;
        try {
            List<Message> messages = messageService.getMessagesBySenderId(id);
            List<MessageDto> messagesDto  = messages.stream().map(message -> entitytoDtoConverter.convert(message)).collect(Collectors.toList());
            return ResponseEntity.ok(ResponseEntity.ok(messagesDto));
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }


    @GetMapping("/by-receptor/{id}")
    public ResponseEntity<?> getMessageByReceptor(@PathVariable Long id) {
        ResponseEntity<?> toReturn;
        try {
            List<Message> messages = messageService.getMessagesByReceptorId(id);
            List<MessageDto> messagesDto  = messages.stream().map(message -> entitytoDtoConverter.convert(message)).collect(Collectors.toList());
            return ResponseEntity.ok(ResponseEntity.ok(messagesDto));
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }
}
