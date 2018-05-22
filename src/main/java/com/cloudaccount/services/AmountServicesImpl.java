package com.cloudaccount.services;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cloudaccount.dao.AmountDao;
import com.cloudaccount.entities.Amount;

@Service
@Transactional
public class AmountServicesImpl implements IAmountServices {
	@Autowired
	private AmountDao amountDao;
	@Override
	public List<Amount> findAmountByType(String type,int userID) {
		// TODO Auto-generated method stub
		return amountDao.selectAmountByType(type,userID);
	}

	@Override
	public List<Amount> findAmountByDate(Date date) {
		// TODO Auto-generated method stub
		return amountDao.selectAmountByDate(date);
	}

	@Override
	public List<Amount> findAmountByDateAndType(Date date1, Date date2,String type) {
		// TODO Auto-generated method stub
		return amountDao.selectAmountByDateAndType(date1,date2, type);
	}

	@Override
	public double sumIncomeAmount(int userID) {
		// TODO Auto-generated method stub
		return amountDao.setlctSumInAmount(userID);
	}

	@Override
	public double sumOutAmount(int userID) {
		// TODO Auto-generated method stub
		return amountDao.selectSumOutAmount(userID);
	}

	@Override
	public int addAmount(Amount amount) {
		// TODO Auto-generated method stub
		if(amountDao.insertAmount(amount)>0){
			return 1;
		}else{
		return 0;
		}
	}

	@Override
	public int changeAmount(Amount amount) {
		// TODO Auto-generated method stub
		if(amountDao.updateAmount(amount)>0){
			return 1;
		}else{
			return 0;
		}
	}

	@Override
	public int cutAmount(Long amountID,int userID) {
		// TODO Auto-generated method stub
		if(amountDao.deleteAmount(amountID,userID)>0){
			return 1;
		}else{
			return 0;
		}
	}

	@Override
	public List<Amount> findAmountByID(int userID) {
		// TODO Auto-generated method stub
		return amountDao.selectAmountByID(userID);
	}

	@Override
	public Amount findAmountByAmountID(Long amountID,int userID) {
		// TODO Auto-generated method stub
		return amountDao.selectAmountByAmountID(amountID,userID);
	}

	@Override
	public List<Amount> countAmountIn(int userID) {
		// TODO Auto-generated method stub
		return amountDao.selectAmountToCountIn(userID);
	}

	@Override
	public List<Amount> countAmountOut(int userID) {
		// TODO Auto-generated method stub
		return amountDao.selectAmountToCountOut(userID);
	}

}
