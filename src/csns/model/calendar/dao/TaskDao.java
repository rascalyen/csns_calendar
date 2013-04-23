package csns.model.calendar.dao;

import java.util.List;
import csns.model.User;
import csns.model.calendar.Task;


public interface TaskDao {
	
	public Task getTaskById(Integer id);
	
	public Task getTaskByTitle(String title);
	
	public List<Task> getAllTasks(User user);
	
	public void saveTask( Task task );

}
