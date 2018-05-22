package com.cloudaccount.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cloudaccount.dao.UserLoginDao;
import com.cloudaccount.entities.UserLogin;

@Service
@Transactional
public class UserServiceImpl implements IUserServices {
	 @Autowired
	private UserLoginDao userdao;

	@Override
	public UserLogin check(String userName, String password) {
		// TODO Auto-generated method stub
		return userdao.selectUser(userName, password);
	}

	@Override
	public void register(UserLogin user) {
		// TODO Auto-generated method stub
		userdao.insertUser(user);
	}

	@Override
	public UserLogin findUserByName(String userName) {
		// TODO Auto-generated method stub
		return userdao.selectUserByUserName(userName);
	}

	@Override
	public void change(UserLogin user) {
		// TODO Auto-generated method stub
		userdao.updatePassword(user);
	}

}
