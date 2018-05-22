package com.cloudaccount.services;

import com.cloudaccount.entities.UserLogin;

public interface IUserServices {
	public UserLogin check(String userName,String password);
	public void register(UserLogin user);
	public UserLogin findUserByName(String userName);
	public void change(UserLogin user);
}
