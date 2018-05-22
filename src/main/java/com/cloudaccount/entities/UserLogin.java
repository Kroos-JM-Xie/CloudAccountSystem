package com.cloudaccount.entities;

import java.io.Serializable;
/**
 * 用户登陆实体类
 * @author XieJM
 *
 */
public class UserLogin implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int userID;
	private String userName;
	private String password;
	public UserLogin() {
		// TODO Auto-generated constructor stub
		super();
	}
	public UserLogin(int userID,String userName,String password){
		super();
		this.userID=userID;
		this.userName=userName;
		this.password=password;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getUserID(){
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	@Override
	public String toString() {
		return "UserLogin [userID=" + userID + ", userName=" + userName + ", password=" + password + "]";
	}
	
	
}
