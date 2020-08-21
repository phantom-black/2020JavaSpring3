package com.koreait.pjt;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.vo.UserVO;

public class MyUtils {
	public static String encryptString(String str) {
		 String sha = "";

	       try{
	          MessageDigest sh = MessageDigest.getInstance("SHA-256");
	          sh.update(str.getBytes()); // 내가 보낸 문자열을 byte 단위로 바꿈
	          byte byteData[] = sh.digest(); 
	          StringBuffer sb = new StringBuffer(); // 요새는 +로 문자열 합쳐도 자동으로 걸리지만 for문 안에서는 StringBuffer() 사용해야만
	          for(int i = 0 ; i < byteData.length ; i++){
	              sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
	          }

	          sha = sb.toString();

	      }catch(NoSuchAlgorithmException e){
	          //e.printStackTrace();
	          System.out.println("Encrypt Error - NoSuchAlgorithmException");
	          sha = null;
	      }

	      return sha;
	}
	
	public static UserVO getLoginUser(HttpServletRequest request) {
		HttpSession hs = request.getSession();
		return (UserVO)hs.getAttribute(Const.LOGIN_USER); // getAttribute("loginUser")
	}
	
	   // return true: 로그인이 안됨!, false: 로그인된 상태
	public static boolean isLogout(HttpServletRequest request) throws IOException {
	      if(null == getLoginUser(request)) {
	         return true;
	      }
	      return false;
	}
	
	public static int parseStrToInt(String str) {
		return parseStrToInt(str, 0);
	}
	
	public static int parseStrToInt(String str, int n) {
		try {
			return Integer.parseInt(str);
		} catch(Exception e) {
			return n;
		}
	}
}
