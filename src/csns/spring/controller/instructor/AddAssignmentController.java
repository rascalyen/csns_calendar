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
import csns.model.User;
import csns.model.assignment.Assignment;
import csns.model.assignment.AssignmentTemplate;
import csns.model.assignment.OnlineAssignment;
import csns.model.assignment.dao.AssignmentTemplateDao;
import csns.model.calendar.Event;
import csns.model.calendar.dao.EventDao;
import csns.model.dao.SectionDao;
import csns.model.dao.UserDao;
import csns.spring.CustomCalendarEditor;
import csns.spring.security.SecurityUtils;

public class AddAssignmentController extends SimpleFormController {

    private UserDao               userDao;
    private SectionDao            sectionDao;
    private AssignmentTemplateDao assignmentTemplateDao;
    private EventDao              eventDao;
    
    protected void initBinder( HttpServletRequest request,
        ServletRequestDataBinder binder ) throws Exception
    {
        binder.registerCustomEditor( Calendar.class, new CustomCalendarEditor(
            new SimpleDateFormat( "MM/dd/yyyy" ), true ) );
    }

    protected Object formBackingObject( HttpServletRequest request )
        throws Exception
    {
        String templateId = request.getParameter( "templateId" );
        Assignment assignment = new Assignment();
        if( templateId != null )
        {
            AssignmentTemplate assignmentTemplate = assignmentTemplateDao
                .getAssignmentTemplateById( Integer.valueOf( templateId ) );
            assignment = assignmentTemplate.isOnline() ? new OnlineAssignment(
                assignmentTemplate ) : new Assignment( assignmentTemplate );
        }

        String sectionId = request.getParameter( "sectionId" );
        Section section = sectionDao.getSectionById( Integer
            .valueOf( sectionId ) );
        request.setAttribute( "section", section );

        return assignment;
    }

    protected ModelAndView onSubmit( HttpServletRequest request,
        HttpServletResponse response, Object command, BindException errors )
    {
        Assignment assignment = (Assignment) command;
        User user = userDao.getUserByName( SecurityUtils.getUsername() );
        if( assignment.isOnline() )
        {
            ((OnlineAssignment) assignment).getQuestionSheet()
                .setCreator( user );
        }

        String sectionId = request.getParameter( "sectionId" );
        Section section = sectionDao.getSectionById( Integer
            .valueOf( sectionId ) );
        assignment.setSection( section );
        section.addAssignment( assignment );
        sectionDao.saveSection( section );
        
        Event event = new Event();
        event.setTitle(assignment.getName());
        event.setStartTime(assignment.getDueDate());
        event.setEndTime(assignment.getDueDate());
        event.setOpen(false);
        event.setSection(section);
        event.setCreator(user);
        eventDao.saveEvent(event);
        
        return new ModelAndView( getSuccessView() );
    }

    public void setUserDao( UserDao userDao )
    {
        this.userDao = userDao;
    }

    public void setSectionDao( SectionDao sectionDao )
    {
        this.sectionDao = sectionDao;
    }    
    
    public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}

	public void setAssignmentTemplateDao(
        AssignmentTemplateDao assignmentTemplateDao )
    {
        this.assignmentTemplateDao = assignmentTemplateDao;
    }

}
