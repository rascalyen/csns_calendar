package csns.spring.controller.calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import csns.model.calendar.Event;
import csns.model.calendar.dao.EventDao;


public class ViewEventController extends AbstractController {
	
	private EventDao eventDao;

	protected ModelAndView handleRequestInternal(HttpServletRequest request,
	    HttpServletResponse response) throws Exception {
		
		Event event = eventDao.getEventById(Integer.valueOf( request.getParameter( "eventId" )));	
		
		return new ModelAndView("calendar/viewEvent").addObject("event", event);
	}

	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}
	
}
