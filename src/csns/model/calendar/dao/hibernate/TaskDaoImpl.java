package csns.model.calendar.dao.hibernate;

import java.util.List;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import csns.model.User;
import csns.model.calendar.Task;
import csns.model.calendar.dao.TaskDao;


@SuppressWarnings({ "rawtypes", "unchecked" })
public class TaskDaoImpl extends HibernateDaoSupport implements TaskDao {

	
	public Task getTaskById(Integer id) {
		return (Task) getHibernateTemplate().get( Task.class, id );
	}

	public Task getTaskByTitle(String title) {
        String query = "from Task where title = ?";
        List results = getHibernateTemplate().find( query, title );
        return results.size() == 0 ? null : (Task) results.get( 0 );		
	}

	public List<Task> getAllTasks(User user) {
		String query = "from Task where creator = ?";
	    return (List<Task>) getHibernateTemplate().find(query, user );		
	}
	
	public void saveTask(Task task) {
		getHibernateTemplate().saveOrUpdate( task );
	}
	
	
}
