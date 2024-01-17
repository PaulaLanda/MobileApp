package com.DanceRoma.controllers;

import com.DanceRoma.converters.DtoToEntityConverter;
import com.DanceRoma.converters.EntityToDtoConverter;
import com.DanceRoma.dtos.DiscoDto;
import com.DanceRoma.dtos.DiscoInDto;
import com.DanceRoma.dtos.ReviewInDto;
import com.DanceRoma.dtos.ReviewOutDto;
import com.DanceRoma.entities.Disco;
import com.DanceRoma.entities.Review;
import com.DanceRoma.services.DiscoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    public ResponseEntity<?> getAllDiscos() {
        List<Disco> discos = discoService.findAll();
        List<DiscoDto> discoDto = discos.stream().map(disco -> {
            try {
                return entityToDtoConverter.convert(disco);
            } catch (Exception e) {
                return null;
            }
        }).collect(Collectors.toList());

        if (discoDto.contains(null)) {
            return ResponseEntity.internalServerError().body("Error al procesar el archivo");
        }
        return ResponseEntity.ok(discoDto);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getAllDiscoByUserId(@PathVariable Long id) {
        ResponseEntity<?> toReturn;
        try {
            List<Disco> discos = discoService.findAllByUserId(id);
            List<DiscoDto> discoDto = discos.stream().map(disco -> {
                try {
                    return entityToDtoConverter.convert(disco);
                } catch (Exception e) {
                    return null;
                }
            }).collect(Collectors.toList());

            if (discoDto.contains(null)) {
                return ResponseEntity.internalServerError().body("Error al procesar el archivo");
            }
            return ResponseEntity.ok(discoDto);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> create(@RequestBody DiscoInDto discoDto,
                                    @RequestPart("file") MultipartFile file) {
        ResponseEntity<?> toReturn;
        try {
            Disco discoCreated = discoService.create(discoDto, file);
            DiscoDto discoCreatedDto = entityToDtoConverter.convert(discoCreated);
            toReturn = ResponseEntity.ok(discoCreatedDto);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }
    //flag
    @PutMapping("/update/{id}")
    public ResponseEntity<?> update(@PathVariable Long id, @RequestBody DiscoInDto discoDto) {
        ResponseEntity<?> toReturn;
        try {
            Disco discoUpdated = discoService.update(id, discoDto);
            DiscoDto discoUpdatedDto = entityToDtoConverter.convert(discoUpdated);
            toReturn = ResponseEntity.ok(discoUpdatedDto);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }

    @PutMapping("/add-review")
    public ResponseEntity<?> addReview(@RequestBody ReviewInDto reviewInDto) {
        ResponseEntity<?> toReturn;
        try {
            List<Review> reviews = discoService.addReview(reviewInDto);
            List<ReviewOutDto> reviewDtos = reviews.stream().map(review -> entityToDtoConverter.convert(review)).collect(Collectors.toList());
            toReturn = ResponseEntity.ok(reviewDtos);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }

    @GetMapping("/get/{id}")
    public ResponseEntity<?> getDiscoFromId(@PathVariable Long id) {
        ResponseEntity<?> toReturn;
        try {
            Disco d = discoService.getDisco(id);
            DiscoDto dto = entityToDtoConverter.convert(d);
            toReturn = ResponseEntity.ok(dto);
        } catch (Exception e) {
            toReturn = ResponseEntity.internalServerError().body(e.getMessage());
        }
        return toReturn;
    }
}