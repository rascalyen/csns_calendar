package csns.spring.controller.calendar;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import csns.spring.controller.AbstractDownloadZipController;
import csns.spring.security.SecurityUtils;


public class DownloadEventZipController extends AbstractDownloadZipController {

	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception 
	{
        String username = SecurityUtils.getUsername();		
        String eventId = request.getParameter( "eventId" );
        if( eventId == null )
            return new ModelAndView( "error" ).addObject( "error",
                    "Download Failed" ).addObject( "errorCause",
                    "Event id must be specified." );		
		
        try
        {        	
            downloadEventFilesAsZip( Integer.valueOf( eventId ),
                        response );
                logger.info( username + " downloaded files for event "
                        + eventId );
        }
        catch( IOException e )
        {
            logger.error( "Download Zip failed." );
            logger.error( e.getMessage() );
        }        
		
		return null;
	}

}