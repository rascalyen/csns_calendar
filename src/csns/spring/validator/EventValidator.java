package csns.spring.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import csns.model.calendar.Event;

public class EventValidator implements Validator {
	
    @SuppressWarnings("rawtypes")	
    public boolean supports( Class clazz )
    {
        return clazz.equals( Event.class );
    }

	public void validate( Object command, Errors errors ) 
	{
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "error.event.title.empty");
		Event event = (Event) command;
		
		if (event.getEndTime().before(event.getStartTime()))
			errors.rejectValue("endTime", "error.event.endTime.invalid");
	}
    
}
