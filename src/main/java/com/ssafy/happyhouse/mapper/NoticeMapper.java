package com.ssafy.happyhouse.mapper;

import java.util.ArrayList;

import com.ssafy.happyhouse.model.dto.NoticeDto;

public interface NoticeMapper {
    int selectTotalCount();
    ArrayList<NoticeDto> selectPage(int startRow, int countPerPage);
    NoticeDto findByNum(int bnum);
    int updateReadCnt(int bnum);
    int delete(int bnum);
    int update(NoticeDto notice);
    int save(NoticeDto notice);
}
