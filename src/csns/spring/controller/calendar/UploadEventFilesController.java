package csns.spring.controller.calendar;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import csns.model.File;
import csns.model.User;
import csns.model.assignment.Assignment;
import csns.model.calendar.Event;
import csns.model.calendar.dao.EventDao;
import csns.model.dao.FileDao;
import csns.model.dao.UserDao;
import csns.spring.security.SecurityUtils;


public class UploadEventFilesController extends AbstractController {
	
    private EventDao      eventDao;
    private FileDao       fileDao;
    private UserDao       userDao;

    private String        fileBaseDir;
	
    @SuppressWarnings("rawtypes")
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception 
	{
        String eventId = request.getParameter( "eventId" );
        Event event = eventDao.getEventById( Integer
            .valueOf( eventId ) );
		
        User user = userDao.getUserByName( SecurityUtils.getUsername() );
        
        
        List<String> errors = new ArrayList<String>();		
        if( request instanceof MultipartHttpServletRequest )
        {
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            Iterator i = multipartRequest.getFileNames();
            while( i.hasNext() )
            {
                MultipartFile uploadedFile = multipartRequest
                    .getFile( (String) i.next() );
                String fileName = uploadedFile.getOriginalFilename();

                if( uploadedFile.isEmpty() )
                {
                    errors.add( fileName + " is empty." );
                    continue;
                }

                File file = event.getAttachmentByName( fileName );
                if( file != null )
                    file.increaseVersion();
                else
                {
                    file = new File();
                    file.setName( fileName );
                    file.setPublic(true);
                    file.setOwner( user );
                    file.setSection( event.getSection() );
                    event.addAttachment(file);
                }
                file.setType( uploadedFile.getContentType() );
                file.setSize( uploadedFile.getSize() );
                file.setDate( new Date() );
                file.setBaseDir( fileBaseDir );
                fileDao.saveFile( file );

                try
                {
                    uploadedFile.transferTo( file.getDiskFile() );
                }
                catch( IOException e )
                {
                    logger.error( e );
                }
            }

            eventDao.saveEvent(event);
        }
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String year = request.getParameter("year");		
        
        return new ModelAndView( "calendar/uploadEventFiles" ).addObject(
            "event", event ).addObject( "errors", errors ).addObject("month", month
            ).addObject("day", day).addObject("year", year);
				
	}

	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}

	public void setFileDao(FileDao fileDao) {
		this.fileDao = fileDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public void setFileBaseDir(String fileBaseDir) {
		this.fileBaseDir = fileBaseDir;
	}
    
}
