package com.mentorship.news_aggregation.repository;

import com.mentorship.news_aggregation.model.NewsTag;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NewsTagRepository extends JpaRepository<Long, NewsTag> {
}
