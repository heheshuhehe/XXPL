package com.fh.util;

import java.io.File;
import java.io.IOException;

/**
 * Created by Administrator on 2018/3/23.
 */
public interface IDecompressFile {
    void decompressFile(File file, String rootPath) throws IOException;
}
