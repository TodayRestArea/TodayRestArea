package com.todayrestarea.admin.model.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AdminResponse {
    private boolean isSuccess=true;
    private int code=200;
    private String message="success";
    private Object result;

}
