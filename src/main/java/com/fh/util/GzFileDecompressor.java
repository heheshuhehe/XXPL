package com.fh.util;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.zip.GZIPInputStream;

/**
 * Created by Administrator on 2018/3/23.
 */
public class GzFileDecompressor implements IDecompressFile {
    @Override
    public void decompressFile(File file, String targetFile) throws IOException {
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try {
            inputStream = FileUtils.openInputStream(file);
            outputStream = FileUtils.openOutputStream(new File(targetFile));

            GZIPInputStream gzipInputStream = new GZIPInputStream(inputStream);
            IOUtils.copy(gzipInputStream, outputStream);
        } finally {
            IOUtils.closeQuietly(inputStream);
            IOUtils.closeQuietly(outputStream);
        }
    }
}
