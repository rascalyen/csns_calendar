package csns.spring.controller.calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import csns.model.calendar.Event;
import csns.model.calendar.dao.EventDao;


public class DeleteEventController extends AbstractController {
	
	private EventDao eventDao;

	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Event event = eventDao.getEventById( Integer.parseInt( request.getParameter("eventId")));
		eventDao.deleteEvent(event);
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String year = request.getParameter("year");		
		
	    return new ModelAndView("redirect:calendar.html?month="+month+"&day="+day+"&year="+year);
	}

	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}
	
}
