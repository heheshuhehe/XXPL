package com.fh.util.entity.system;

import java.io.Serializable;
import java.util.List;

public class RightsGroup  implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer ROLE_ID;
	private String ROLE_NAME;
	private String RIGHTS;
	private String BZ;
    List<Menu> menuList ;
	List<Button> buttonList ;
	//private Operator operator;
	 
	public String getROLE_NAME() {
		return ROLE_NAME;
	}
	public Integer getROLE_ID() {
		return ROLE_ID;
	}
	public void setROLE_ID(Integer rOLE_ID) {
		ROLE_ID = rOLE_ID;
	}
	public void setROLE_NAME(String rOLE_NAME) {
		ROLE_NAME = rOLE_NAME;
	}
	public String getRIGHTS() {
		return RIGHTS;
	}
	public void setRIGHTS(String rIGHTS) {
		RIGHTS = rIGHTS;
	}
	 
	public String getBZ() {
		return BZ;
	}
	public void setBZ(String bZ) {
		BZ = bZ;
	}
	public List<Button> getButtonList() {
		return buttonList;
	}
	public void setButtonList(List<Button> buttonList) {
		this.buttonList = buttonList;
	}
	 
	public List<Menu> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<Menu> menuList) {
		this.menuList = menuList;
	}
	
	
}
