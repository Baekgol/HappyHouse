package com.ssafy.happyhouse.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.mapper.NoticeMapper;
import com.ssafy.happyhouse.model.dto.NoticeDto;
import com.ssafy.happyhouse.model.dto.NoticePageDto;

import java.util.ArrayList;

@Service
public class NoticeService {

    @Autowired
    SqlSession sqlSession;

    public static final int COUNT_PER_PAGE = 10;

    public NoticePageDto makePage(int curPage) {
        int totalCnt = sqlSession.getMapper(NoticeMapper.class).selectTotalCount();
        int totalPageCnt = totalCnt/COUNT_PER_PAGE;
        if(totalCnt%COUNT_PER_PAGE>0) totalPageCnt++;

        int startPage = (curPage-1)/10*10+1;
        int endPage = startPage+9;

        if(totalPageCnt<endPage) endPage = totalPageCnt;

        int startRow = (curPage-1)*10;
        ArrayList<NoticeDto> noticeList = sqlSession.getMapper(NoticeMapper.class).selectPage(startRow, COUNT_PER_PAGE);
        return new NoticePageDto(noticeList, curPage, startPage, endPage, totalPageCnt);
    }

    public NoticeDto findByNum(int bnum) {
        sqlSession.getMapper(NoticeMapper.class).updateReadCnt(bnum);
        return sqlSession.getMapper(NoticeMapper.class).findByNum(bnum);
    }

    public int delete(int bnum) {
        return sqlSession.getMapper(NoticeMapper.class).delete(bnum);
    }

    public int update(NoticeDto notice) {
        return sqlSession.getMapper(NoticeMapper.class).update(notice);
    }

    public int save(NoticeDto notice) {
        return sqlSession.getMapper(NoticeMapper.class).save(notice);
    }
}
