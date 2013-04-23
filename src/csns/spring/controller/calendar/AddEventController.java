package csns.spring.controller.calendar;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import csns.model.User;
import csns.model.calendar.Event;
import csns.model.calendar.dao.EventDao;
import csns.model.dao.UserDao;
import csns.spring.CustomCalendarEditor;
import csns.spring.security.SecurityUtils;

public class AddEventController extends SimpleFormController{

	private EventDao eventDao;
	private UserDao userDao;
	
    protected void initBinder( HttpServletRequest request,
         ServletRequestDataBinder binder ) throws Exception
    {
         binder.registerCustomEditor( Calendar.class, new CustomCalendarEditor( 
        		 new SimpleDateFormat( "MM/dd/yyyy" ), true ) );
    }	
		
    protected Object formBackingObject( HttpServletRequest request ) throws Exception 
    {    	
    	int month = Integer.parseInt( request.getParameter("month") );
    	int day = Integer.parseInt( request.getParameter("day") );
    	int year = Integer.parseInt( request.getParameter("year") );
    	Calendar start = new GregorianCalendar(year, month, day);
    	Calendar end = new GregorianCalendar(year, month, day);
    	Event event = new Event(start, end);
		return event;    	
    }
    
	protected ModelAndView onSubmit( HttpServletRequest request,
	    HttpServletResponse response, Object command, BindException errors )
	    throws Exception
	{
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String year = request.getParameter("year");
		Event event = (Event) command;
		User creator = userDao.getUserByName(SecurityUtils.getUsername() );
		event.setCreator(creator);

		eventDao.saveEvent(event);
		
	    return new ModelAndView("redirect:calendar.html?month="+month+"&day="+day+"&year="+year);	
	}
	
		
	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}
	
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
}
