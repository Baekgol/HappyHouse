package com.ssafy.happyhouse.model.dto;

public class HouseDealDto {

	private String no;
	private String dong;
	private String AptName;
	private String code;
	private String dealAmount;
	private String dealAmountInt;
	private String buildYear;
	private String dealYear;
	private String dealMonth;
	private String dealDay;
	private String area;
	private String floor;
	private String jibun;
	private String rentMoney;
	private String avgGuName;
	private double avg;
	private int cnt;
	private String type;
	private InterestDto interest;
	
	public InterestDto getInterest() {
		return interest;
	}
	public void setInterest(InterestDto interest) {
		this.interest = interest;
	}
	public String getDealMonth() {
		return dealMonth;
	}
	public void setDealMonth(String dealMonth) {
		this.dealMonth = dealMonth;
	}
	public String getDealDay() {
		return dealDay;
	}
	public void setDealDay(String dealDay) {
		this.dealDay = dealDay;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRentMoney() {
		return rentMoney;
	}
	public void setRentMoney(String rentMoney) {
		this.rentMoney = rentMoney;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	public double getAvg() {
		return avg;
	}
	public void setAvg(double avg) {
		this.avg = avg;
	}
	public String getAvgGuName() {
		return avgGuName;
	}
	public void setAvgGuName(String avgGuName) {
		this.avgGuName = avgGuName;
	}
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getAptName() {
		return AptName;
	}
	public void setAptName(String aptName) {
		AptName = aptName;
	}
	public String getDealAmount() {
		return dealAmount;
	}
	public void setDealAmount(String dealAmount) {
		this.dealAmount = dealAmount;
	}
	public String getBuildYear() {
		return buildYear;
	}
	public void setBuildYear(String buildYear) {
		this.buildYear = buildYear;
	}
	public String getDealYear() {
		return dealYear;
	}
	public void setDealYear(String dealYear) {
		this.dealYear = dealYear;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getFloor() {
		return floor;
	}
	public void setFloor(String floor) {
		this.floor = floor;
	}
	public String getJibun() {
		return jibun;
	}
	public void setJibun(String jibun) {
		this.jibun = jibun;
	}

	public String getDealAmountInt() {
		return dealAmountInt;
	}
	public void setDealAmountInt(String dealAmountInt) {
		this.dealAmountInt = dealAmountInt;
	}
	@Override
	public String toString() {
		return "HouseDealDto [no=" + no + ", dong=" + dong + ", AptName=" + AptName + ", dealAmount=" + dealAmount
				+ ", dealAmountInt=" + dealAmountInt + ", buildYear=" + buildYear + ", dealYear=" + dealYear + ", area="
				+ area + ", floor=" + floor + ", jibun=" + jibun + ", avgGuName=" + avgGuName + ", avg=" + avg
				+ ", cnt=" + cnt + "]";
	}
	

}
