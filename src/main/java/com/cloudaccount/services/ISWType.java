package com.cloudaccount.services;

import java.util.List;

import com.cloudaccount.entities.SWType;

public interface ISWType {
	public List<SWType> findSWType();
	public List<SWType> findSWTypeByDesc(String desc);
}
