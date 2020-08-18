package com.koreait.pjt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

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
}
