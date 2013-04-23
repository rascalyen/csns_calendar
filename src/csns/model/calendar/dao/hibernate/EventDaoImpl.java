package csns.model.calendar.dao.hibernate;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import csns.model.Section;
import csns.model.User;
import csns.model.calendar.Event;
import csns.model.calendar.dao.EventDao;


@SuppressWarnings({ "rawtypes", "unchecked" })
public class EventDaoImpl extends HibernateDaoSupport implements EventDao {

	
	public Event getEventById(Integer id) {
		return (Event) getHibernateTemplate().get( Event.class, id );
	}

	public Event getEventByTitle(String title) {
        String query = "from Event where title = ?";
        List results = getHibernateTemplate().find( query, title );
        return results.size() == 0 ? null : (Event) results.get( 0 );	
	}

	public Event getEventByAssignment(String title, Section section, Calendar start, Calendar end) {
		String query = "from Event where title = ? and section = ? and startTime = ? and endTime = ?";
		Object params[] = {title, section, start, end};
		List results = getHibernateTemplate().find( query, params );
		return results.size() == 0 ? null : (Event) results.get( 0 );
	}	
	
	public List<Event> getAllEvents(User user) {
		String query = "select distinct e from Event e, Enrollment r where " +
				"e.creator=? or open=true or (e.section.id=r.section.id and r.student=?) " +
				"order by e.startTime";
		
		Object params[] = {user, user};

	    return (List<Event>) getHibernateTemplate().find(query, params);		
	}

	public Set<Integer> getMonthEvents(Integer year, Integer month, User user) {
		Calendar start = new GregorianCalendar(year, month, 1);
		Calendar end = new GregorianCalendar(year, month, 
				           start.getActualMaximum(Calendar.DAY_OF_MONTH));
		end.set(Calendar.HOUR_OF_DAY, 23);
		end.set(Calendar.MINUTE, 59);
		end.set(Calendar.SECOND, 59);
		
		String query = "select distinct e from Event e, Enrollment r where " +
		"(e.creator=? or open=true or (e.section.id=r.section.id and r.student=?)) " +
		"and e.startTime>=? and e.endTime<=? order by e.startTime";		
		
	    Object params[] = {user, user, start, end};		
		
		List<Event> events = (List<Event>) getHibernateTemplate().find(query, params);
		Set<Integer> days = new HashSet();
		for (Event event: events) 
			days.add(event.getStartTimeDay());
		
		return days;
	}
		
	public List<Event> getDateEvents(Integer year, Integer month, Integer day, User user) {
		Calendar start = new GregorianCalendar(year, month, day);
		Calendar end = new GregorianCalendar(year, month, day);
		end.set(Calendar.HOUR_OF_DAY, 23);
		end.set(Calendar.MINUTE, 59);
		end.set(Calendar.SECOND, 59);
		
		String query = "select distinct e from Event e, Enrollment r where " +
		"(e.creator=? or open=true or (e.section.id=r.section.id and r.student=?)) " +
		"and e.startTime>=? and e.endTime<=? order by e.startTime";		
		
	    Object params[] = {user, user, start, end};		
		
		return (List<Event>) getHibernateTemplate().find(query, params);
	}
	
	public void deleteEvent(Event event) {
		getHibernateTemplate().delete( event );
	}	
	
	public void saveEvent(Event event) {
		getHibernateTemplate().saveOrUpdate( event );
	}

	public List<Event> searchEvents(String query, User user) {
		Object params[] = {query, user.getId(), user.getId()};		
		return (List<Event>) getHibernateTemplate().findByNamedQuery(
				"all.event.search", params);
	}


}
