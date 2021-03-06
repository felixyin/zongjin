<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售订单查看</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

	</script>
</head>
<body>
	<ul class="nav nav-tabs my-nav-tabs">
		<li class="active"><a>销售订单查看</a></li>
	</ul><br/>
	<div class="my-container">
        <form:form id="inputForm" modelAttribute="erpSalesOrder" action="${ctx}/erp/erpSalesOrder/save" method="post" class="form-horizontal">
            <form:hidden path="id"/>
            <input type="hidden" name="savePiFile" value="1">
            <sys:message content="${message}"/>
            <div class="control-group">
                <label class="control-label">流程实例ID：</label>
                <div class="controls">
                        ${erpSalesOrder.act.procInsId}
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">客户：</label>
                <div class="controls">
                    ${erpSalesOrder.erpCustomer.aname}
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">人员名称：</label>
                <div class="controls">
                    ${erpSalesOrder.user.name}
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">贸易形式：</label>
                <div class="controls">
                    <form:select path="enmuTradingType" class="input-xlarge "  readonly="true" disabled="true">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('enmu_trading_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">PI：</label>
                <div class="controls">
                    ${erpSalesOrder.piNo}
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">PI 附件：</label>
                <div class="controls">
                    <form:hidden id="piFile" path="piFile" htmlEscape="false" maxlength="255" class="input-xlarge"/>
                    <sys:ckfinder input="piFile" type="files" uploadPath="/PiFile" selectMultiple="true"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">下单日期：</label>
                <div class="controls">
                    <fmt:formatDate value="${erpSalesOrder.orderTime}" pattern="yyyy-MM-dd" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">简要生产计划：</label>
                <div class="controls">
                    <form:hidden id="productionPlain" path="productionPlain" htmlEscape="false" maxlength="255" class="input-xlarge"/>
                    <sys:ckfinder input="productionPlain" type="files" uploadPath="/JianYaoProductionPlain" selectMultiple="true"/>
                        <%--<form:textarea path="productionPlain" htmlEscape="false" rows="4" maxlength="255"--%>
                        <%--class="input-xxlarge required hide"/>--%>
                        <%--<sys:ckeditor replace="productionPlain" uploadPath="/test" height="200"/>--%>
                    <span class="help-inline"><font color="red">*</font> </span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">备注信息：</label>
                <div class="controls">
                    <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255"
                                   class="input-xxlarge hide" readonly="true" disabled="true"/>
                    <sys:ckeditor replace="remarks" uploadPath="/test" height="200"/>
                </div>
            </div>
            <div class="form-actions my-form-actions">
                <shiro:hasPermission name="erp:erpSalesOrder:save">
                    <input id="btnSubmit" class="btn btn-default" type="submit" value="保存附件"/>
                    &nbsp;
                </shiro:hasPermission>
                <input id="btnCancel" class="btn hide" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>
        </form:form>
    </div>
</body>
</html>