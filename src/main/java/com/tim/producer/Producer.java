package com.tim.producer;

import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Producer {
    private final AmqpTemplate template;

    @Value("${queueName}")
    private String queueName;

    public Producer(AmqpTemplate template) {
        this.template = template;
    }

    public ResponseEntity<String> sendMessage() {
        int randomNumber = (int) (Math.random() * 100);
        String message = Integer.toString(randomNumber);
        template.convertAndSend(queueName, message);
        System.out.println("The message was sent:" + message);
        return ResponseEntity.ok("The message was sent:" + message);
    }
}
