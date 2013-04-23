package csns.spring.security.voter;

import csns.model.User;
import csns.model.calendar.Event;

public class EventReadVoter extends BusinessObjectAccessVoter {

	@Override
	public boolean isAccessAllowed(User user, Object returnedObject) {
		
		Event event = (Event) returnedObject;
		return event.isOpen() || event.getCreator().isSameUser(user) ||
		       (event.getSection() != null && 
		    		   (event.getSection().isStudentEnrolled(user) 
		        		|| event.getSection().isInstructor(user)));
	}

}
