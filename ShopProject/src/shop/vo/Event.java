package shop.vo;

import java.sql.Timestamp;

public class Event {
	protected int bno;
	protected int no;
	protected String title;
	protected String content;
	protected String image;
	protected String writer;
	protected int readCount;
	protected Timestamp eventStart;
	protected Timestamp eventEnd;
	protected Timestamp regDate;

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public Timestamp getEventStart() {
		return eventStart;
	}

	public void setEventStart(Timestamp eventStart) {
		this.eventStart = eventStart;
	}

	public Timestamp getEventEnd() {
		return eventEnd;
	}

	public void setEventEnd(Timestamp eventEnd) {
		this.eventEnd = eventEnd;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

}
