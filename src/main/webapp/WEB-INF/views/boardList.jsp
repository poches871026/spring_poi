<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<title>Home</title>
</head>
<body>
	<h1>Board List</h1>
	<div>
	[<a href="<c:url value='/boardRegisterForm.do' />">���</a>]
	[<a href="<c:url value='/excelDown.do' />">����</a>]
	<div class="text-right">
			<button type="button" class="btn btn-default btn-xs excelDown">�����ٿ�ε�</button>
	</div>	
	</div>
	 <form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data"
    method="post" action= "/pentode/excelUploadAjax.do">
    <div class="contents">
    <div>÷�������� �Ѱ��� ��� �����մϴ�.</div>

    <dl class="vm_name">
      <dt class="down w90">÷�� ����</dt>
        <dd><input id="excelFile" type="file" name="excelFile" /></dd>
      </dl>        
    </div>

    <div class="bottom">
      <button type="button" id="addExcelImpoartBtn" class="btn" onclick="check()" ><span>�߰�</span></button>
    </div>
  </form>
	<form method="post" id="form">
	<table border="1">
	<thead>
	<tr class="theadtest">
		<th>��ȣ</th>
		<th>�̸�</th>
		<th>����</th>
		<th>��ȸ</th>
		<th>�ۼ���</th>
	</tr>
	</thead>
	<tbody>
		<c:forEach var="item" items="${list}">
		<tr class="tbodytest">
			<td>${item.num}</td>
			<td>${item.name}</td>
			<td title="${item.title}" no="${item.num}">${item.title}</td>
			<td>${item.readCount}</td>
			<!-- ���������� -->
			<td><fmt:formatDate value="${item.writeDate}" pattern="yyyy-MM-dd"/></td>
		</tr>
		</c:forEach>
	</tbody>
	</table>
	</form>
</body>
<!-- jQuery  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script type="text/javascript">
var titleIndex = "";
// ready ����
$( document ).ready(function() {
	
	$(".theadtest").trigger('click');
	
	$(".excelDown").on("click", function() {
		form.action="/pentode/memberExcelDownload.do";
		form.target="excelFrame";
		form.method="POST";
		form.submit();
	}); 
	
});
//ready ��
$(".theadtest").click(function() {
	
	var tr = $(this);
    var td = tr.children();
    var tdHead = "����";
    //alert("ddd");	
    // tr,td,tdHead ���� fn_test���Ѱ��־���.
    fn_test(tr,td,tdHead);
});

$(".tbodytest").click(function() {
	
	//alert("Ŭ��");
	var tr = $(this);
    var td = tr.children();
	var trIndex = $(this).index();
	console.log("trIndex ::: "+trIndex);
	// �׿��� ���� eq2���� ���ʱ��� 0,1,2,3,4 ��� ���̴�.
	var title = td.eq(titleIndex).attr("title");
	alert("title ::: "+title);
	var no = td.eq(titleIndex).attr("no");
	alert("no ::: "+no);
	
//  	alert("tr :::: "+tr);
//  	alert("td :::: "+td);
});

function fn_test(tr,td,tdHead) {
	//alert("tdHead ::: "+tdHead);
	//td�� ĭ��ŭ for�� ����.
	$(td).each(function(i) {
    	//alert($(td).eq(i).text());
    	// ���� ����� ������ �ؽ�Ʈ�� ������� �ش� ���������� �� ����
		if(tdHead == $(td).eq(i).text() ) {
			//alert("index ::: "+$(this).index());
			titleIndex = $(this).index();
		}
    });
}


	function checkFileType(filePath) {
		var fileFormat = filePath.split(".");

		if (fileFormat.indexOf("xls") > -1 || fileFormat.indexOf("xlsx") > -1) {
			return true;
		} else {
			return false;
		}
	}

	function check() {

		var file = $("#excelFile").val();

		if (file == "" || file == null) {
			alert("������ �������ּ���.");

			return false;
		} else if (!checkFileType(file)) {
			alert("���� ���ϸ� ���ε� �����մϴ�.");

			return false;
		}

		if (confirm("���ε� �Ͻðڽ��ϱ�?")) {

			var options = {
				success : function(data) {
					console.log("data ::: "+data);
					alert("��� �����Ͱ� ���ε� �Ǿ����ϴ�.");
					location.href='/pentode/boardList.do' 

				},
				type : "POST"
			};

			$("#excelUploadForm").ajaxSubmit(options);
		}
	}
</script>

</html>
