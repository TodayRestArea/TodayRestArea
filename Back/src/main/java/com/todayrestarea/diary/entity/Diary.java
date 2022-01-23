package com.todayrestarea.diary.entity;

import com.todayrestarea.admin.model.entity.Emotion;
import com.todayrestarea.admin.model.entity.Weather;
import com.todayrestarea.user.entity.User;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@RequiredArgsConstructor
@Entity
@Table(name="diary")
public class Diary {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long diaryId;

    @Lob
    @Column(name="contents")
    private String contents;

    @ManyToOne
    @JoinColumn(name="user_id")
    private User writer;

    @ManyToOne
    @JoinColumn(name="weather_id")
    private Weather weather;

    @ManyToOne
    @JoinColumn(name="emotion_id")
    private Emotion emotion;

    @Temporal(value = TemporalType.DATE)
    @UpdateTimestamp
    private Date updatedDate;

    @Temporal(value = TemporalType.DATE)
    private Date createdDate;
}


