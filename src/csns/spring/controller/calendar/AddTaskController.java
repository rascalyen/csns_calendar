package csns.spring.controller.calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import csns.model.User;
import csns.model.calendar.Task;
import csns.model.calendar.dao.TaskDao;
import csns.model.dao.UserDao;
import csns.spring.security.SecurityUtils;


public class AddTaskController extends SimpleFormController {
	
	private TaskDao taskDao;
	private UserDao userDao;

	protected ModelAndView onSubmit( HttpServletRequest request,
        HttpServletResponse response, Object command, BindException errors )
        throws Exception
    {
    	Task task = (Task) command;
    	User user = userDao.getUserByName(SecurityUtils.getUsername() );
    	task.setCreator(user);
    	taskDao.saveTask(task);
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String year = request.getParameter("year");		
    	
		if (month!=null && day!=null && year!=null)
		    return new ModelAndView("redirect:calendar.html?month="+month+"&day="+day+"&year="+year); 	
		else
			return new ModelAndView("redirect:calendar.html");
    }

	public void setTaskDao(TaskDao taskDao) {
		this.taskDao = taskDao;
	}
	
    public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

}
