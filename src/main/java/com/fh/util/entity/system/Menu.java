package com.fh.util.entity.system;

import java.util.List;

import com.fh.entity.Page;
/**
 * 
* 类名称：Menu.java
* 类描述： 
* @author YWB
 */
public class Menu  implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;
	private Integer MENU_ID;
	private String MENU_NAME;
	private String MENU_URL;
	private Integer PARENT_ID;
	private Integer MENU_ORDER;
	private String MENU_ICON;
	private String STAUTS;
	private String target;
	
	private List<Button> buttonList;
	private Page page;			//分页对象
	
	private Menu parentMenu;
	private List<Menu> subMenu;
	
	private boolean hasMenu = false;
	 
	public String getMENU_NAME() {
		return MENU_NAME;
	}
	public void setMENU_NAME(String mENU_NAME) {
		MENU_NAME = mENU_NAME;
	}
	public String getMENU_URL() {
		return MENU_URL;
	}
	public void setMENU_URL(String mENU_URL) {
		MENU_URL = mENU_URL;
	}
	 
	 
	public Integer getMENU_ID() {
		return MENU_ID;
	}
	public void setMENU_ID(Integer mENU_ID) {
		MENU_ID = mENU_ID;
	}
	public Integer getPARENT_ID() {
		return PARENT_ID;
	}
	public void setPARENT_ID(Integer pARENT_ID) {
		PARENT_ID = pARENT_ID;
	}
	public Integer getMENU_ORDER() {
		return MENU_ORDER;
	}
	public void setMENU_ORDER(Integer mENU_ORDER) {
		MENU_ORDER = mENU_ORDER;
	}
	public Menu getParentMenu() {
		return parentMenu;
	}
	public void setParentMenu(Menu parentMenu) {
		this.parentMenu = parentMenu;
	}
	public List<Menu> getSubMenu() {
		return subMenu;
	}
	public void setSubMenu(List<Menu> subMenu) {
		this.subMenu = subMenu;
	}
	public boolean isHasMenu() {
		return hasMenu;
	}
	public void setHasMenu(boolean hasMenu) {
		this.hasMenu = hasMenu;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getMENU_ICON() {
		return MENU_ICON;
	}
	public void setMENU_ICON(String mENU_ICON) {
		MENU_ICON = mENU_ICON;
	}
	public String getSTAUTS() {
		return STAUTS;
	}
	public void setSTAUTS(String sTAUTS) {
		STAUTS = sTAUTS;
	}
	public List<Button> getButtonList() {
		return buttonList;
	}
	public void setButtonList(List<Button> buttonList) {
		this.buttonList = buttonList;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
}
