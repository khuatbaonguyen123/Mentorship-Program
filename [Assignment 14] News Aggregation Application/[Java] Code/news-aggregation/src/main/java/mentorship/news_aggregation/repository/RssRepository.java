package mentorship.news_aggregation.repository;

import mentorship.news_aggregation.model.Rss;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RssRepository extends JpaRepository<Rss, Long> {
}
