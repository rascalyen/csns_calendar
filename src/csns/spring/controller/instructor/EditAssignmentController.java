package csns.spring.controller.instructor;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import csns.model.Section;
import csns.model.assignment.Assignment;
import csns.model.assignment.dao.AssignmentDao;
import csns.model.calendar.Event;
import csns.model.calendar.dao.EventDao;
import csns.spring.CustomCalendarEditor;

public class EditAssignmentController extends SimpleFormController {

    private AssignmentDao assignmentDao;
    private EventDao eventDao;
    
    
    protected void initBinder( HttpServletRequest request,
        ServletRequestDataBinder binder ) throws Exception
    {
        binder.registerCustomEditor( Calendar.class, new CustomCalendarEditor(
            new SimpleDateFormat( "MM/dd/yyyy" ), true ) );
    }

    protected Object formBackingObject( HttpServletRequest request )
        throws Exception
    {
    	Assignment assignment = assignmentDao.getAssignmentById( Integer.valueOf( request
                .getParameter( "assignmentId" ) ) );    	
       	
    	request.setAttribute("title", assignment.getName());
    	request.setAttribute("section", assignment.getSection());
    	request.setAttribute("start", assignment.getDueDate());
    	request.setAttribute("end", assignment.getDueDate());
    	
        return assignment;
    }

    protected ModelAndView onSubmit( HttpServletRequest request,
        HttpServletResponse response, Object command, BindException errors )
    {
        Assignment assignment = (Assignment) command;
        
        Event event = eventDao.getEventByAssignment((String) request.getAttribute("title"),
        		(Section) request.getAttribute("section"), (Calendar) request.getAttribute("start"),
        		(Calendar) request.getAttribute("end"));
        
        if (event != null) {
            event.setTitle(assignment.getName());
            event.setStartTime(assignment.getDueDate());
            event.setEndTime(assignment.getDueDate());
            eventDao.saveEvent(event);
        }
        
        assignmentDao.saveAssignment( assignment );

        return new ModelAndView( getSuccessView() );
    }

    public void setAssignmentDao( AssignmentDao assignmentDao )
    {
        this.assignmentDao = assignmentDao;
    }

	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}

}
