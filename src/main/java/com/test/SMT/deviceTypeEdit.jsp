<!-- 标签引入及字符集设置 begin-->
<%@ taglib prefix="ww" uri="webwork"%>
<%@ taglib prefix="ec" uri="extremecomponents"%>
<%@ taglib prefix="jdf" uri="jdf"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%String path = request.getContextPath();
Object fromCustomFlag = request.getSession().getAttribute("fromCustomFlag");
Object cust_custId = request.getSession().getAttribute("cust_custId");
if(cust_custId==null){
	cust_custId = "";
}
if(fromCustomFlag==null){
	fromCustomFlag = "";
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><ww:property value="getText('common.page.title')" />
	</title>
<jdf:commonHead/>
<!--	AJAX	-->
<script src="<%=path%>/scripts/jQuery/jquery-1.8.1.js" type="text/javascript"></script>

<script type="text/javascript" src="../../../../scripts/jquery.js"></script>
<script type="text/javascript" src="../../../../scripts/jquery.blockUI.js"></script>
<script type='text/javascript' src='../../../../scripts/jquery.autocomplete.js'></script>
	
<!--	AJAX	-->
<script>
//操作标题和按钮生成区域
//标题
title = "设备类型管理";
//定义相对路径
var abstractUrl = "<%=path%>/pages/business/resource/devicetype/"; //相对于main.html的通用路径
//按钮
var operation = ""
var custId = "<%=cust_custId%>";
var fromCustomFlag = "<%=fromCustomFlag%>";
<jdf:hasPermission res="deviceType.manageKind.save">
	operation = operation + "<button class=\"smallButton\" onClick=\"save();\">保存</button>&nbsp;";
</jdf:hasPermission>
operation = operation + "<button class=\"smallButton\" onClick=\"backOnClick()\">返回</button>&nbsp;";
 </script>

<script type="text/javascript">

var myJ = jQuery.noConflict();

//页面跳转
//保存设备类型信息
function save(){

	var lannum=document.getElementById("devLanNum").value;
	var postnum=document.getElementById("devPostNum").value;
	var wlan=document.getElementById("WLANNumber").value;
	var usb=document.getElementById("USBNum").value;
	var sd=document.getElementById("SDNum").value;
	if(lannum==""||postnum==""||usb==""||sd==""){
		alert("请先填写接口数量！");
		return false;
	}
	if(wlan==""){
		alert("请先填写WLAN配置！");
		return false;
	}
	submitForm(document.forms.editDeviceType);
}

function backOnClick1(){
	document.location.href = abstractUrl+'listDeviceType.action?queryFlag=false';
}
//返回
function backOnClick(){
    //该标实用来判断：是从设备管理模块过来 还是来自于设备类型模块
	//returnFlag == false 来自于 设备类型模块
	//returnFlag == ture  来自于 设备管理模块
    var returnFlag = myJ('#returnFlag').val();
    if(returnFlag && returnFlag == "true"){
    	document.location.href ="<%=path%>/pages/business/resource/equipment/listAllEquipment!back.action?queryFlag=" + true;
    }else{
    	if(fromCustomFlag=='1'){
    		document.location.href = "<%=path%>/pages/business/resource/customer/intoCustomerInfo.action?functionType=2&customerInfo.custId=" + custId;	
    	}else{
    
	    	//window.history.back(-1);
			//更改返回速度很慢.返回时不需要查询
			//2007-06-15 蒋加武 edit
			document.location.href = abstractUrl + "listDeviceType!back.action";
		}
    }

}

 var endPoint = "<%=path%>/remoting";
//修改版本状态
function changeTypeVersionState(typeAndVerId,state){
    //该标实用来判断：是从设备管理模块过来 还是来自于设备类型模块
	//returnFlag == false 来自于 设备类型模块
	//returnFlag == ture  来自于 设备管理模块
	
	var lannum=document.getElementById("devLanNum").value;
	var postnum=document.getElementById("devPostNum").value;
	var wlan=document.getElementById("WLANNumber").value;
	var usb=document.getElementById("USBNum").value;
	var sd=document.getElementById("SDNum").value;
	if(lannum==""||postnum==""||usb==""||sd==""){
		alert("请先填写接口数量！");
		return false;
	}
	if(wlan==""){
		alert("请先填写WLAN配置！");
		return false;
	}
	
	var returnFlag = myJ('#returnFlag').val();
 	var con;
	if(state == "1"){
		con = confirm("是否撤消审核?");
		if(con){
			document.forms.editDeviceType.action = abstractUrl + "devicetypever/intoDeviceTypeVerInfo.action?functionType=10&deviceTypeVerInfo.typeAndVerId="+typeAndVerId+"&returnFlag="+returnFlag;
			document.forms.editDeviceType.submit();
			return false;
		}
	}else{
		var oui = document.getElementById("devVendorOUI").value;
		if(oui == null || oui.length < 1){
			alert("OUI不合法，OUI不能为空");
			return false;
		}
		/*var buffalo1 = new Buffalo(endPoint);
		buffalo1.remoteCall("EquipmentManagerAjax.findDevVendorOUIByVendorCount",[oui],function(reply){
			if(reply.getResult() == "0"){
				alert("该OUI不合法,请在OUI管理中添加后，再审核!");
				return false;
			}
			alert("审核之前,请先确认是否选中网络侧接口等信息!");
			con = confirm("审核?");
			if(con){
			document.forms.editDeviceType.action = abstractUrl + "devicetypever/intoDeviceTypeVerInfo.action?functionType=7&deviceTypeVerInfo.typeAndVerId="+typeAndVerId+"&returnFlag="+returnFlag;
			document.forms.editDeviceType.submit();
			}
		});*/
		document.forms.editDeviceType.action = abstractUrl + "devicetypever/intoDeviceTypeVerInfo.action?functionType=7&deviceTypeVerInfo.typeAndVerId="+typeAndVerId+"&returnFlag="+returnFlag;
		document.forms.editDeviceType.submit();
		return false;
	}
}		

//增加设备类型软件版本
function addDeivceTypeVer(){
    //该标实用来判断：是从设备管理模块过来 还是来自于设备类型模块
	//returnFlag == false 来自于 设备类型模块
	//returnFlag == ture  来自于 设备管理模块
	var returnFlag = myJ('#returnFlag').val();
	var id = document.getElementById("submitDeviceType_deviceType_devTypeId").value;
	document.forms.editDeviceType.action = abstractUrl + "devicetypever/intoDeviceTypeVerInfo.action?functionType=1&id=" + id+"&returnFlag="+returnFlag;	
	document.forms.editDeviceType.submit();
	return false;
} 

//查看设备类型软件版本详细信息
function viewTypeVersionInfo(typeAndVerId){
    //该标实用来判断：是从设备管理模块过来 还是来自于设备类型模块
	//returnFlag == false 来自于 设备类型模块
	//returnFlag == ture  来自于 设备管理模块
	var returnFlag = myJ('#returnFlag').val();
	document.location.href = abstractUrl + "devicetypever/intoDeviceTypeVerInfo.action?functionType=2&deviceTypeVerInfo.typeAndVerId="+typeAndVerId+"&returnFlag="+returnFlag;
	return false;
	
}
//查看设备类型软件版本文件信息
function viewTypeVersionFileInfo(fileId,typeAndVerId){
    //该标实用来判断：是从设备管理模块过来 还是来自于设备类型模块
	//returnFlag == false 来自于 设备类型模块
	//returnFlag == ture  来自于 设备管理模块
	var returnFlag = myJ('#returnFlag').val();
	document.forms.editDeviceType.action = abstractUrl +"devicetypever/intoDeviceTypeVerInfo.action?functionType=5&deviceTypeVerInfo.fileId=" + fileId + "&deviceTypeVerInfo.typeAndVerId="+typeAndVerId+"&returnFlag="+returnFlag;
	document.forms.editDeviceType.submit();
	return false;
}
//删除设备类型软件版本
function deleteTypeVersion(typeAndVerId){
    //该标实用来判断：是从设备管理模块过来 还是来自于设备类型模块
	//returnFlag == false 来自于 设备类型模块
	//returnFlag == ture  来自于 设备管理模块
	var returnFlag = myJ('#returnFlag').val();
	var con = confirm("是否确认删除设备类型软件版本?");
	if(con){
	document.forms.editDeviceType.action = abstractUrl + "devicetypever/intoDeviceTypeVerInfo.action?functionType=4&deviceTypeVerInfo.typeAndVerId="+typeAndVerId+"&returnFlag="+returnFlag;
	document.forms.editDeviceType.submit();
	return false;
	}
 }
 
 //上传软件版本文件
 function addTypeVersionFile(typeAndVerId){
 	document.forms.editDeviceType.action = abstractUrl + "devicetypever/intoDeviceTypeVerInfo.action?functionType=8&deviceTypeVerInfo.typeAndVerId="+typeAndVerId;
	document.forms.editDeviceType.submit();
	return false;
 }
 //删除软件版本文件
 function deleteTypeVersionFile(fileId,typeAndVerId, fileName, devTypeDesName){
    //该标实用来判断：是从设备管理模块过来 还是来自于设备类型模块
	//returnFlag == false 来自于 设备类型模块
	//returnFlag == ture  来自于 设备管理模块
 	var returnFlag = myJ('#returnFlag').val();
    //alert("fileName= "+fileName+" devTypeDesName= "+devTypeDesName);
 	var con=confirm("是否确认删除版本文件?");
 	if(con){
 	document.forms.editDeviceType.action = abstractUrl + "devicetypever/intoDeviceTypeVerInfo.action?functionType=6&deviceTypeVerInfo.fileId=" + fileId + "&deviceTypeVerInfo.typeAndVerId="+typeAndVerId+"&fileName="+fileName+"&devTypeDesName="+devTypeDesName+"&returnFlag="+returnFlag;
	document.forms.editDeviceType.submit();
	return false;
 	}
 }
 
 //供应商名称列表change时间的操作
function selectCopyValue(){
	var name = document.getElementById("devVendorNameSelect").value;
	document.getElementById("devVendorName").value = name;
}

//
	var endPoint = "<%=path%>/remoting";

	//联动
	function linkdeviceType(){
		var vendor = document.getElementById("devVendorName1").value;
		$.post("<%=path%>/pages/ajax/EquipmentManagerAjaxAction.action",
				{vendor:vendor,method:"findEquipmentTypeByVendor"},function(data,status){
			document.all.devTypeNameArea.innerHTML = '<select name="filter.devTypeName" id="devTypeName1" onchange="linkHardwareVersion()"><option value="-1">请选择</option>' + data + '</select>';
		});
		var verdor1 = document.getElementById("deviceType.devVendorName").value;
		$.post("<%=path%>/pages/ajax/EquipmentManagerAjaxAction.action",
				{vendor:vendor,verdor1:verdor1,method:"findDevVendorOUITypeByVendor"},function(data,status){
			document.getElementById("devVendorOUI").value = data;
		});
		linkHardwareVersion();
		//填充到前面对应的文本框中(设备供应商)
		if(vendor != "-1"){
			document.getElementById("devVendorName").value = vendor;
		}
		return false;
	}
	
	function linkHardwareVersion(){
		var vendor = document.all.devVendorName1.value;
		var type = document.all.devTypeName1.value;
		$.post("<%=path%>/pages/ajax/EquipmentManagerAjaxAction.action",
				{vendor:vendor,type:type,method:"findHardwareVersionByEquipmentTypeAndVendor"},function(data,status){
			document.all.devHardVerArea.innerHTML = '<select name="filter.devHardVer" id="devHardVer1" onchange="setDevHardVerText();"><option value="-1">请选择</option>' + data + '</select>';
		});
		//填充到前面对应的文本框中(设备型号)
		if (type != "-1"){
			document.getElementById("devTypeName").value = type;
		}
		return false;
	}
	
	function setDevHardVerText(){
		//填充到前面对应的文本框中(设备硬件版本)
		var devHardVer = document.getElementById("devHardVer1").value;
		document.getElementById("devHardVer").value = devHardVer;
		return false;
	}

	var seelcttrue;

		//LAN接口数量
	function getDevLanNum(){
        $.post("<%=path%>/pages/ajax/EquipmentManagerAjaxAction.action",
            {method:"getDevLanNum"},function(data,status){
			document.getElementById("devLanNumArea").innerHTML = '<select class="mySelectCss" name="deviceType.devLanNum" id="devLanNum"  onchange="getDevPostNum();"><option value="">请选择</option>' + data + '</select>';
				$('select#devLanNum').val('${deviceType.devLanNum}');
				var devLanNum =  $('select#devLanNum').val();
				if(devLanNum !=''){
					getDevPostNum();
				}
		});
		
		
	}
	//Post接口数量
	function getDevPostNum(){
		var devLanNum =  $('select#devLanNum').val();
        $.post("<%=path%>/pages/ajax/EquipmentManagerAjaxAction.action",
            {devLanNum:devLanNum,method:"getDevPostNum"},function(data,status){
			document.getElementById("devPostNumArea").innerHTML = '<select class="mySelectCss" name="deviceType.devPostNum" id="devPostNum"  onchange="getUSBNum();"><option value="">请选择</option>' + data + '</select>';
				$('select#devPostNum').val('${deviceType.devPostNum}');
				
				var devPostNum =  $('select#devPostNum').val();
				if(devLanNum==''){
					$('select#devPostNum').val('')
					$('select#USBNum').val('');
					$('select#SDNum').val('');
					$('select#WLANNumber').val('');
				}else if(devPostNum==''){
					$('select#USBNum').val('');
					$('select#SDNum').val('');
					$('select#WLANNumber').val('');
				}else{
					getUSBNum();
				}
		});
		
	}
	//USB接口数量
	function getUSBNum(){
		var devLanNum =  $('select#devLanNum').val();
		var devPostNum =  $('select#devPostNum').val();
		if(devLanNum==''){
			alert("请先选择LAN接口数量!");
			$('select#devPostNum').val('');
			return false;
		}
        $.post("<%=path%>/pages/ajax/EquipmentManagerAjaxAction.action",
            {devLanNum:devLanNum,devPostNum:devPostNum,method:"getUSBNum"},function(data,status){
			document.getElementById("USBNumArea").innerHTML = '<select class="mySelectCss" name="deviceType.USBNum" id="USBNum"  onchange="getSDNum();"><option value="">请选择</option>' + data + '</select>';
				$('select#USBNum').val('${deviceType.USBNum}');
				var USBNum =  $('select#USBNum').val();
				if(devPostNum==''){
					$('select#USBNum').val('');
					$('select#SDNum').val('');
					$('select#WLANNumber').val('');
				}else if(USBNum==''){
					$('select#SDNum').val('');
					$('select#WLANNumber').val('');
				}else{
					getSDNum();
				}
			
		});
		
	}
	
	//SD卡接口数量
	function getSDNum(){
		var devLanNum =  $('select#devLanNum').val();
		var devPostNum =  $('select#devPostNum').val();
		var USBNum =  $('select#USBNum').val();
		if(devPostNum==''){
			alert("请先选择Post接口数量!");
			 $('select#USBNum').val('');
			return false;
		}
        $.post("<%=path%>/pages/ajax/EquipmentManagerAjaxAction.action",
            {devLanNum:devLanNum,devPostNum:devPostNum,USBNum:USBNum,method:"getSDNum"},function(data,status){
			document.getElementById("SDNumArea").innerHTML = '<select class="mySelectCss" name="deviceType.SDNum" id="SDNum" onchange="getWLANNumber();" ><option value="">请选择</option>' + data + '</select>';
				$('select#SDNum').val('${deviceType.SDNum}');
				var SDNum =  $('select#SDNum').val();
				if(USBNum==''){
					$('select#SDNum').val('');
					$('select#WLANNumber').val('');
				}else if(SDNum==''){
					$('select#WLANNumber').val('');
				}else{
					getWLANNumber();
				}
		});
		
	}
	//WLAN配置
	function getWLANNumber(){
		var devLanNum =  $('select#devLanNum').val();
		var devPostNum =  $('select#devPostNum').val();
		var USBNum =  $('select#USBNum').val();
		var SDNum =  $('select#SDNum').val();
		if(USBNum==''){
			alert("请先选择USB接口数量!");
			$('select#SDNum').val('');
			return false;
		}
        $.post("<%=path%>/pages/ajax/EquipmentManagerAjaxAction.action",
            {devLanNum:devLanNum,devPostNum:devPostNum,USBNum:USBNum,SDNum:SDNum,method:"getWLANNumber"},function(data,status){
			document.getElementById("WLANNumberArea").innerHTML = '<select class="mySelectCss" name="deviceType.WLANNumber" id="WLANNumber" onchange="end();" ><option value="">请选择</option>' + data + '</select>';
				$('select#WLANNumber').val('${deviceType.WLANNumber}');
				if(SDNum==''){
					$('select#WLANNumber').val('');
				}else{
					end();
				}
		});
		
	}
	function end(){
		var SDNum =  $('select#SDNum').val();
		if(SDNum==''){
			alert("请先选择SD卡接口数量!");
			$('select#WLANNumber').val('');
			return false;
		}
	}
	
	
	function initQuery(){
	
		
		$('select#devLanNum').val('${deviceType.devLanNum}');
		$("select#devPostNum").val('${deviceType.devPostNum}');
		$('select#USBNum').val('${deviceType.USBNum}');
		$('select#SDNum').val('${deviceType.SDNum}');
		$('select#WLANNumber').val('${deviceType.WLANNumber}');
		
		getDevLanNum();
		
	// 蒋加武 2007-6-1 更改.
	//在页面加载时不实行联动..这样会将设备的OUI更改为所有该类设备的第一个OUI,并不是该ID下的OUI
	
	//linkdeviceType();
	//linkHardwareVersion();
	}

//

</script>
</head>
<body onload="initQuery()">
<script src="<%=path %>/scripts/toolbar.js"></script>
	<br>
	<ww:form action="submitDeviceType" method="post" name="editDeviceType" validate="true">
		<ww:hidden name="functionType" />
		<ww:hidden name="deviceType.devTypeId" />
		<ww:hidden name="returnFlag" />
		<table width="98%" border="0" cellpadding="0" cellspacing="0"
			class="tableFormTable" align=center
			style="border-top:0px;border-bottom:0px;">
			<tr class="tableTitle">
				<td colspan=4>
					<img src="<%=path %>/images/dot2.gif" width="7" height="7">
					修改设备类型信息:
				</td>
			</tr>
			<tr>
				<td width="18%" class="tableFormLabel">
					&nbsp;设备供应商
				</td>
				<td width="32%" class="tableFormInput">
				<!--
					 不允许修改供应商的一些基本的信息
					 更改为只读属性 
					 蒋加武 edit 2007-06-15					
					 -->
					<ww:textfield name="deviceType.devVendorName" id="devVendorName" readonly="true"/>
					<!-- 
					<img src="<%=path %>/images/required_flag.gif" alt="必填字段">
					<ww:select id="devVendorName1" name="filter.devVendorName" list="deviceTypeDisplay.devVendorNameList" listKey="key" listValue="value" onchange="linkdeviceType()"/>
				  -->
				</td>
				<td width="18%" class="tableFormLabel">
					&nbsp;设备OUI
				</td>
				<td width="32%" class="tableFormInput">
				
					<ww:textfield name="deviceType.devVendorOUI" id="devVendorOUI" readonly="true" />
					<!-- 
					<img src="<%=path %>/images/required_flag.gif" alt="必填字段">
					 -->
				</td>
			</tr>
			<tr>
				<td width="18%" class="tableFormLabel">
					&nbsp;设备型号
				</td>
				<td width="32%" class="tableFormInput" >
					<ww:textfield name="deviceType.devTypeName" id="devTypeName"  readonly="true"/>
					<!-- 
					<img src="<%=path %>/images/required_flag.gif" alt="必填字段">
					<span id="devTypeNameArea" style="width: 50px">
						<select name="filter.devTypeName" id="devTypeName1" onchange="linkHardwareVersion()">
							<option value="-1">请选择</option>
						</select>
					</span> -->
				</td>
				<td width="18%" class="tableFormLabel">
					&nbsp;设备硬件版本
				</td>
				<td width="32%" class="tableFormInput">
					<ww:textfield name="deviceType.devHardVer" id="devHardVer" readonly="true"/>
					<!-- 
					<img src="<%=path %>/images/required_flag.gif" alt="必填字段">
					<span id="devHardVerArea" style="width: 50px">
						<select name="filter.devHardVer" id="devHardVer1" onchange="setDevHardVerText();">
							<option value="-1">请选择</option>
						</select>
					</span> -->
				</td>
			</tr>
			<tr>
				<td width="18%" class="tableFormLabel">
					&nbsp;LAN接口数量
				</td>
				<td width="32%" class="tableFormInput" id="devLanNumArea">
					<div style="text-align: left;margin-top: 8px;">  
					 	<select class="mySelectCss" name="deviceType.devLanNum" id="devLanNum"  onchange="getDevPostNum();" >
					          <option value="">请选择</option>
					    </select>
			        </div>  
				</td>
				
				<td width="18%" class="tableFormLabel">
					&nbsp;Post接口数量
				</td>
				<td width="32%" class="tableFormInput"  id="devPostNumArea">
					<div style="text-align: left;margin-top: 8px;">  
						<select class="mySelectCss" name="deviceType.devPostNum" id="devPostNum"  onchange="getUSBNum();" >
					          <option value="">请选择</option>
					    </select>
			        </div>  
				</td>
			</tr>
			<tr>
				<td width="18%" class="tableFormLabel">
					&nbsp;USB接口数量
				</td>
				<td width="32%" class="tableFormInput"  id="USBNumArea" >
					<div style="text-align: left;margin-top: 8px;">  
						<select class="mySelectCss" name="deviceType.USBNum" id="USBNum"  onchange="getSDNum();" >
					          <option value="">请选择</option>
					    </select>
			        </div>  
				</td>
				<td width="18%" class="tableFormLabel">
					&nbsp;SD卡接口数量
				</td>
				<td width="32%" class="tableFormInput"  id="SDNumArea">
					<div style="text-align: left;margin-top: 8px;">  
						<select class="mySelectCss" name="deviceType.SDNum" id="SDNum"  onchange="getWLANNumber();" >
					          <option value="">请选择</option>
					    </select>
			        </div>  
				</td>
			</tr>
			
			<tr>
			 	<td width="18%"  class="tableFormLabel">
					&nbsp;设备端口信息
				</td>
				<td width="32%" class="tableFormInput">
					<ww:select list="devKindList" cssStyle="width:50%" id="devtype" name="deviceType.devKind" listKey="key" listValue="value" headerKey="-1" headerValue="-----请选择-----" />
					<ww:hidden name="deviceType.devType" id="productType"/>
				</td>
				<td width="18%" class="tableFormLabel">
					&nbsp;WLAN配置
				</td>
				<td width="32%" class="tableFormInput" id="WLANNumberArea">
					<div style="text-align: left;margin-top: 8px;">  
						<select class="mySelectCss" name="deviceType.WLANNumber" id="WLANNumber"  onchange="end();" >
					          <option value="">请选择</option>
					    </select>
			        </div>  
				</td>
			</tr>
			<tr>
				<td width="18%" class="tableFormLabel"  >
					&nbsp;设备类型描述
				</td>
				<td  width="82%" class="tableFormInput"  colspan="3">
					<ww:textarea id="devTypeDesc" name="deviceType.devTypeDesc" cssStyle="width: 450px;"></ww:textarea>
				</td>
			</tr>
		</table>
	</ww:form>
	<table cellpadding="0" cellspacing="0" border="0" width="98%">
		<tr>
			<td width="99%"></td>
			<td width="1%">
			<jdf:hasPermission res="deviceType.manage">
			<img src="<%=path %>/images/create.gif" onclick="addDeivceTypeVer();" style="cursor: hand" alt="增加设备类型版本">
			</jdf:hasPermission>
			</td>
		</tr>
	</table>
<table style="width: 100%;height: 100%;" align="center" cellpadding="0" cellspacing="0" id="devTypeVerDisplayId">
	<tr >
		<td width="1%">
		</td>
			<td style="width: 98%;" valign="top">
				<div id="tableDiv" align="center">
					<ec:table items="deviceTypeVerList" var="deviceTypeVerInfo"
						width="98%"
						action="${pageContext.request.contextPath}/pages/business/resource/devicetype/intoDeviceType.action"
						imagePath="${pageContext.request.contextPath}/images/table/*.gif"
						retrieveRowsCallback="limit" sortRowsCallback="limit" view="compact"
						tableId="DeviceTypeVerManagerListAction" title="与设备类型对应的设备软件版本列表">
						<ec:row>
							<ec:column property="SoftVer" title="设备类型软件版本名称" width="" >
								<jdf:if res="deviceType.view">
									<a href="#" onclick="return viewTypeVersionInfo('${deviceTypeVerInfo.typeAndVerId}');">${deviceTypeVerInfo.softVer}</a>
								</jdf:if>
			            		<jdf:else>
			            			${deviceTypeVerInfo.softVer}
			            		</jdf:else>			            			
							</ec:column>
							<ec:column property="isNewest" title="是否最新版本" width="" dictType="ITMS_DEVICE_TYPE_VER.IS_NEWEST">
								<script>
									var status = "${deviceTypeVerInfo.isNewest}";
									if(status == "0"){
										document.write("<font color=green> 是 </font>");
									}else{
										document.write("<font color=red> 否 </font>");
									}
								</script>
							</ec:column>
							<ec:column property="FileName" title="设备类型软件版本文件" width="">
									<jdf:if res="deviceType.manage">
									<script>
									var fileId = "${deviceTypeVerInfo.fileId}";
									var fileName = "${deviceTypeVerInfo.fileName}";
									var typeAndVerId = "${deviceTypeVerInfo.typeAndVerId}";
									if(fileName == ""){
										document.write("<a href=\"#\" onclick=\"return addTypeVersionFile(\'"+ typeAndVerId + "\');\">");
										document.write("上传文件...");
										document.write("</a>");
									}else{
										document.write("<a href=\"#\" onclick=\"return viewTypeVersionFileInfo(" + "\'"+ fileId + "\'"+ "," + "\'"+typeAndVerId +"\'" + ");\">");
										document.write(fileName); 
										document.write("</a>");
									}	
									</script>		
									</jdf:if>
									<jdf:else>
									<script>
									var fileId = "${deviceTypeVerInfo.fileId}";
									var fileName = "${deviceTypeVerInfo.fileName}";
									var typeAndVerId = "${deviceTypeVerInfo.typeAndVerId}";
									if(fileName != ""){
										document.write("<a href=\"#\" onclick=\"return viewTypeVersionFileInfo(" + "\'"+ fileId + "\'"+ "," + "\'"+typeAndVerId +"\'" + ");\">");
										document.write(fileName); 
										document.write("</a>");
									}	
									</script>	
									</jdf:else>				
							</ec:column>
							<ec:column property="fileCreateTime" cell="date" format="yyyy-MM-dd HH:mm:ss" title="文件创建时间"></ec:column> 	      
							<ec:column property="fileSize" title="文件大小(bytes)" width=""></ec:column>
							<ec:column property="auditUserName" title="审核人" width=""></ec:column>
					    <%--<ec:column property="auditTime" cell="date" format="yyyy-MM-dd HH:mm:ss" title="审核时间" width=""></ec:column>--%>
						    <ec:column property="auditTime" title="审核时间" width=""></ec:column>
							<ec:column property="devTypeVerStatus" title="审核标志" width="" dictType="ITMS_DEVICE_TYPE_VER.DEV_TYPE_VER_STATUS"></ec:column>
							<ec:column property="operate" title="操作" width="" style="text-align:center">
								<jdf:hasPermission res="deviceType.approve">
								<script>
		            	 			var typeAndVerId = "${deviceTypeVerInfo.typeAndVerId}";
		            	 			var state = "${deviceTypeVerInfo.devTypeVerStatus}";
		            	 			var fileId = "${deviceTypeVerInfo.fileId}";
		            	 			var devTypeId = "${deviceTypeVerInfo.devTypeId}";
		            	 			var tr069VerId = "${deviceTypeVerInfo.tr069VerId}";
		            				if(state == "0" && tr069VerId!=""){
		            					document.write("<a href=\"#\" onclick=\"return changeTypeVersionState(" + "\'"+ typeAndVerId + "\'" + "," + "\'"+state +"\'" + ");\">");      			
				      					document.write("<img src=\"<%=path%>/images/tick.gif\" border=\"0\" alt=\"审核软件版本\" \>");
				      					document.write("</a>");
				      				}else if(state == "0" && tr069VerId==""){
				      					document.write("<img src=\"<%=path%>/images/tick.gif\" border=\"0\" alt=\"未绑定TR069版本,不能审核软件版本\" style=\"disabled\" \>");
				      				}else{
				      					document.write("<a href=\"#\" onclick=\"return changeTypeVersionState(" + "\'"+ typeAndVerId + "\'" +"," + "\'"+state +"\'" + ");\">");
				      					document.write("<img src=\"<%=path%>/images/deleteIcon.gif\" border=\"0\" alt=\"撤消审核\" \>");
				      					document.write("</a>");
				            		}
		            			</script>
		            			</jdf:hasPermission>
		            			<jdf:hasPermission res="deviceType.manage">
		            			<a href="#" onclick="return deleteTypeVersion('${deviceTypeVerInfo.typeAndVerId}');">
		            			<img src="<%=path%>/images/cancel.gif" border="0" alt="删除设备类型软件版本"/>
		            			</a>&nbsp;
		            			</jdf:hasPermission>
		            			<jdf:hasPermission res="deviceType.manage">
		            			<script>
		            			var fileId = "${deviceTypeVerInfo.fileId}";
		            			var state = "${deviceTypeVerInfo.devTypeVerStatus}"; 
                                var devTypeDesName = "${deviceType.devVendorName} ${deviceType.devTypeName} ${deviceType.devHardVer}";
		            			if(fileId != "0" && state == "0"){
		            				document.write("<a href=\"#\" onclick=\"return deleteTypeVersionFile(" + "\'" +${deviceTypeVerInfo.fileId} + "\'" + "," + "\'" + ${deviceTypeVerInfo.typeAndVerId} + "\',\'"+  fileName + "\',\'"+ devTypeDesName +"\');\">");
		            				document.write("<img src=\"<%=path%>/images/del.gif\" border=\"0\" alt=\"删除软件版本文件\" \>");
		            				document.write("</a>");
		            			}else{
		            				document.write("<img src=\"<%=path%>/images/del.gif\" border=\"0\" alt=\"版本已审核或文件不存在\" style=\"disabled\" \>");
		            			}
		            			</script>
		            			</jdf:hasPermission>
		            		</ec:column>	
					</ec:row>
				</ec:table>
			</div>
		</td>
		<td width="1%">
		</td>
		</tr>
	</table>			
</body>
</html>

