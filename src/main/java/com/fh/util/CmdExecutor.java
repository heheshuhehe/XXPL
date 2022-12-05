package com.fh.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Created by Administrator on 2018/2/7.
 */
public class CmdExecutor {
    private static Logger logger = LoggerFactory.getLogger(CmdExecutor.class);

    private CmdExecutor() {
        throw new AssertionError();
    }

    public static boolean exe(String cmd) {
        Runtime runtime = Runtime.getRuntime();
        try {
            Process p = runtime.exec(cmd);
            BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream(), "GBK"));

            String line = reader.readLine();
            while (line != null) {
                logger.debug(line);
                line = reader.readLine();
            }
            reader.close();
            if (p.waitFor() != 0) {
                return false;
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return true;
    }
}
