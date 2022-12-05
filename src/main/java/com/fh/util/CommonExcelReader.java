package com.fh.util;

import java.util.Map;

public interface CommonExcelReader {

	Map<Integer, String> readExcelContent(int sheet,int rowfrom);
}
