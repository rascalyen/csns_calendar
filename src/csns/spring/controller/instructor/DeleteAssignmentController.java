package csns.spring.controller.instructor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import csns.model.assignment.Assignment;
import csns.model.assignment.dao.AssignmentDao;
import csns.model.calendar.Event;
import csns.model.calendar.dao.EventDao;

public class DeleteAssignmentController extends AbstractController {

    private AssignmentDao assignmentDao;
    private EventDao eventDao;

    public ModelAndView handleRequestInternal( HttpServletRequest request,
        HttpServletResponse response ) throws Exception
    {
        String assignmentId = request.getParameter( "assignmentId" );
        Assignment assignment = assignmentDao.getAssignmentById( Integer
            .valueOf( assignmentId ) );
        
        Event event = eventDao.getEventByAssignment(assignment.getName(), assignment.getSection(),
        		assignment.getDueDate(), assignment.getDueDate());
        
        if (event != null)        	
            eventDao.deleteEvent(event);
        
        assignment.setSection( null );
        assignmentDao.saveAssignment( assignment );

        return new ModelAndView( "redirect:/instructor/home.html" );
    }

    public void setAssignmentDao( AssignmentDao assignmentDao )
    {
        this.assignmentDao = assignmentDao;
    }

	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}

}
