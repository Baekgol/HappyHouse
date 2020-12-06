package com.ssafy.happyhouse.model.dto;

public class QnaDto {
	private int id;
	private String title;
	private String userid;
	private String date;
	private int dealno;
	private String contents;
	private String answer;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getDealno() {
		return dealno;
	}
	public void setDealno(int dealno) {
		this.dealno = dealno;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	@Override
	public String toString() {
		return "QnaDto [id=" + id + ", title=" + title + ", userid=" + userid + ", date=" + date + ", dealno=" + dealno
				+ ", contents=" + contents + ", answer=" + answer + "]";
	}
	
	
	

}
