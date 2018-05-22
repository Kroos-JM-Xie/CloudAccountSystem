package com.cloudaccount.entities;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;


/**
 * 账本实体类
 * @author XieJM
 *
 */
public class Amount implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int userID;
	private long amountID;
	private double amount;
	private String amountType;
	private String swName;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date writeTime; 
	public Amount() {
		// TODO Auto-generated constructor stub
		super();
	}
	public Amount(int userID,long amountID,double amount,String amountType,Date writeTime,String swName){
		super();
		this.userID=userID;
		this.amountID=amountID;
		this.amount=amount;
		this.amountType=amountType;
		this.writeTime=writeTime;
		this.swName=swName;
	}
	public Amount(String swName, Double amount) {
		// TODO Auto-generated constructor stub
		this.swName=swName;
		this.amount=amount;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getAmountType() {
		return amountType;
	}
	public void setAmountType(String amountType) {
		this.amountType = amountType;
	}
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")  
	public Date getWriteTime() {
		return writeTime;
	}
	public void setWriteTime(Date writeTime) {
		this.writeTime = writeTime;
	}
	public int getUserID() {
		return userID;
	}
	public long getAmountID() {
		return amountID;
	}
	public void setAmountID(long amountID) {
		this.amountID = amountID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getSwName() {
		return swName;
	}
	public void setSwName(String swName) {
		this.swName = swName;
	}
	@Override
	public String toString() {
		return "Amount [userID=" + userID + ", amountID=" + amountID + ", amount=" + amount + ", amountType="
				+ amountType + ", swName=" + swName + ", writeTime=" + writeTime + "]";
	}
	
	
}
