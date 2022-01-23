package com.todayrestarea.admin.model.entity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@RequiredArgsConstructor
@Entity
@NamedQuery(name="Emotion.findEmotionByName",
query="select m from Emotion m where m.emotionName= :emotion_name")
@Table(name="emotion")
public class Emotion {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long emotionId;
    @Column(name="emotion_name")
    private String emotionName;

    @OneToMany(mappedBy = "emotion")
    private List<Music> musics = new ArrayList<>();

    @OneToMany(mappedBy = "emotion")
    private List<Movie> movies = new ArrayList<>();



}
