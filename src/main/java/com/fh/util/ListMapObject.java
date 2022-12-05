package com.fh.util;

import java.util.Comparator;
import java.util.List;
import java.util.Map;

public class ListMapObject implements Comparator<Map<String,Object>> {





	@Override
	public int compare(Map<String, Object> arg0, Map<String, Object> arg1) {
		double o1=Double.parseDouble( arg0.get("fudu").toString().replace("%", ""));
		double o2=Double.parseDouble( arg0.get("fudu").toString().replace("%", ""));
		if(o1>o2)
			return 1;
		if(o1<o2)
			return -1;
		return 0;
	}
}