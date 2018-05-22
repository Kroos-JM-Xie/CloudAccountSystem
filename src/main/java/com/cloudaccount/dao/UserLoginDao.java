package com.cloudaccount.dao;

import org.apache.ibatis.annotations.Param;
import com.cloudaccount.entities.UserLogin;;

public interface UserLoginDao {
	public UserLogin selectUser(@Param("userName")String userName,@Param("password")String password);
	public UserLogin selectUserByUserName(String userName);
	public void updatePassword(UserLogin user);
	public void insertUser(UserLogin user);
	//public UserLogin selectPasswordByUserName(String userName);
}
