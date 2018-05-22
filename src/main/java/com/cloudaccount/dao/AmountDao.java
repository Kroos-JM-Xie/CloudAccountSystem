package com.cloudaccount.dao;



import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.cloudaccount.entities.Amount;

public interface AmountDao {
	
	public int insertAmount(Amount amount);
	public int updateAmount(Amount amount);
	public int deleteAmount(@Param("amountID")Long amountID,@Param("userID")int userID);
	public Amount selectAmountByAmountID(@Param("amountID")Long amountID,@Param("userID")int userID);
	public List<Amount> selectAmountByID(int userID);
	public List<Amount> selectAmountByDate(Date date);
	public List<Amount> selectAmountByType(@Param("amountType")String amountType,@Param("userID")int userID);
	public List<Amount> selectAmountByDateAndType(Date startdate,Date endDate,String type);
	//public double selectSumAmount();
	public List<Amount> selectAmountToCountIn(int userID);
	public List<Amount> selectAmountToCountOut(int userID);
	public double selectSumOutAmount(int userID);//支出统计
	public double setlctSumInAmount(int userID);//收入统计
}
