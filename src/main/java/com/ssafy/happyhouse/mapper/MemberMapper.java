package com.ssafy.happyhouse.mapper;

import java.util.List;

import com.ssafy.happyhouse.model.dto.MemberDto;
import com.ssafy.happyhouse.model.dto.SidoGugunCodeDto;

public interface MemberMapper {
    MemberDto findById(String id);
    int saveMember(MemberDto member);
    int updateMember(MemberDto member);
    int delete(String userid);
    List<MemberDto> findAll();
    SidoGugunCodeDto getSidoName(int sidoCode);
}
