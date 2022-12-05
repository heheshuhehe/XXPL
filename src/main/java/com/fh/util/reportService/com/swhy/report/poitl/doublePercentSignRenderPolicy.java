package com.fh.util.reportService.com.swhy.report.poitl;

import java.text.DecimalFormat;

import org.apache.poi.xwpf.usermodel.XWPFRun;

import com.deepoove.poi.XWPFTemplate;
import com.deepoove.poi.policy.RenderPolicy;
import com.deepoove.poi.template.ElementTemplate;
import com.deepoove.poi.template.run.RunTemplate;

/**
 * @author chenlin
 * poi-tl 的一个自定义插件 
 * 将double类型的数据转换为分数 
 * 模板中的标签配置 {{%test}} 
 */
public class doublePercentSignRenderPolicy implements RenderPolicy{

	/**
	 *  @param  eleTemplate当前标签的位置 
	 *  @param  data 数据模型 
	 *  @param  template 代表这个模板
	 */
	@Override  
	public void render(ElementTemplate eleTemplate, Object data, XWPFTemplate template) {
		// System.out.println("data:"+data.toString()); 
		XWPFRun run = ((RunTemplate)eleTemplate).getRun(); 
		try{ 
            if (data == null) {
                run.setText("", 0);
            } else {
                double _data = Double.valueOf(data.toString());
                DecimalFormat df = new DecimalFormat("#,##0.00%");
                String _dataStr = df.format(_data);
                run.setText(_dataStr, 0);
            } 
		}catch (Exception e) { 
			run.setText(data.toString(),0); 
		}
	}
}
