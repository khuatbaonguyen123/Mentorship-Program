package mentorship.news_aggregation.repository;

import mentorship.news_aggregation.model.News;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NewsRepository extends JpaRepository<News, Long> {
}
