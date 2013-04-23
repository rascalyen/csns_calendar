package csns.spring.security.voter;

import org.aopalliance.intercept.MethodInvocation;
import csns.model.User;
import csns.model.calendar.Event;
import csns.spring.security.SecurityUtils;

public class EventWriteVoter extends MethodAccessVoter {

	public boolean isAccessAllowed(User user, MethodInvocation method) {

		Event event = (Event) method.getArguments()[0];
		
		return (event.isOpen() && SecurityUtils.isAdministrator()) ||
		       (!event.isOpen() && event.getCreator().isSameUser(user)) ||
		       (event.getSection() != null && event.getSection().isInstructor(user));
	}

}
