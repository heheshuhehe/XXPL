package com.fh.util;

import org.apache.commons.io.FilenameUtils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by Administrator on 2018/3/13.
 */
public class CompressUtils {
    private static final int BUFFEREDSIZE = 1024;

    public static void zipFiles(Collection<File> srcFile, File zipFile) {
        byte[] buf = new byte[1024];

        try {
            ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFile));
            for (File file : srcFile) {
                FileInputStream in = new FileInputStream(file);
                out.putNextEntry(new ZipEntry(file.getName()));
                int len;
                while ((len = in.read(buf)) > 0) {
                    out.write(buf, 0, len);
                }
                out.closeEntry();
                in.close();
            }

            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static boolean isCompressedFileType(File srcFile) {
        String fileExtension = FilenameUtils.getExtension(srcFile.getName());

        return "rar".equals(fileExtension.toLowerCase()) || "zip".equals(fileExtension.toLowerCase());
    }

    public static File decompress(File srcFile) throws Exception {
        IDecompressFile iDecompressFile;
        String fileExtension = FilenameUtils.getExtension(srcFile.getName());
        if ("zip".equals(fileExtension.toLowerCase())) {
            iDecompressFile = new ZipFileDecompressor();
        } else if ("rar".equals(fileExtension.toLowerCase())) {
            iDecompressFile = new RarFileDecompressor();
        } else {
            throw new Exception("unsupported file type: " + fileExtension);
        }

        //解压到当前目录
        String targetPath = Paths.get(srcFile.getParent(), FilenameUtils.getBaseName(srcFile.getName())).toString();

        iDecompressFile.decompressFile(srcFile, targetPath);
        return new File(targetPath);
    }

    /**
     * 压缩zip格式的压缩文件
     *
     * @param inputFile   需压缩文件
     * @param zipFilename 输出文件及详细路径
     * @throws IOException
     */
    public static synchronized void zip(File inputFile, String zipFilename) throws IOException {
        try (ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFilename))) {
            zip(inputFile, out, "");
        }
    }

    public static synchronized void zip(File inputFile, File zipFile) throws IOException {
        try (ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFile))) {
            zip(inputFile, out, "");
        }
    }

    /**
     * 压缩zip格式的压缩文件
     *
     * @param inputFile 需压缩文件
     * @param out       输出压缩文件
     * @param base      结束标识
     * @throws IOException
     */
    @SuppressWarnings("unused")
    private static synchronized void zip(File inputFile, ZipOutputStream out, String base) throws IOException {
        if (inputFile.isDirectory()) {
            File[] inputFiles = inputFile.listFiles();
            out.putNextEntry(new ZipEntry(base + "/"));
            base = base.length() == 0 ? "" : base + "/";
            for (File file : inputFiles) {
                zip(file, out, base + file.getName());
            }
        } else {
            if (base.length() > 0) {
                out.putNextEntry(new ZipEntry(base));
            } else {
                out.putNextEntry(new ZipEntry(inputFile.getName()));
            }
            try (FileInputStream in = new FileInputStream(inputFile)) {
                int c;
                byte[] by = new byte[BUFFEREDSIZE];
                while ((c = in.read(by)) != -1) {
                    out.write(by, 0, c);
                }
            }
        }
    }
}
