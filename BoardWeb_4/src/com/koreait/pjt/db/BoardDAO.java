package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.koreait.pjt.vo.BoardVO;

public class BoardDAO {
	public static int insBoard(BoardVO param) {
		String sql = " INSERT INTO t_board4 "
				+ " (i_board, title, ctnt, i_user) "
				+ " VALUES "
				+ " (seq_board4.nextval, ?, ?, ?) ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				
				ps.setNString(1, param.getTitle());
				ps.setNString(2, param.getCtnt());
				ps.setInt(3, param.getI_user());
			}
		});
	}
	
	public static List<BoardVO> selBoardList() {
		List<BoardVO> list = new ArrayList(); // 레퍼런스 변수에 final 붙이면 주솟값 변경 불가(객체의 내용 변경은 가능)
		
		String sql = " SELECT i_board, title, hits, i_user, r_dt "
					+ " FROM t_board4 ORDER BY i_board DESC ";
		int result = JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {}

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					int i_board = rs.getInt("i_board");
					String title = rs.getNString("title");
					int hits = rs.getInt("hits");
					int i_user = rs.getInt("i_user");
					String r_dt = rs.getNString("r_dt");
					
					BoardVO vo = new BoardVO();
					vo.setI_board(i_board);
					vo.setTitle(title);
					vo.setHits(hits);
					vo.setI_user(i_user);
					vo.setR_dt(r_dt);
					
					list.add(vo);
				}
				return 1;
			}
			
		});
		
		return list;
	}
}
