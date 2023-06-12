package com.human.springboot;

import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

public class SwWebConfig implements WebMvcConfigurer {
    
    private String con = "/board/download/**";
    private String res = "file:///D:/testimg/";

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry regi){
        regi.addResourceHandler(con).addResourceLocations(res);
    }
}
