package com.ssafy.happyhouse.model.dto;

import java.util.ArrayList;

public class QnaPageDto {
	private ArrayList<QnaDto> qnaList;
	private int curPage;
	private int startPage;
	private int endPage;
	private int totalPage;
	
	public QnaPageDto() {
	}

	public QnaPageDto(ArrayList<QnaDto> qnaList, int curPage, int startPage, int endPage,
					  int totalPage) {
		this.qnaList = qnaList;
		this.curPage = curPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.totalPage = totalPage;
	}

	public ArrayList<QnaDto> getQnaList() {
		return qnaList;
	}

	public void setQnaList(ArrayList<QnaDto> qnaList) {
		this.qnaList = qnaList;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	@Override
	public String toString() {
		return "QnaPageDto [qnaList=" + qnaList + ", curPage=" + curPage + ", startPage=" + startPage + ", endPage="
				+ endPage + ", totalPage=" + totalPage + "]";
	}

}
