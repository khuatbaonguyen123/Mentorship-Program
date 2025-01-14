package com.mentorship.news_aggregation.repository;

import com.mentorship.news_aggregation.model.News;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NewsRepository extends JpaRepository<News, Long> {
}
