package com.fh.util.entity.system;

import java.util.List;

import com.fh.util.PageData;

public class ProductGroup {
	private static final long serialVersionUID = 1L;
    private  Integer PG_ID;
    private  String PG_NAME;
    private String BZ;
    private List<PageData> productList;
    private String STATUS;
	public Integer getPG_ID() {
		return PG_ID;
	}
	public void setPG_ID(Integer pG_ID) {
		PG_ID = pG_ID;
	}
	public String getPG_NAME() {
		return PG_NAME;
	}
	public void setPG_NAME(String pG_NAME) {
		PG_NAME = pG_NAME;
	}
	public String getBZ() {
		return BZ;
	}
	public void setBZ(String bZ) {
		BZ = bZ;
	}
	 
	
	public List<PageData> getProductList() {
		return productList;
	}
	public void setProductList(List<PageData> productList) {
		this.productList = productList;
	}
	public String getSTATUS() {
		return STATUS;
	}
	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}
	 
    
    
}
