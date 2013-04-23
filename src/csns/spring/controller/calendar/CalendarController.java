package csns.spring.controller.calendar;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import csns.model.User;
import csns.model.calendar.CalendarCSNS;
import csns.model.calendar.Event;
import csns.model.calendar.Task;
import csns.model.calendar.dao.EventDao;
import csns.model.calendar.dao.TaskDao;
import csns.model.dao.UserDao;
import csns.spring.security.SecurityUtils;


public class CalendarController extends AbstractController {
		
	private EventDao   eventDao;
	private TaskDao    taskDao;
	private UserDao    userDao;
	private List<CalendarCSNS> entries = new ArrayList<CalendarCSNS>();
	private Set<Integer> monthEvents = new HashSet<Integer>();

	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		
		entries.add( new CalendarCSNS() );
		List<Event> events = new ArrayList<Event>();
		String action = request.getParameter("action");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String year = request.getParameter("year");
		User user = userDao.getUserByName(SecurityUtils.getUsername());
		List<Task> tasks = taskDao.getAllTasks(user);
		
		if (action == null && month == null && day == null && year == null) { 
			entries.add(0, new CalendarCSNS());
			events = eventDao.getAllEvents(user);
			Calendar ca = new GregorianCalendar();
			monthEvents = eventDao.getMonthEvents(ca.get(Calendar.YEAR), ca.get(Calendar.MONTH), user);
			
            return new ModelAndView("calendar/calendar").addObject("entries", 
            		   entries).addObject("tasks", tasks).addObject("events", 
            		   events).addObject("monthEvents", monthEvents);
		}
		else if (action == null) {
			events = eventDao.getDateEvents(Integer.parseInt(year), 
					Integer.parseInt(month), Integer.parseInt(day), user);
			monthEvents = eventDao.getMonthEvents(Integer.parseInt(year), Integer.parseInt(month), user);
			String message = getMessage(month, day, year);
			
            return new ModelAndView("calendar/calendar").addObject("entries", 
         		   entries).addObject("tasks", tasks).addObject("events", 
         		   events).addObject("month", month).addObject("day", day)
         		   .addObject("year", year).addObject("message", 
         		   message).addObject("monthEvents", monthEvents);
		}
		else if (action.equals("-1")) {
			
			int year2 = entries.get(0).getYear();
			int month2 = entries.get(0).getMonth();
			if (month2 < 1) {
				month2 = 11;
				year2 -= 1;
			}
			else
				month2 -= 1;
			
			entries.add(0, new CalendarCSNS(year2, month2, 1));
			events = eventDao.getAllEvents(user);
			monthEvents = eventDao.getMonthEvents(year2, month2, user);
			return new ModelAndView("calendar/calendar").addObject("entries", 
					   entries).addObject("tasks", tasks).addObject("events", 
					   events).addObject("monthEvents", monthEvents);
		}
		else if (action.equals("1")) {

			int year2 = entries.get(0).getYear();
			int month2 = entries.get(0).getMonth();
			if (month2 > 10) {
				month2 = 0;
				year2 += 1;
			}
			else
				month2 += 1;
			
			entries.add(0, new CalendarCSNS(year2, month2, 1));
			events = eventDao.getAllEvents(user);
			monthEvents = eventDao.getMonthEvents(year2, month2, user);
			return new ModelAndView("calendar/calendar").addObject("entries", 
					   entries).addObject("tasks", tasks).addObject("events", 
					   events).addObject("monthEvents", monthEvents);			
		}

		return null;
	}
	
	private String getMessage(String monthString, String dayString, String yearString) {
		String year = yearString;
		String month="";
		String day="";
		
		if (Integer.parseInt(monthString)+1<10)
			month = "0"+(Integer.parseInt(monthString)+1);
		else
			month = (Integer.parseInt(monthString)+1)+"";
		if (Integer.parseInt(dayString)<10)
			day = "0"+Integer.parseInt(dayString);
		else
			day = dayString;
		
		return year+"/"+month+"/"+day+ " is selected";
	}		
		
	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}

	public void setTaskDao(TaskDao taskDao) {
		this.taskDao = taskDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}	
		
	
}
