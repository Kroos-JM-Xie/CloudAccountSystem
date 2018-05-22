package com.cloudaccount.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import com.cloudaccount.dao.AmountDao;
import com.cloudaccount.entities.Amount;


import junit.framework.Assert;

@SuppressWarnings("deprecation")
public class TestAmount {

	@Test
	public void insertAmountTest(){
		SqlSession session=MyBatisUtil.getSession();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String s="2016-12-20";
		Date date=new Date();
		try {
			date = sdf.parse(s);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			Amount entity=new Amount();
			entity.setAmount(123);
			entity.setAmountType("支出");
			
			entity.setWriteTime(date);
			//entity.setSourceWhereabouts("旅游");
			AmountDao bookdao=session.getMapper(AmountDao.class);
			Assert.assertEquals(1, bookdao.insertAmount(entity));
			System.out.println("fff");
		} finally {
			session.close();
		}
	}

}
