package com.todayrestarea.admin.common.movie;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class MovieInfoResponse {
    private String title;
    private String director;
    private String posterUrl;
    private String infoUrl;
    private String plot;
}
