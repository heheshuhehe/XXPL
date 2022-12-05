package com.fh.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.File;

/**
 * Created by Administrator on 2018/3/23.
 */
@Service
public class RarFileDecompressor implements IDecompressFile {
    private Logger logger = LoggerFactory.getLogger(RarFileDecompressor.class);

    @Override
    public void decompressFile(File file, String rootPath) {
        String rarPath = "c:\\Program Files\\2345Soft\\HaoZip\\HaoZipC.exe";
        String param = "x";

        String cmdStr = String.format("%s %s %s -o%s", rarPath, param, file.getAbsolutePath(), rootPath);


        if (CmdExecutor.exe(cmdStr)) {
            logger.debug("解压文件完成!!!");
        }
    }
}
