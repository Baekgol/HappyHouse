package com.ssafy.happyhouse.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.InterestDto;
import com.ssafy.happyhouse.model.dto.MemberDto;
import com.ssafy.happyhouse.model.service.HouseDealService;
import com.ssafy.happyhouse.model.service.HouseService;

@Controller
@CrossOrigin(origins = "*")
public class MyDealController {
	
	@Autowired
	private HouseDealService dealService;
	
	@Autowired
	private HouseService infoService;
	
	@GetMapping("/dealList")
	public String mvDealList(Model model, HttpSession session) {
		
		MemberDto user = (MemberDto)session.getAttribute("loginInfo");
		if(user != null) {
			model.addAttribute("myDealList", dealService.selectByUserId(user.getUserid()));
			return "deal/myDealList";
		}
		else
			return "login-error";
		
		
	}
	
	@PostMapping("/dealDel")
	@ResponseBody
	public String deleteInterest(@RequestParam(value = "dealNo") int dealNo, HttpSession httpSession) {
		dealService.deleteMyDealByNo(dealNo);
		return "myDealList";
	}

	@GetMapping("/dealAdd")
	public String mvDealAdd(HttpSession session) {
		MemberDto user = (MemberDto)session.getAttribute("loginInfo");
		if(user != null) 
			return "deal/myDealAdd";
		else
			return "login-error";
	}
	
	@PostMapping("/dealAdd")
	public String myDealAdd(@RequestParam Map<String, String> param, HouseDealDto dealDto, HouseInfoDto infoDto, HttpSession session, Model model) {
		
		MemberDto user = (MemberDto)session.getAttribute("loginInfo");
		if(user != null) {
			dealDto.setType(user.getUserid());		// 아이디 저장
			
			dealDto.setCode(dealDto.getCode().substring(0, 5));		// 지역코드 앞 다섯자리만 저장
			infoDto.setCode(infoDto.getCode().substring(0, 5));
			
			DecimalFormat df = new DecimalFormat("###,###");
			dealDto.setDealAmount(df.format(Long.parseLong(dealDto.getDealAmountInt()))); // dto에 콤마찍어서 가격 저장..
			
			String jibun = param.get("lnbrMnnm") + "-" + param.get("lnbrSlno"); // 지번 이어주기.. 후 저장
			dealDto.setJibun(jibun);
			infoDto.setJibun(jibun);
			
			if (dealDto.getAptName().length() == 0) {
				dealDto.setAptName(jibun); // 건물명이 없을 경우 그냥 지번 넣어줄것..
				infoDto.setAptName(jibun);
			} else {
				infoDto.setAptName(dealDto.getAptName());
			}
			
			String[] dealDate = param.get("dealDate").split("-");
			dealDto.setDealYear(dealDate[0]);
			dealDto.setDealMonth(dealDate[1]);
			dealDto.setDealDay(dealDate[2]);
			
			// 매물을 등록하자..
			dealService.insertHouseDeal(dealDto);
			
			String address = param.get("address");  // 주소로 좌표 찾아내야함...
			
			String coords[] = geoCode(address);		// 좌표 변환 후 저장
			infoDto.setLat(coords[0]+"");
			infoDto.setLng(coords[1]+"");
			if(infoService.isExistHouseInfo(coords[0], coords[1])==0)	// 테이블에 건물이 없을 경우에만 넣기
				infoService.insertHouseInfo(infoDto);
			
			return "redirect:/dealList";
			
		}
		return "login-error";

	}

	@RequestMapping("/popup")
	public String jusoPopup() {
		return "deal/jusoPopup";
	}


	
	// 좌표 변환해주는 지오코드..
	public static String[] geoCode(String keyword) {
		String apiURL = "http://api.vworld.kr/req/address";
        String[] resultArr = new String[2];
        try{
              int responseCode = 0;
              URL url = new URL(apiURL);
              HttpURLConnection con = (HttpURLConnection)url.openConnection();
              con.setRequestMethod("POST");
 
              String text_content =  URLEncoder.encode(keyword.toString(), "utf-8");
              //String text_content =  URLEncoder.encode(keyword.toString());
               
              // post request
              String postParams = "service=address";
                     postParams += "&request=getcoord";                     
                     postParams += "&version=2.0";
                     postParams += "&crs=EPSG:4326";
                     postParams += "&address="+text_content;                                    
                     postParams += "&arefine=true";
                     postParams += "&simple=false";                  
                     postParams += "&format=json";
                     postParams += "&type=road";    
                     postParams += "&errorFormat=json";
                     postParams += "&key=68D76929-A6B0-3031-B8CE-7B2DCEE780E3";                    
 
              con.setDoOutput(true);
              DataOutputStream wr = new DataOutputStream(con.getOutputStream());
              wr.writeBytes(postParams);
              wr.flush();
              wr.close();
              responseCode = con.getResponseCode();
              BufferedReader br;
               
              if(responseCode==200) { // 정상 호출
                  br = new BufferedReader(new InputStreamReader(con.getInputStream()));
              }else{  // 에러 발생
                  br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
              }
 
              String inputLine;
              StringBuffer response = new StringBuffer();
 
              while ((inputLine = br.readLine()) != null) {
                  response.append(inputLine);
              }

              JSONParser json = new JSONParser();
              JSONObject obj = (JSONObject)json.parse(response.toString());
              JSONObject obj2 = (JSONObject)obj.get("response");
              JSONObject obj3 = (JSONObject)obj2.get("result");
              JSONObject obj4 = (JSONObject)obj3.get("point");
              String x = (String) obj4.get("x");
              String y = (String) obj4.get("y");
              resultArr[1] = x;
              resultArr[0] = y;
              
              br.close();
              con.disconnect();

              return resultArr;
          }catch(Exception e){          
              e.printStackTrace();
              return resultArr;
          }
	}
	
}
