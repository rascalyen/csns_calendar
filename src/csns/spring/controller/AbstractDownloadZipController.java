package csns.spring.controller;

import java.io.IOException;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.servlet.http.HttpServletResponse;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.mvc.AbstractController;
import csns.model.File;
import csns.model.Section;
import csns.model.User;
import csns.model.assignment.Assignment;
import csns.model.assignment.Submission;
import csns.model.assignment.dao.AssignmentDao;
import csns.model.assignment.dao.SubmissionDao;
import csns.model.calendar.Event;
import csns.model.calendar.dao.EventDao;
import csns.model.dao.SectionDao;
import csns.model.dao.UserDao;

public abstract class AbstractDownloadZipController extends AbstractController {

    protected SectionDao    sectionDao;
    protected AssignmentDao assignmentDao;
    protected SubmissionDao submissionDao;
    protected UserDao       userDao;
    protected EventDao      eventDao;

	protected String        fileBaseDir;

    protected void downloadSectionFilesAsZip( User user, Integer sectionId,
        HttpServletResponse response ) throws IOException
    {
        Section section = sectionDao.getSectionById( sectionId );
        String name = section.getCourse().getCode();
        response.setContentType( "application/zip" );
        response.setHeader( "Content-Disposition", "attachment; filename="
            + name + ".zip" );

        ZipOutputStream out = new ZipOutputStream( response.getOutputStream() );
        for( Assignment assignment : section.getAssignments() )
        {
            String dir = assignment.getShortName();
            Submission submission = submissionDao.getSubmission( user,
                assignment );
            if( submission != null )
                addToZip( dir, submission.getFiles(), out );
        }
        out.close();
    }

    protected void downloadAssignmentFilesAsZip( Integer assignmentId,
        HttpServletResponse response ) throws IOException
    {
        Assignment assignment = assignmentDao.getAssignmentById( assignmentId );
        String name = assignment.getShortName().replace( ' ', '_' );
        response.setContentType( "application/zip" );
        response.setHeader( "Content-Disposition", "attachment; filename="
            + name + ".zip" );

        ZipOutputStream out = new ZipOutputStream( response.getOutputStream() );
        for( Submission submission : assignment.getSubmissions() )
        {
            String dir = submission.getStudent().getLastName() + "."
                + submission.getStudent().getFirstName();
            addToZip( dir, submission.getFiles(), out );
        }
        out.close();
    }

    protected void downloadEventFilesAsZip(Integer eventId, 
    	HttpServletResponse response ) throws IOException 
    {
    	Event event = eventDao.getEventById(eventId);
    	String title = event.getTitle().replace( ' ', '_' );
        response.setContentType( "application/zip" );
        response.setHeader( "Content-Disposition", "attachment; filename="
            + title + ".zip" );
        
        ZipOutputStream out = new ZipOutputStream( response.getOutputStream() );
        addToZip( title, event.getAttachments(), out );
        out.close();
    }
    
    protected void downloadSubmissionFilesAsZip( Integer submissionId,
        HttpServletResponse response ) throws IOException
    {
        Submission submission = submissionDao.getSubmissionById( submissionId );
        String name = submission.getAssignment().getShortName().replace( ' ',
            '_' );
        if( !StringUtils.hasText( name ) )
            name = submission.getId().toString();
        response.setContentType( "application/zip" );
        response.setHeader( "Content-Disposition", "attachment; filename="
            + name + ".zip" );

        ZipOutputStream out = new ZipOutputStream( response.getOutputStream() );
        addToZip( name, submission.getFiles(), out );
        out.close();
    }

    protected void addToZip( String dir, Set<File> files, ZipOutputStream zip )
        throws IOException
    {
        for( File file : files )
        {
            zip.putNextEntry( new ZipEntry( dir + "/" + file.getName() ) );
            file.setBaseDir( fileBaseDir );
            file.read( zip );
            zip.closeEntry();
        }
    }

    public void setAssignmentDao( AssignmentDao assignmentDao )
    {
        this.assignmentDao = assignmentDao;
    }

    public void setFileBaseDir( String fileBaseDir )
    {
        this.fileBaseDir = fileBaseDir;
    }

    public void setSectionDao( SectionDao sectionDao )
    {
        this.sectionDao = sectionDao;
    }

    public void setSubmissionDao( SubmissionDao submissionDao )
    {
        this.submissionDao = submissionDao;
    }

    public void setUserDao( UserDao userDao )
    {
        this.userDao = userDao;
    }
    
    public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}    

}
