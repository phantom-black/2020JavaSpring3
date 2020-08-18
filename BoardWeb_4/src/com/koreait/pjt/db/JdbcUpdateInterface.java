package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface JdbcUpdateInterface {
	int update(PreparedStatement ps) throws SQLException; // public abstract가 앞에 자동으로 들어간다
}
