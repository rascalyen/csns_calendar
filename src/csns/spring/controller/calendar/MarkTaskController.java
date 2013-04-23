package csns.spring.controller.calendar;

import java.util.GregorianCalendar;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import csns.model.calendar.Task;
import csns.model.calendar.dao.TaskDao;


public class MarkTaskController extends AbstractController {
	
	private TaskDao taskDao;
	
	protected ModelAndView handleRequestInternal(HttpServletRequest request, 
			HttpServletResponse response) throws Exception 
	{
		
		String taskId = request.getParameter("taskId");
		
		Task task = taskDao.getTaskById( Integer.valueOf(taskId));
		task.setCompletedDate( new GregorianCalendar());
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

}
