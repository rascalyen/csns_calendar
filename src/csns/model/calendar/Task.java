package csns.model.calendar;

import java.io.Serializable;
import java.util.*;
import csns.model.User;

public class Task implements Serializable {
	
	private static final long serialVersionUID = 1L;

	protected Integer         id;
	
    protected String          title;
    protected Calendar        completedDate;
    protected User            creator;

    
    public Task() {
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

	public Calendar getCompletedDate() {
		return completedDate;
	}

	public void setCompletedDate(Calendar completedDate) {
		this.completedDate = completedDate;
	}

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}


}
