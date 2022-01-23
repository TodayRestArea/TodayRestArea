package com.todayrestarea.admin.model.entity;

import lombok.*;

import javax.persistence.*;

@Getter
@Setter
@RequiredArgsConstructor
@AllArgsConstructor
@Entity
@NamedQuery(name = "Movie.checkExistence",
        query = "select m from Movie m where m.title=:title and m.director=:director"
)
@Table(name="movie")
public class Movie {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long movieId;
    @Column(name="title")
    private String title;
    @Column(name="director")
    private String director;
    @Column(name="poster_url")
    private String posterUrl;
    @Column(name="info_url")
    private String infoUrl;

    @Lob
    @Column(name="plot")
    private String plot;

    @ManyToOne
    @JoinColumn(name = "emotion_id")
    private Emotion emotion;

    public void setEmotion(Emotion emotion){
        if (this.emotion != null) {
            this.emotion.getMovies().remove(this);
        }
        this.emotion=emotion;
        this.emotion.getMovies().add(this);
    }
}
