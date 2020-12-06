package com.ssafy.happyhouse.model.dto;

public class NoticeDto {

    private int bnum; // 글번호
    private String btitle; // 제목
    private String bwriter; // 작성자
    private int bread_cnt; // 조회수
    private String bwriteDate; // 작성일시
    private String bcontent;// 글 내용

    public NoticeDto() {
    }

    public NoticeDto(int bnum, String btitle, String bwriter, int bread_cnt, String bwriteDate, String bcontent) {
        this.bnum = bnum;
        this.btitle = btitle;
        this.bwriter = bwriter;
        this.bread_cnt = bread_cnt;
        this.bwriteDate = bwriteDate;
        this.bcontent = bcontent;
    }

    public int getBnum() {
        return bnum;
    }

    public void setBnum(int bnum) {
        this.bnum = bnum;
    }

    public String getBtitle() {
        return btitle;
    }

    public void setBtitle(String btitle) {
        this.btitle = btitle;
    }

    public String getBwriter() {
        return bwriter;
    }

    public void setBwriter(String bwriter) {
        this.bwriter = bwriter;
    }

    public int getBread_cnt() {
        return bread_cnt;
    }

    public void setBread_cnt(int bread_cnt) {
        this.bread_cnt = bread_cnt;
    }

    public String getBwriteDate() {
        return bwriteDate;
    }

    public void setBwriteDate(String bwriteDate) {
        this.bwriteDate = bwriteDate;
    }

    public String getBcontent() {
        return bcontent;
    }

    public void setBcontent(String bcontent) {
        this.bcontent = bcontent;
    }

    @Override
    public String toString() {
        return "Notice{" +
                "bnum=" + bnum +
                ", btitle='" + btitle + '\'' +
                ", bwriter='" + bwriter + '\'' +
                ", bread_cnt=" + bread_cnt +
                ", bwriteDate='" + bwriteDate + '\'' +
                ", bcontent='" + bcontent + '\'' +
                '}';
    }
}
