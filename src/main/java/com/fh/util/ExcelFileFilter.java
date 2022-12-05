package com.fh.util;

import java.io.File;
import java.io.FileFilter;

public class ExcelFileFilter implements FileFilter{

	@Override
	public boolean accept(File file) {
		if(file.isFile())
			if(file.getName().toLowerCase().endsWith(".xls")||file.getName().toLowerCase().endsWith(".xlsx"))
				return true;

		return false;
	}

}
