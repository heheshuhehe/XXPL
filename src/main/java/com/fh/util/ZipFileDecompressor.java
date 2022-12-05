package com.fh.util;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.util.Enumeration;

@Service
public class ZipFileDecompressor implements IDecompressFile {
    private Logger logger = LoggerFactory.getLogger(ZipFileDecompressor.class);
    private static final IDecompressFile gzDecompressor = new GzFileDecompressor();

    @Override
    public void decompressFile(File file, String rootPath) throws IOException {
        ZipFile zipFile = new ZipFile(file, "GB18030");

        try {
            Enumeration<ZipEntry> entries = zipFile.getEntries();

            if (null == entries || !entries.hasMoreElements()) {
                System.out.println(file + " 空Zip包!!!");
                return;
            }
            FileUtils.forceMkdir(new File(rootPath));

            //遍历
            while (entries.hasMoreElements()) {
                ZipEntry zipEntry = entries.nextElement();
                String innerFileName = zipEntry.getName();

                if (zipEntry.isDirectory()) {
                    logger.debug("{} 是目录！！！略过", innerFileName);
                    continue;
                }

                //复制文件内容
                InputStream inputStream = null;
                OutputStream outputStream = null;
                try {
                    inputStream = zipFile.getInputStream(zipEntry);

                    File innerFile = Paths.get(rootPath, innerFileName).toFile();
                    outputStream = FileUtils.openOutputStream(innerFile);

                    IOUtils.copy(inputStream, outputStream);

                    if ("gz".equals(FilenameUtils.getExtension(FilenameUtils.getName(innerFileName)).toLowerCase())) {
                        gzDecompressor.decompressFile(innerFile, Paths.get(rootPath, FilenameUtils.getBaseName(innerFileName)).toString());
                    }
                } finally {
                    IOUtils.closeQuietly(inputStream);
                    IOUtils.closeQuietly(outputStream);
                }
            }
        } finally {
            ZipFile.closeQuietly(zipFile);
        }
    }
}