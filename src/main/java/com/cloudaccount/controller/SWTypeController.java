package com.cloudaccount.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cloudaccount.entities.Msg;
import com.cloudaccount.entities.SWType;
import com.cloudaccount.services.ISWType;

import net.sf.json.JSONObject;
/**
 * 类型控制器
 * @author XieJM
 *
 */
@Controller
@RequestMapping(value = "/swtype")
public class SWTypeController {
	@Autowired
	private ISWType iswType;
	
	@RequestMapping("/swtypes.action")
	@ResponseBody
	public Msg getISWTypes(){
		List<SWType> list=iswType.findSWType();
		return Msg.success().add("swtypes", list);
	}
	@RequestMapping(value="/swtypesbydesc.action",produces="application/json; charset=utf-8")
	@ResponseBody
	public String getISWTypesByDesc(String desc){
		List<SWType> list=iswType.findSWTypeByDesc(desc);
		JSONObject obj=new JSONObject();
		obj.put("list", list);
		String listString=obj.toString();
		System.out.println(listString);
		return listString;
	}
}
