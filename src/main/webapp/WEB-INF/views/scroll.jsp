<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Spring Framework - Ajax</title>
<style>
table {
	width: 100%;
	border: 1px solid #444444;
}

th, td {
	border: 1px solid #444444;
}
</style>
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-kernel/master/dist/ax5ui.all.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-kernel/master/dist/ax5ui.all.min.js"></script>
<script type="text/javascript">

var first = 0;
var last = 0;
var ppp = 0;

$( document ).ready(function() {
	
	 
	$(window).scroll(function() {

			var scrollHeight = $(window).scrollTop() + $(window).height();
			var documentHe = $(document).height();

			if (scrollHeight == documentHe) {
				
				ppp = ppp+1;
				
				if(ppp%2==0){
					
					//alert("1::: "+$('tr.aaa').first().attr("name"));
					//alert("2::: "+$('tr.aaa').last().attr("name"));
					
					var aaa = $('tr.aaa').last().attr("name");
					if(typeof(aaa) == "string") {
					
						aaa = aaa.split('_');
						var ccc = 0;
						ccc = aaa[1];
						ccc = Number(ccc);
						aaa = ccc +1;
					}
					
					
					alert("aaa ::: "+aaa);
					
					var bbb = aaa +50;
					
					alert("bbb ::: "+bbb);
					if(aaa > 1) {
						first = aaa;
						last = bbb;
					}
					var _pageNo = 0;
					searchPost(_pageNo);
					
				}
			}

		});

	});

	function search(_pageNo) {
		if ($('#SearchForm').attr("method") == "POST") {
			searchPost(_pageNo);
		} else {
			searchGet(_pageNo);
		}
	}

	function searchPost(_pageNo) {
		
		var count = 0;
		var html = '';
		
		if(first == 0 && last == 0) {
			first = 1;
			last = 50;
			
		}
		
		var aaa = $('tr.aaa').last().attr("name");
		if(typeof(aaa) == "string") {
		
			aaa = aaa.split('_');
			var ccc = 0;
			ccc = aaa[1];
			ccc = Number(ccc);
			aaa = ccc +1;
		}
		console.log("first :: "+first);
		console.log("last :: "+last);
		
		$('#page').val(_pageNo || 0);
		var sendData = JSON.stringify({
			type : $('#type').val(),
			complete : $('#complete').val(),
			page : $('#page').val(),
			first : first,
			last : last

		});
		console.log(sendData);
		$.ajax({
			type : "POST",
			url : "<c:url value='/searchPost.do' />",
			data : sendData,
			dataType : "json",
			contentType : "application/json;charset=UTF-8",
			async : true,
			success : function(data, status, xhr) {
				console.log("1111 ::: " + JSON.stringify(data));
				//data.list[0].num;
				count = data.list.length;
				
				
				
				for (var i = 0; i < count; i++) {
					if(aaa > 1){
						html += '<tr class="aaa" name="aaa_'+(aaa+i)+'">';	
					}else {
						html += '<tr class="aaa" name="aaa_'+(i+1)+'">';
					}
					html += '	<td>' + data.list[i].num + '</td>';
					html += '	<td>' + data.list[i].date + '</td>';
					html += '	<td>' + data.list[i].mileage + '</td>';
					html += '	<td>' + data.list[i].price + '</td>';
					html += '</tr>';

				}

				$("#list").append(html);

			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(jqXHR.responseText);
			}
		});
	}

	function searchGet(_pageNo) {
		$('#page').val(_pageNo || 0);

		//var sendData = {"type":$('#type').val(), "complete":$('#complete').val(), page:$('#page').val()};
		var sendData = $('#SearchForm').serialize();
		console.log(sendData);

		$.ajax({
			type : "GET",
			url : "<c:url value='/searchGet.do' />",
			data : sendData,
			async : true,
			success : function(data, status, xhr) {
				console.log(data);
				firstGrid.setData({
					list : data.list,
					page : {
						currentPage : _pageNo,
						pageSize : 10,
						totalElements : data.total,
						totalPages : data.totalPages
					}
				});
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(jqXHR.responseText);
			}
		});
	}

	function searchType(method) {
		$('#SearchForm').attr("method", method)
		console.log($('#SearchForm').attr("method"));
		search(0);
	}
</script>
</head>

<body>
<h3>Spring Framework - Ajax</h3>
<div style="margin-bottom:10px;">
	<form id="SearchForm" name="SearchForm" method="GET" style="display:inline;">
	    <input type="hidden" id="page" name="page" value="" />
		<label for="type">구분:</label>
		<select id="type" name="type">
			<option value="" >전체</option>
			<option value="R">정비</option>
			<option value="O">주유</option>
		</select>
		<label for="complete">완료:</label>
		<select id="complete" name="complete">
			<option value="" >전체</option>
			<option value="Y">yes</option>
			<option value="N">no</option>
		</select>
	</form>
	<button onclick="searchType('POST');">조회 POST</button>
	<button onclick="searchType('GET');">조회 GET</button>
</div>

		<table>
			<thead>
				<th>순번</th>
				<th>날짜</th>
				<th>마일리지</th>
				<th>가격</th>
			</thead>
			<tbody id="list">
			
			</tbody>
		</table>

</body>
</html>
