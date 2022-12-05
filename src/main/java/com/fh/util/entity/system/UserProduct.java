package com.fh.util.entity.system;

import java.io.Serializable;

public class UserProduct implements Serializable{
	private String userId;
	private String cpdm;
	private String cpmc;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCpdm() {
		return cpdm;
	}
	
	public void setCpdm(String cpdm) {
		this.cpdm = cpdm;
	}
	public String getCpmc() {
		return cpmc;
	}
	public void setCpmc(String cpmc) {
		this.cpmc = cpmc;
	}
	
}
