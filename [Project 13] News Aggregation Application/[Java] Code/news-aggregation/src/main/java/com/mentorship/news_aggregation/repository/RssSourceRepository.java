package com.mentorship.news_aggregation.repository;

import com.mentorship.news_aggregation.model.RssSource;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RssSourceRepository extends JpaRepository<RssSource, Long> {
}
