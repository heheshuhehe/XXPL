package com.fh.util.entity.system;

import java.util.List;

public class Operator {
	private static final long serialVersionUID = 1L;
	
	private Integer OPER_ID;
	private String OPER_NAME;
	private String STATUS;
	private String BZ;
	private List<RightsGroup> rightsGroupList;
	private List<ProductGroup> productGroupList;
	
	public Integer getOPER_ID() {
		return OPER_ID;
	}
	public void setOPER_ID(Integer oPER_ID) {
		OPER_ID = oPER_ID;
	}
	public String getOPER_NAME() {
		return OPER_NAME;
	}
	public void setOPER_NAME(String oPER_NAME) {
		OPER_NAME = oPER_NAME;
	}
	public String getSTATUS() {
		return STATUS;
	}
	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}
	public String getBZ() {
		return BZ;
	}
	public void setBZ(String bZ) {
		BZ = bZ;
	}
	public List<RightsGroup> getRightsGroupList() {
		return rightsGroupList;
	}
	public void setRightsGroupList(List<RightsGroup> rightsGroupList) {
		this.rightsGroupList = rightsGroupList;
	}
	public List<ProductGroup> getProductGroupList() {
		return productGroupList;
	}
	public void setProductGroupList(List<ProductGroup> productGroupList) {
		this.productGroupList = productGroupList;
	}
	 
	 
	
	
}
