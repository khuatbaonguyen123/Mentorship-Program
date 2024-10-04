package mentorship.news_aggregation.repository;

import mentorship.news_aggregation.model.RssSource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RssSourceRepository extends JpaRepository<RssSource, Long> {
}
