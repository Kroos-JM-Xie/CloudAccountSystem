package com.cloudaccount.dao;

import java.util.List;

import com.cloudaccount.entities.SWType;

public interface SWTypeDao {
	public List<SWType> selectSWType(); 
	public List<SWType> selectSWTypeByDesc(String desc);
}
