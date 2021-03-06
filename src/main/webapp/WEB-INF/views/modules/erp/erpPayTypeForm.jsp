<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>支付类型管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<c:if test="${isForm}">
			<li><a href="${ctx}/erp/erpPayType/">支付类型列表</a></li>
		</c:if>
		<li class="active"><a href="${ctx}/erp/erpPayType/form?id=${erpPayType.id}">支付类型<shiro:hasPermission name="erp:erpPayType:edit">${not empty erpPayType.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:erpPayType:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="erpPayType" action="${ctx}${action}" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group hide">
			<label class="control-label">销售订单：</label>
			<div class="controls">
				<form:input path="erpSalesOrder.id" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">付款方式：</label>
			<div class="controls">
				<form:select path="enmuPaymentType" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('enmu_payment_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">付款方式比例：</label>
			<div class="controls">
				<form:input path="scale" htmlEscape="false" type="number" step="1" class="input-xlarge scale required"/>%
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">应付总金额：</label>
			<div class="controls">
				<form:input path="sumPrice" htmlEscape="false" class="input-xlarge required number"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">${fns:getDictLabel(erpPayType.enmuPaymentType, 'enmu_payment_type', '')}支付金额：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>应收款</th>
								<th>实收款</th>
								<th>付款时间</th>
								<th>付款比例</th>
								<th>支付截图</th>
								<%--<th>备注信息</th>--%>
								<shiro:hasPermission name="erp:erpPayType:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="erpPayMoneyList">
						</tbody>
						<shiro:hasPermission name="erp:erpPayType:edit"><tfoot>
							<tr><td colspan="7"><a href="javascript:" onclick="addRow('#erpPayMoneyList', erpPayMoneyRowIdx, erpPayMoneyTpl);erpPayMoneyRowIdx = erpPayMoneyRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="erpPayMoneyTpl">//<!--
						<tr id="erpPayMoneyList{{idx}}">
							<td class="hide">
								<input id="erpPayMoneyList{{idx}}_id" name="erpPayMoneyList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="erpPayMoneyList{{idx}}_delFlag" name="erpPayMoneyList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="erpPayMoneyList{{idx}}_payableMoney" name="erpPayMoneyList[{{idx}}].payableMoney" type="text" value="{{row.payableMoney}}" class="input-small required number"/>
							</td>
							<td>
								<input id="erpPayMoneyList{{idx}}_comeMoney" name="erpPayMoneyList[{{idx}}].comeMoney" type="text" value="{{row.comeMoney}}" class="input-small required number"/>
							</td>
							<td>
								<input id="erpPayMoneyList{{idx}}_time" name="erpPayMoneyList[{{idx}}].time" type="text" readonly="readonly" maxlength="20" class="input-medium required Wdate "
									value="{{row.time}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
							</td>
							<td>
								<input id="erpPayMoneyList{{idx}}_scale" name="erpPayMoneyList[{{idx}}].scale" type="number" step="1" value="{{row.scale}}" class="input-small required scale"/>%
							</td>
							<td>
								<input id="erpPayMoneyList{{idx}}_file" name="erpPayMoneyList[{{idx}}].file" type="hidden" value="{{row.file}}" maxlength="255"/>
								<sys:ckfinder input="erpPayMoneyList{{idx}}_file" type="files"  uploadPath="/payMoneyFile" selectMultiple="true"/>
							</td>
							<%--<td>
								<textarea id="erpPayMoneyList{{idx}}_remarks" name="erpPayMoneyList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>--%>
							<shiro:hasPermission name="erp:erpPayType:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#erpPayMoneyList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var erpPayMoneyRowIdx = 0, erpPayMoneyTpl = $("#erpPayMoneyTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(erpPayType.erpPayMoneyList)};
							for (var i=0; i<data.length; i++){
								addRow('#erpPayMoneyList', erpPayMoneyRowIdx, erpPayMoneyTpl, data[i]);
								erpPayMoneyRowIdx = erpPayMoneyRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="erp:erpPayType:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn hide" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>