package com.cloudaccount.services;

import java.util.Date;
import java.util.List;
import com.cloudaccount.entities.Amount;

public interface IAmountServices {
	public List<Amount> findAmountByType(String type,int userID);//根据类型查找
	public List<Amount> findAmountByDate(Date date);//根据日期查找
	public List<Amount> findAmountByDateAndType(Date date1,Date date2,String type);//根据日期和类型查找
	public double sumIncomeAmount(int userID); //收入统计
	public double sumOutAmount(int userID);//支出统计
	public int addAmount(Amount amount);//增加账本
	public int changeAmount(Amount amount);//修改账本
	public int cutAmount(Long amountID,int userID);//删除账本
	public List<Amount> findAmountByID(int userID);//按id查询账本
	public Amount findAmountByAmountID(Long amountID,int userID);
	public List<Amount> countAmountIn(int userID);
	public List<Amount> countAmountOut(int userID);
}
