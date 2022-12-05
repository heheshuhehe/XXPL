package com.fh.util.reportService.com.swhy.report;

import java.util.Date;
import java.util.regex.Matcher;

import org.jxls.area.Area;
import org.jxls.command.AbstractCommand;
import org.jxls.command.Command;
import org.jxls.common.CellData;
import org.jxls.common.CellData.CellType;
import org.jxls.common.CellRef;
import org.jxls.common.Context;
import org.jxls.common.JxlsException;
import org.jxls.common.Size;
import org.jxls.expression.ExpressionEvaluator;
import org.jxls.transform.TransformationConfig;
import org.jxls.transform.Transformer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * Allows to set a cell data dynamically for any cell
 */
public class SetCellCommand extends AbstractCommand {
	public static final String COMMAND_NAME = "setCell";
    private static Logger logger = LoggerFactory.getLogger(SetCellCommand.class);
    
    private Area area;
    private String value;
    
	@Override
	public String getName() {
		return COMMAND_NAME;
	}

    public String getValue() {
        return value;
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    
	@Override
	public Size applyAt(CellRef cellRef, Context context) {   
		Object dataValidationValue = null;
		try {
			dataValidationValue = transformToObject(getTransformationConfig().getExpressionEvaluator(), value, context);
			CellRef srcCell = area.getStartCellRef();
	        CellData cellData = area.getTransformer().getCellData(srcCell);
	        
	        if (dataValidationValue instanceof Integer || 
	        	dataValidationValue instanceof Float ||
	        	dataValidationValue instanceof Double ||
	        	dataValidationValue instanceof Number)
	        	cellData.setCellType(CellType.NUMBER);
	        else if (dataValidationValue instanceof Date)
	        	cellData.setCellType(CellType.DATE);
	        else if (dataValidationValue instanceof Boolean)
	        	cellData.setCellType(CellType.BOOLEAN);
	        else
	        	cellData.setCellType(CellType.STRING);
	        
	        cellData.setEvaluationResult(dataValidationValue);
	        //cellData.setDefaultValue((String) dataValidationValue);
	        CellType type = cellData.getCellType();
	        Object cellValue = cellData.getCellValue();
	        
	        logger.info("cell type is {}", type.name());
	        logger.info("cell value is {}", cellValue);
	        logger.info("data validation value si {}", dataValidationValue);
        } catch (Exception e) {
            logger.warn("Failed to evaluate value expression {}", value, e);
        }
        return area.applyAt(cellRef, context);
	}
	
    @Override
    public Command addArea(Area area) {
    	String message = "You can only add a single cell area to '" + COMMAND_NAME + "' command!";
        if (getAreaList().size() >= 1) {
            throw new IllegalArgumentException(message);
        }
        if (area != null && area.getSize().getHeight() != 1 && area.getSize().getWidth() != 1) {
            throw new IllegalArgumentException(message);
        }
        
        this.area = area;
        return super.addArea(area);
    }
    
    /**
     * Evaluates the passed data validation cell name into an value object
     * @param expressionEvaluator -
     * @param data validation name -
     * @param context -
     * @return an cell value object from the {@link Context} under given name
     */
    Object transformToObject(ExpressionEvaluator expressionEvaluator, String name, Context context)
    {
    	Object value = expressionEvaluator.evaluate(name, context.toMap());
        if (value == null) {
            throw new JxlsException(name + " expression is not a cell value");
        }
        return value;
    }
    
    void updateCellData(CellData cellData, CellRef targetCell, Context context)
    {
    	Object evaluationResult = null;
    	StringBuffer sb = new StringBuffer();
    	Transformer transformer = cellData.getTransformer();
        TransformationConfig transformationConfig = transformer.getTransformationConfig();
        int beginExpressionLength = transformationConfig.getExpressionNotationBegin().length();
        int endExpressionLength = transformationConfig.getExpressionNotationEnd().length();
        Matcher exprMatcher = transformationConfig.getExpressionNotationPattern().matcher(value);
        ExpressionEvaluator evaluator = transformer.getTransformationConfig().getExpressionEvaluator();
        String matchedString;
        String expression;
        Object lastMatchEvalResult = null;
        int matchCount = 0;
        int endOffset = 0;
        while (exprMatcher.find()) {
            endOffset = exprMatcher.end();
            matchCount++;
            matchedString = exprMatcher.group();
            expression = matchedString.substring(beginExpressionLength, matchedString.length() - endExpressionLength);
            lastMatchEvalResult = evaluator.evaluate(expression, context.toMap());
            exprMatcher.appendReplacement(sb,
                    Matcher.quoteReplacement(lastMatchEvalResult != null ? lastMatchEvalResult.toString() : ""));
        }
        String lastStringResult = lastMatchEvalResult != null ? lastMatchEvalResult.toString() : "";
        boolean isAppendTail = matchCount == 1 && endOffset < value.length();
        if (matchCount > 1 || isAppendTail) {
            exprMatcher.appendTail(sb);
            evaluationResult = sb.toString();
        } else if (matchCount == 1) {
            if (sb.length() > lastStringResult.length()) {
                evaluationResult = sb.toString();
            } else {
                evaluationResult = lastMatchEvalResult;
            }
        } else if (matchCount == 0) {
            evaluationResult = value;
        }
        cellData.setEvaluationResult(evaluationResult);
        
    }

}
