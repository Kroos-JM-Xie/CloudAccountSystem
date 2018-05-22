package com.cloudaccount.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cloudaccount.dao.SWTypeDao;
import com.cloudaccount.entities.SWType;
@Service
@Transactional
public class SWTypeServiceImpl implements ISWType {
	 @Autowired
	 SWTypeDao swDao;
	@Override
	public List<SWType> findSWType() {
		// TODO Auto-generated method stub
		return swDao.selectSWType();
	}

	@Override
	public List<SWType> findSWTypeByDesc(String desc) {
		// TODO Auto-generated method stub
		return swDao.selectSWTypeByDesc(desc);
	}

}
