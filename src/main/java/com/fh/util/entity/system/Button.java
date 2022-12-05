package com.fh.util.entity.system;

import java.util.List;

import com.fh.entity.Page;
/**
 * 
* 类名称：Button.java
* 类描述： 
* @author YWB
 */
public class Button  implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;
	private Integer BTN_ID;
	private String BTN_NAME;
	private String BTN_CODE;
	private String STATUS;
	private Integer MENU_ID;
	private Menu menu ;
	private boolean hasButton=false;
	
 
	 
	public boolean isHasButton() {
		return hasButton;
	}
	public void setHasButton(boolean hasButton) {
		this.hasButton = hasButton;
	}
	public String getBTN_NAME() {
		return BTN_NAME;
	}
	public void setBTN_NAME(String bTN_NAME) {
		BTN_NAME = bTN_NAME;
	}
	public String getBTN_CODE() {
		return BTN_CODE;
	}
	public void setBTN_CODE(String bTN_CODE) {
		BTN_CODE = bTN_CODE;
	}
	public String getSTATUS() {
		return STATUS;
	}
	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}
	public Menu getMenu() {
		return menu;
	}
	public void setMenu(Menu menu) {
		this.menu = menu;
	}
	public Integer getBTN_ID() {
		return BTN_ID;
	}
	public void setBTN_ID(Integer bTN_ID) {
		BTN_ID = bTN_ID;
	}
	public Integer getMENU_ID() {
		return MENU_ID;
	}
	public void setMENU_ID(Integer mENU_ID) {
		MENU_ID = mENU_ID;
	}
	
	
	
}
