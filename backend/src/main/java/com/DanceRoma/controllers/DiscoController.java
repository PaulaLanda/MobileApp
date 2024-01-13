package com.DanceRoma.controllers;

import com.DanceRoma.converters.DtoToEntityConverter;
import com.DanceRoma.converters.EntityToDtoConverter;
import com.DanceRoma.dtos.DiscoDto;
import com.DanceRoma.dtos.DiscoInDto;
import com.DanceRoma.entities.Disco;
import com.DanceRoma.entities.User;
import com.DanceRoma.servicies.DiscoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/discos")
@CrossOrigin
public class DiscoController {

    @Autowired
    private DiscoService discoService;

    @Autowired
    private EntityToDtoConverter entityToDtoConverter;

    @Autowired
    private DtoToEntityConverter dtoToEntityConverter;

    @GetMapping("")
    public ResponseEntity<List<DiscoDto>> getAllDiscos() {
        List<Disco> discos = discoService.findAll();
        List<DiscoDto> discoDto = discos.stream().map(disco -> entityToDtoConverter.convert(disco)).collect(Collectors.toList());
        return ResponseEntity.ok(discoDto);
    }

    @GetMapping("/{id}")
    public ResponseEntity<List<DiscoDto>> getAllDiscoByUserId(@PathVariable Long id) throws Exception {
        List<Disco> discos = discoService.findAllByUserId(id);
        List<DiscoDto> discosDto = discos.stream().map(disco -> entityToDtoConverter.convert(disco)).collect(Collectors.toList());
        return ResponseEntity.ok(discosDto);
    }

    @PostMapping("/create")
    public ResponseEntity<?> create(@RequestBody DiscoInDto discoDto) throws Exception {
        ResponseEntity<?> toReturn;
        try {
            Disco discoCreated = discoService.create(discoDto);
            DiscoDto discoCreatedDto = entityToDtoConverter.convert(discoCreated);
            toReturn = ResponseEntity.ok(discoCreatedDto);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<?> update(@RequestBody User u, @RequestBody DiscoInDto discoDto) throws Exception {
        ResponseEntity<?> toReturn;
        try {
            Disco discoUpdated = discoService.update(u, discoDto);
            DiscoDto discoUpdatedDto = entityToDtoConverter.convert(discoUpdated);
            toReturn = ResponseEntity.ok(discoUpdatedDto);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }
}
