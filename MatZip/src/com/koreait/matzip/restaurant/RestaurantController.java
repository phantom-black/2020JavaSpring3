package com.koreait.matzip.restaurant;

import javax.servlet.http.HttpServletRequest;

import com.koreait.matzip.CommonDAO;
import com.koreait.matzip.CommonUtils;
import com.koreait.matzip.Const;
import com.koreait.matzip.SecurityUtils;
import com.koreait.matzip.ViewRef;
import com.koreait.matzip.vo.RestaurantRecommendMenuVO;
import com.koreait.matzip.vo.RestaurantVO;
import com.koreait.matzip.vo.UserVO;

public class RestaurantController {
	private RestaurantService service;
	
	public RestaurantController() {
		service = new RestaurantService();
	}
	
	public String restMap(HttpServletRequest request) {
		request.setAttribute(Const.TITLE, "지도보기");
		request.setAttribute(Const.VIEW, "restaurant/restMap");
		return ViewRef.TEMP_MENU_TEMP;
	}
	
	public String restReg(HttpServletRequest request) {
		final int I_M = 1; // 카테고리 코드
		request.setAttribute("categoryList",  CommonDAO.selCodeList(I_M));
		
		request.setAttribute(Const.TITLE, "가게 등록");
		request.setAttribute(Const.VIEW, "restaurant/restReg");
		return ViewRef.TEMP_MENU_TEMP;
	}
	
	public String restRegProc(HttpServletRequest request) {
		String nm = request.getParameter("nm");
		String addr = request.getParameter("addr");
		double lat = CommonUtils.getDblParameter("lat", request);
		double lng = CommonUtils.getDblParameter("lng", request);
		int cd_category = CommonUtils.getIntParameter("cd_category", request);
		
		UserVO loginUser = SecurityUtils.getLoginUser(request);

		RestaurantVO param = new RestaurantVO();
		param.setNm(nm);
		param.setAddr(addr);
		param.setLat(lat);
		param.setLng(lng);
		param.setCd_category(cd_category);
		param.setI_user(loginUser.getI_user());
		
		int result = service.restReg(param);
		
		// result 결과값에 따라서 어디로 갈지 정해야, 현재는 잘 넘어간다는 전제 하에 바로 리턴
		return "redirect:/restaurant/restMap";
	}
	
	public String ajaxGetList(HttpServletRequest request) {
		return "ajax: " + service.getRestList();
	}
	
	public String restDetail(HttpServletRequest request) {
		int i_rest = CommonUtils.getIntParameter("i_rest", request);
		
		RestaurantVO param = new RestaurantVO();
		param.setI_rest(i_rest);
		
		request.setAttribute("css", new String[] {"restaurant"});
		
		request.setAttribute("recommendMenuList", service.getRecommendMenuList(i_rest));
		request.setAttribute("data",  service.getRest(param));
		
		request.setAttribute(Const.TITLE, "디테일");
		request.setAttribute(Const.VIEW, "restaurant/restDetail");
		return ViewRef.TEMP_MENU_TEMP;
	}
	
	public String addRecMenusProc(HttpServletRequest request) {
		int i_rest = service.addRecMenus(request); // 너무 길어서 이례적으로 파일처리만 request에게 넘겨줌
		
		return "redirect:/restaurant/restDetail?i_rest="+i_rest;
	}
	
	public String ajaxDelRecMenu(HttpServletRequest request) {
		int i_rest = CommonUtils.getIntParameter("i_rest", request);
		int seq = CommonUtils.getIntParameter("seq", request);
		
		RestaurantRecommendMenuVO param = new RestaurantRecommendMenuVO();
		param.setI_rest(i_rest);
		param.setSeq(seq);
		
		int result = service.delRecMenu(param);
		
		return "ajax:" + result;
	}
}
