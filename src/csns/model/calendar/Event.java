package csns.model.calendar;

import java.io.Serializable;
import java.util.*;
import csns.model.File;
import csns.model.Section;
import csns.model.User;

public class Event implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	protected Integer                id;

    protected String                 title;
    protected String                 description;
    protected Calendar               startTime;
	protected Calendar               endTime;
	protected boolean                open;
	protected Section                section;
	protected User                   creator;
	
	protected Set<File>              attachments;
	

	public Event() {
        attachments = new HashSet<File>();
        open = false;
	}
	
	public Event(Calendar startTime, Calendar endTime) {
		this.startTime = startTime;
		this.endTime = endTime;
	    endTime.set( Calendar.HOUR_OF_DAY, 23 );
	    endTime.set( Calendar.MINUTE, 59 );
	    endTime.set( Calendar.SECOND, 59 );
	}
	
	
    public void addAttachment( File file )
    {
        attachments.add( file );
    }	
    
    public File getAttachmentByName( String fileName )
    {
        for( File file : attachments )
            if( file.getName().equals( fileName ) ) return file;

        return null;
    }    
	
    public int getAttachmentCount()
    {
        return attachments.size();
    }	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Calendar getStartTime() {
		return startTime;
	}

	public void setStartTime(Calendar startTime) {
		this.startTime = startTime;
	}

	public Integer getStartTimeDay() {
		return startTime.get(Calendar.DAY_OF_MONTH);
	}
	
    public Integer getStartTimeHour()
    {
        return startTime != null ? startTime.get( Calendar.HOUR_OF_DAY ) : null;
    }

    public void setStartTimeHour( Integer hour )
    {
        if( startTime != null )
        {
            if( hour == null ) hour = 0;
            startTime.set( Calendar.HOUR_OF_DAY, hour );
        }
    }

    public Integer getStartTimeMinute()
    {
        return startTime != null ? startTime.get( Calendar.MINUTE ) : null;
    }

    public void setStartTimeMinute( Integer minute )
    {
        if( startTime != null )
        {
            if( minute == null ) minute = 0;
            startTime.set( Calendar.MINUTE, minute );
        }
    }

    public Integer getStartTimeSecond()
    {
        return startTime != null ? startTime.get( Calendar.SECOND ) : null;
    }

    public void setStartTimeSecond( Integer second )
    {
        if( startTime != null )
        {
            if( second == null ) second = 0;
            startTime.set( Calendar.SECOND, second );
        }
    }	
	
	public Calendar getEndTime() {
		return endTime;
	}

	public void setEndTime(Calendar endTime) {
		this.endTime = endTime;
	}
	
    public Integer getEndTimeHour()
    {
        return endTime != null ? endTime.get( Calendar.HOUR_OF_DAY ) : null;
    }

    public void setEndTimeHour( Integer hour )
    {
        if( endTime != null )
        {
            if( hour == null ) hour = 23;
            endTime.set( Calendar.HOUR_OF_DAY, hour );
        }
    }

    public Integer getEndTimeMinute()
    {
        return endTime != null ? endTime.get( Calendar.MINUTE ) : null;
    }

    public void setEndTimeMinute( Integer minute )
    {
        if( endTime != null )
        {
            if( minute == null ) minute = 59;
            endTime.set( Calendar.MINUTE, minute );
        }
    }

    public Integer getEndTimeSecond()
    {
        return endTime != null ? endTime.get( Calendar.SECOND ) : null;
    }

    public void setEndTimeSecond( Integer second )
    {
        if( endTime != null )
        {
            if( second == null ) second = 59;
            endTime.set( Calendar.SECOND, second );
        }
    }	
    
    public boolean isPastEndTime()
    {
        return Calendar.getInstance().after( endTime );
    }
	
	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}

	public Section getSection() {
		return section;
	}

	public void setSection(Section section) {
		this.section = section;
	}

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public Set<File> getAttachments() {
		return attachments;
	}

	public void setAttachments(Set<File> attachments) {
		this.attachments = attachments;
	}

	
}
