package csns.spring.controller.calendar;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import csns.model.calendar.Event;
import csns.model.calendar.dao.EventDao;
import csns.spring.CustomCalendarEditor;

public class EditEventController extends SimpleFormController{

	private EventDao eventDao;
	
    protected void initBinder( HttpServletRequest request,
         ServletRequestDataBinder binder ) throws Exception
    {
         binder.registerCustomEditor( Calendar.class, new CustomCalendarEditor( 
        		 new SimpleDateFormat( "MM/dd/yyyy" ), true ) );
    }	
		
    protected Object formBackingObject( HttpServletRequest request ) throws Exception 
    {    	
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String year = request.getParameter("year");		    	
    	request.setAttribute("month", month);
    	request.setAttribute("day", day);
    	request.setAttribute("year", year);
		return eventDao.getEventById(Integer.valueOf( request.getParameter( "eventId" ) ));    	
    }
    
	protected ModelAndView onSubmit( HttpServletRequest request,
	    HttpServletResponse response, Object command, BindException errors )
	    throws Exception
	{
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String year = request.getParameter("year");		
		Event event = (Event) command;
		eventDao.saveEvent(event);
		
	    return new ModelAndView("redirect:calendar.html?month="+month+"&day="+day+"&year="+year);
	}
	
		
	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}

	
}
