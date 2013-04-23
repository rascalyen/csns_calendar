package csns.model.calendar.dao;

import java.util.Calendar;
import java.util.List;
import java.util.Set;
import csns.model.Section;
import csns.model.User;
import csns.model.calendar.Event;


public interface EventDao {
	
	public Event getEventById(Integer id);
	
	public Event getEventByTitle(String title);
	
	public Event getEventByAssignment(String title, Section section, Calendar start, Calendar end);
	
	public List<Event> getAllEvents(User user);
	
	public Set<Integer> getMonthEvents(Integer year, Integer month, User user);
	
	public List<Event> getDateEvents(Integer year, Integer month, Integer day, User user);
	
	public List<Event> searchEvents(String query, User user);
	
	public void deleteEvent (Event event);
	
	public void saveEvent( Event event );


}
