package com.todayrestarea.admin.model.entity;

import lombok.*;

import javax.persistence.*;

@ToString
@Getter
@Setter
@AllArgsConstructor
@RequiredArgsConstructor
@Entity
@NamedQuery(name = "Music.checkExistence",
query = "select m from Music m where m.title=:title and m.artist=:artist"
)
@Table(name="music",uniqueConstraints = {
        @UniqueConstraint(//unique constraint 추가
        name = "TITLE_ARTIST_UNIQUE",
        columnNames = {"title","artist"}
        )
})
public class Music {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long musicId;
    @Column(name="title")
    private String title;
    @Column(name="artist")
    private String artist;
    @Column(name="poster_url")
    private String posterUrl;
    @Column(name="info_url")
    private String infoUrl;

    @ManyToOne
    @JoinColumn(name = "emotion_id")
    private Emotion emotion;

    public void setEmotion(Emotion emotion){
        if (this.emotion != null) {
            this.emotion.getMusics().remove(this);
        }
        this.emotion=emotion;
        this.emotion.getMusics().add(this);
    }
}
