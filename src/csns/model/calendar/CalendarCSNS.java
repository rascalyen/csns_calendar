package csns.model.calendar;

import java.util.Calendar;
import java.util.GregorianCalendar;

public class CalendarCSNS {

	Calendar calendar = null;
	private int year;
	private int month;
	private int day;
    private String[] months = {"January", "February", "March", "April", "May", "June", 
	           "July", "August", "September", "October", "November", "December" };
	
	public CalendarCSNS() {	
		calendar = new GregorianCalendar();
		year = calendar.get(Calendar.YEAR);
		month = calendar.get(Calendar.MONTH);
		day = calendar.get(Calendar.DAY_OF_MONTH);
	}
	
	public CalendarCSNS(int year, int month, int day) {
		calendar = new GregorianCalendar();
		this.year = year;
		this.month = month;
		this.day = day;
	}
	
	public int getTotalDaysOfMonth() {
        Calendar cal = new GregorianCalendar (year, month, 1);
        int days = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		return days;
	}
	
	public int getStartDayOfFirstWeek() {
		Calendar cal = new GregorianCalendar (year, month, 1);
		int start = cal.get(Calendar.DAY_OF_WEEK);
		return start;
	}
	
	public int getTotalWeeksOfMonth() {
		Calendar cal = new GregorianCalendar (year, month, getTotalDaysOfMonth());
		int weeks = cal.get(Calendar.WEEK_OF_MONTH);
		return weeks;
	}
	
	public String getThisMonth() {
	    return (months[month]);
	}
	
	public String getNextMonth() {
		if (month+1 > 11)
	        return (months[0]);
		else
			return (months[month+1]);
	}
	
	public String getPreMonth() {
		if (month-1 < 0)
			return (months[11]);
		else
	        return (months[month-1]);
	}
	
	public int getYear() {
		return year;
	}

	public int getCurrentYear() {
		return calendar.get(Calendar.YEAR);
	}	
	
	public int getMonth() {
		return month;
	}
	
	public int getCurrentMonth() {
		return calendar.get(Calendar.MONTH);
	}	
	
	public int getDay() {
		return day;
	}
	
	public int getCurrentDay() {
		return calendar.get(Calendar.DAY_OF_MONTH);
	}

}
