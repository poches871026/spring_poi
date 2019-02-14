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
	[<a href="<c:url value='/boardRegisterForm.do' />">등록</a>]
	[<a href="<c:url value='/excelDown.do' />">엑셀</a>]
	<div class="text-right">
			<button type="button" class="btn btn-default btn-xs excelDown">엑셀다운로드</button>
	</div>	
	</div>
	 <form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data"
    method="post" action= "/pentode/excelUploadAjax.do">
    <div class="contents">
    <div>첨부파일은 한개만 등록 가능합니다.</div>

    <dl class="vm_name">
      <dt class="down w90">첨부 파일</dt>
        <dd><input id="excelFile" type="file" name="excelFile" /></dd>
      </dl>        
    </div>

    <div class="bottom">
      <button type="button" id="addExcelImpoartBtn" class="btn" onclick="check()" ><span>추가</span></button>
    </div>
  </form>
	<form method="post" id="form">
	<table border="1">
	<thead>
	<tr class="theadtest">
		<th>번호</th>
		<th>이름</th>
		<th>제목</th>
		<th>조회</th>
		<th>작성일</th>
	</tr>
	</thead>
	<tbody>
		<c:forEach var="item" items="${list}">
		<tr class="tbodytest">
			<td>${item.num}</td>
			<td>${item.name}</td>
			<td title="${item.title}" no="${item.num}">${item.title}</td>
			<td>${item.readCount}</td>
			<!-- 데이터포멧 -->
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
// ready 시작
$( document ).ready(function() {
	
	$(".theadtest").trigger('click');
	
	$(".excelDown").on("click", function() {
		form.action="/pentode/memberExcelDownload.do";
		form.target="excelFrame";
		form.method="POST";
		form.submit();
	}); 
	
});
//ready 끝
$(".theadtest").click(function() {
	
	var tr = $(this);
    var td = tr.children();
    var tdHead = "제목";
    //alert("ddd");	
    // tr,td,tdHead 정보 fn_test에넘겨주었다.
    fn_test(tr,td,tdHead);
});

$(".tbodytest").click(function() {
	
	//alert("클릭");
	var tr = $(this);
    var td = tr.children();
	var trIndex = $(this).index();
	console.log("trIndex ::: "+trIndex);
	// 및에서 보는 eq2뜻이 왼쪽기준 0,1,2,3,4 라는 뜻이다.
	var title = td.eq(titleIndex).attr("title");
	alert("title ::: "+title);
	var no = td.eq(titleIndex).attr("no");
	alert("no ::: "+no);
	
//  	alert("tr :::: "+tr);
//  	alert("td :::: "+td);
});

function fn_test(tr,td,tdHead) {
	//alert("tdHead ::: "+tdHead);
	//td의 칸만큼 for문 돈다.
	$(td).each(function(i) {
    	//alert($(td).eq(i).text());
    	// 위에 제목과 동일한 텍스트가 있을경우 해당 전역변수에 값 저장
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
			alert("파일을 선택해주세요.");

			return false;
		} else if (!checkFileType(file)) {
			alert("엑셀 파일만 업로드 가능합니다.");

			return false;
		}

		if (confirm("업로드 하시겠습니까?")) {

			var options = {
				success : function(data) {
					console.log("data ::: "+data);
					alert("모든 데이터가 업로드 되었습니다.");
					location.href='/pentode/boardList.do' 

				},
				type : "POST"
			};

			$("#excelUploadForm").ajaxSubmit(options);
		}
	}
</script>

</html>
