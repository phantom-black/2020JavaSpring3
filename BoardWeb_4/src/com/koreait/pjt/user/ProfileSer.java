package com.koreait.pjt.user;

import java.io.IOException;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.UserDAO;
import com.koreait.pjt.vo.UserVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import java.io.File;

@WebServlet("/profile")
public class ProfileSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	// 프로필 화면 (나의 프로필 이미지, 이미지 변경 가능한 화면)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(MyUtils.isLogout(request)) {
			response.sendRedirect("/login");
			return;
		}
		
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		request.setAttribute("data",  UserDAO.selUser(loginUser.getI_user()));
		
		ViewResolver.forward("user/profile", request, response);
	}

	// 이미지 변경 처리  --> 파일 업로드 방식은 무조건 post : 파일이 클 수 있으므로 쿼리스트링으로 못 올리므로 길이 상관없는 post 방식으로 날림
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		String savePath = getServletContext().getRealPath("img") + "/user/" + loginUser.getI_user(); // 저장경로 // getServletContext()까지 어플리케이션 내장객체 얻어오는 것		
		System.out.println("savePath : " + savePath);
		
		// 만약 폴더(디렉토리)가 없다면 폴더 생성
		File directory = new File(savePath);
		if(!directory.exists()) {
			directory.mkdirs();
		}
		
		int maxFileSize = 10_485_760; // 1024 * 1024 * 10 (10mb) // 최대 파일 사이즈 크기
		String fileNm = "";
//		String originFileNm = "";
		String saveFileNm = null;
		
		try {
			MultipartRequest mr = new MultipartRequest(request, savePath
							, maxFileSize, "UTF-8", new DefaultFileRenamePolicy()); // 이미 파일 등록 서버에 됐을 것
			
			System.out.println("mr: " + mr);
			
			Enumeration files = mr.getFileNames();
			
			if(files.hasMoreElements()) {
				String key = (String)files.nextElement(); // key값
				fileNm = mr.getFilesystemName(key);
//				originFileNm = mr.getOriginalFileName(key);
				String ext = fileNm.substring(fileNm.lastIndexOf("."));
				saveFileNm = UUID.randomUUID() + ext;
				
				System.out.println("key: " + key);
				System.out.println("fileNm : " + fileNm);
//				System.out.println("originFileNm : " + originFileNm);
				System.out.println("saveFileNm: " + saveFileNm);
				
				File oldFile = new File(savePath + "/" + fileNm);
				File newFile = new File(savePath + "/" + saveFileNm); // 자바 메모리 상에 파일 객체 만드는 것
				
				oldFile.renameTo(newFile);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		if(saveFileNm != null) { // DB에 프로필 파일명 저장
			UserVO param = new UserVO();
			param.setProfile_img(saveFileNm);
			param.setI_user(loginUser.getI_user());
			
			UserDAO.updUser(param);
		}
		
		response.sendRedirect("/profile");
	}

}
