package com.cloudaccount.entities;

import java.io.Serializable;
/**
 * 来源去向描述实体类
 * @author XieJM
 *
 */
public class SWType implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int swID;
	private String swName;//收入支出来源去向项目名字
	private String swDesc;//描述
	public SWType() {
		// TODO Auto-generated constructor stub
		super();
	}
	public SWType(int swID,String swName,String swDesc){
		super();
		this.swID=swID;
		this.swName=swName;
		this.swDesc=swDesc;
	}
	public int getSwID() {
		return swID;
	}
	public void setSwID(int swID) {
		this.swID = swID;
	}
	public String getSwName() {
		return swName;
	}
	public void setSwName(String swName) {
		this.swName = swName;
	}
	public String getSwDesc() {
		return swDesc;
	}
	public void setSwDesc(String swDesc) {
		this.swDesc = swDesc;
	}
	@Override
	public String toString() {
		return "SWType [swID=" + swID + ", swName=" + swName + ", swDesc=" + swDesc + "]";
	}
	
}
