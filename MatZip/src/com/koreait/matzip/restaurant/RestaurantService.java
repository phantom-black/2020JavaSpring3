package com.koreait.matzip.restaurant;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import com.google.gson.Gson;
import com.koreait.matzip.CommonUtils;
import com.koreait.matzip.FileUtils;
import com.koreait.matzip.vo.RestaurantDomain;
import com.koreait.matzip.vo.RestaurantRecommendMenuVO;
import com.koreait.matzip.vo.RestaurantVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class RestaurantService { // Service는 로직 단
	private RestaurantDAO dao;
	
	public RestaurantService() {
		dao = new RestaurantDAO();
	}
	
	public int restReg(RestaurantVO param) {
		return dao.insRestaurant(param);
	}
	
	public String getRestList() {
		List<RestaurantDomain> list = dao.selRestList();
		Gson gson = new Gson();
		
		return gson.toJson(list);
	}
	
	public RestaurantDomain getRest(RestaurantVO param) {
		return dao.selRest(param);
	}
	
	public int addMenus(HttpServletRequest request) { // 메뉴
		int i_rest = CommonUtils.getIntParameter("i_rest", request);
		System.out.println("i_rest: " + i_rest);
		
		String targetPath = request.getServletContext().getRealPath("/res/img/restaurant/" + i_rest + "/menu");
		FileUtils.makeFolder(targetPath);
		
		RestaurantRecommendMenuVO param = new RestaurantRecommendMenuVO();
		param.setI_rest(i_rest);
		
		try {
			for(Part part : request.getParts()) {
				String fileNm = part.getSubmittedFileName();
				System.out.println("fileNm: " + fileNm);
				
				if(fileNm != null) {
					String ext = FileUtils.getExt(fileNm);
					String saveFileNm = UUID.randomUUID() + ext;
					part.write(targetPath + "/" + saveFileNm); // 파일 저장
					
					param.setMenu_pic(saveFileNm);
					dao.insMenu(param);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return i_rest;
	}
	
	public int addRecMenus(HttpServletRequest request) { // 추천메뉴
		String savePath = request.getServletContext().getRealPath("/res/img/restaurant");
		String tempPath = savePath + "/temp"; // 임시  cf) getRealPath() : WAS에서 돌아가고 있는 webapp까지의 절대 주솟값이 넘어옴(현재 위치의 절대 주솟값 <- 절대주소: C/D 등 드라이브부터 시작함)
		FileUtils.makeFolder(tempPath);
		
		int maxFileSize = 10_485_760; // 1024 * 1024 * 10 (10mb) // 최대 파일 사이즈 크기
		MultipartRequest multi = null;
		int i_rest = 0;
		String[] menu_nmArr = null;
		String[] menu_priceArr = null;
		List<RestaurantRecommendMenuVO> list = null;
		
		// file은 getParameter나 getParameterValues로 받을 수 없다
		try {
			multi = new MultipartRequest(request, tempPath, maxFileSize, "UTF-8", new DefaultFileRenamePolicy()); // 중복되는 값 있어도 알아서 이름 변경해서 넣어줌(?)
			
			i_rest = CommonUtils.getIntParameter("i_rest", multi);
			
			System.out.println("i_rest: " +i_rest);
			menu_nmArr = multi.getParameterValues("menu_nm");
			menu_priceArr = multi.getParameterValues("menu_price");
			
			if(menu_nmArr == null || menu_priceArr == null) {
				return i_rest;
			}

			list = new ArrayList();
			
			for(int i=0; i<menu_nmArr.length; i++) {
				RestaurantRecommendMenuVO vo = new RestaurantRecommendMenuVO();
				vo.setI_rest(i_rest);
				vo.setMenu_nm(menu_nmArr[i]);
				vo.setMenu_price(CommonUtils.parseStrToInt(menu_priceArr[i]));
				list.add(vo);
			}
			
			// 이미지관련 시작
			String targetPath = savePath + "/" + i_rest;
			FileUtils.makeFolder(targetPath);
			
			String originFileNm = "";
			Enumeration files = multi.getFileNames();
			
			while(files.hasMoreElements()) {
				String key = (String)files.nextElement(); // 다음 요소 가리키며 키 값 전달
				System.out.println("key: " + key);
				originFileNm = multi.getFilesystemName(key); // 키의 파일명 전달
				System.out.println("fileNm: " + originFileNm);
				
				if(originFileNm != null) { // 파일 선택을 안 했으면 null이 넘어옴
					String ext = FileUtils.getExt(originFileNm); // 확장자명 받아오기
					String saveFileNm = UUID.randomUUID() + ext; // 실제로 db에 저장될 파일 이름
					
					System.out.println("saveFileNm: " + saveFileNm);
					File oldFile = new File(tempPath + "/" + originFileNm);
					File newFile = new File(targetPath + "/" + saveFileNm);
					oldFile.renameTo(newFile);
					
					int idx = CommonUtils.parseStrToInt(key.substring(key.lastIndexOf("_")+1));
					RestaurantRecommendMenuVO vo = list.get(idx);
					vo.setMenu_pic(saveFileNm);
				}
			}
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		if(list != null) {
			for(RestaurantRecommendMenuVO vo : list) {
				dao.insRecommendMenu(vo);
			}
		}
		
		return i_rest;
	}
	
	public List<RestaurantRecommendMenuVO> getMenuList(int i_rest) {
		return dao.selMenuList(i_rest);
	}
	
	public List<RestaurantRecommendMenuVO> getRecommendMenuList(int i_rest) {
		return dao.selRecommendMenuList(i_rest);
	}
	
	public int delRecMenu(RestaurantRecommendMenuVO param) {
		return dao.delRecommendMenu(param);
	}
}
