package com.ssafy.happyhouse.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.mapper.MemberMapper;
import com.ssafy.happyhouse.model.dto.MemberDto;
import com.ssafy.happyhouse.model.dto.SidoGugunCodeDto;

import java.util.List;

@Service
public class MemberService {

    @Autowired
    SqlSession sqlSession;

    public MemberDto findById(String userid) {
         return sqlSession.getMapper(MemberMapper.class).findById(userid);
    }

    public boolean checkPwd(String pw, String confirm) {
        return pw.equals(confirm);
    }

    public int save(MemberDto member) {
        return sqlSession.getMapper(MemberMapper.class).saveMember(member);
    }

    public int updateMember(MemberDto member) {
        return sqlSession.getMapper(MemberMapper.class).updateMember(member);
    }

    public int delete(String userid) {
        return sqlSession.getMapper(MemberMapper.class).delete(userid);
    }

    public List<MemberDto> findAll() {
        return sqlSession.getMapper(MemberMapper.class).findAll();
    }
    
    public SidoGugunCodeDto getSidoName(int sidoCode) {
    	return sqlSession.getMapper(MemberMapper.class).getSidoName(sidoCode);
    }
}
