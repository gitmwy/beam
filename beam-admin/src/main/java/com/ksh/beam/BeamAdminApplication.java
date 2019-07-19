package com.ksh.beam;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class BeamAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(BeamAdminApplication.class, args);
    }
}
