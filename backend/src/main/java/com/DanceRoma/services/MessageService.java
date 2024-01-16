package com.DanceRoma.services;

import com.DanceRoma.dtos.MessageInDto;
import com.DanceRoma.entities.Message;
import com.DanceRoma.repositories.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import com.DanceRoma.converters.DtoToEntityConverter;

import java.util.List;
import java.util.Optional;

public class MessageService {
    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private DtoToEntityConverter converterDto;

    public Optional<Message> getMessageById(Long id) throws Exception {
        Optional<Message> message = messageRepository.findById(id);
        if (message.isEmpty()) {
            throw new Exception("There is not any message with ID <" + id + ">");
        }
        return message;
    }

    public List<Message> getMessagesBySenderId(Long id) throws Exception {
        List<Message> messages = messageRepository.findAllBySender_id(id);
        if (messages.isEmpty()) {
            throw new Exception("There are not messages by Sender with ID: <" + id + ">");
        }
        return messages;
    }

    public List<Message> getMessagesByReceptorId(Long id) throws Exception {
        List<Message> messages = messageRepository.findAllByReceptor_id(id);
        if (messages.isEmpty()) {
            throw new Exception("There are not messages by Receptor with ID: <" + id + ">");
        }
        return messages;
    }


    public Message create(MessageInDto message) {
        Message messagetoCreate = converterDto.convert(message);
        return messageRepository.save(messagetoCreate);

    }

    public void deleteMessage(Long id) {
        messageRepository.deleteById(id);
    }
}
