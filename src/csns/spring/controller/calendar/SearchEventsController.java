package csns.spring.controller.calendar;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import csns.model.User;
import csns.model.calendar.Event;
import csns.model.calendar.dao.EventDao;
import csns.model.dao.UserDao;
import csns.spring.security.SecurityUtils;


public class SearchEventsController extends AbstractController {

	private UserDao userDao;
	private EventDao eventDao;


	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception 
	{
		String query = request.getParameter("query");
		User user = userDao.getUserByName(SecurityUtils.getUsername());
		List<Event> events = StringUtils.hasText(query) ?
				eventDao.searchEvents(query, user) : new ArrayList<Event>();
		
		return new ModelAndView("calendar/viewSearchEventResults").addObject(
				"events", events).addObject("resultSize", events.size());
	}

	
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}	
	
}
