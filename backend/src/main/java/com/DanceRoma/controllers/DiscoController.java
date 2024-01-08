package com.DanceRoma.controllers;

import com.DanceRoma.converters.DtoToEntityConverter;
import com.DanceRoma.converters.EntityToDtoConverter;
import com.DanceRoma.dtos.DiscoDto;
import com.DanceRoma.entities.Disco;
import com.DanceRoma.servicies.DiscoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/disco")
@CrossOrigin
public class DiscoController {

    @Autowired
    private DiscoService discoService;

    @Autowired
    private EntityToDtoConverter entityToDtoConverter;

    @Autowired
    private DtoToEntityConverter dtoToEntityConverter;

    @GetMapping("")
    public ResponseEntity<List<DiscoDto>> getAllDisco() {
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
    public ResponseEntity<DiscoDto> create(@RequestBody DiscoDto discoDto) throws Exception {
        Disco disco = dtoToEntityConverter.convert(discoDto);
        Disco discoCreated = discoService.create(disco);
        DiscoDto toReturn = entityToDtoConverter.convert(discoCreated);
        return ResponseEntity.ok(toReturn);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<DiscoDto> update(@PathVariable Long id, @RequestBody DiscoDto discoDto) throws Exception {
        Disco disco = dtoToEntityConverter.convert(discoDto);
        Disco discoUpdated = discoService.update(id, disco);
        DiscoDto toReturn = entityToDtoConverter.convert(discoUpdated);
        return ResponseEntity.ok(toReturn);
    }
}
