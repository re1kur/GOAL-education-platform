package re1kur.taskservice.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import re1kur.taskservice.entity.Task;

import java.math.BigDecimal;

public interface TaskRepository extends JpaRepository<Task, Integer> {

    @Query(value =
            """
                    from Task t where 
                    (lower(t.name) like lower(concat('%', :name, '%')) or :name is null) and
                    ((t.cost = :cost) or :cost is null) and
                    ((t.level = :level) or :level is null)  
                    """)
    Page<Task> findAllByFilter(Pageable pageable,
                               @Param("name") String name,
                               @Param("cost") BigDecimal cost,
                               @Param("level") Integer level);
}
