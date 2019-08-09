<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/adminHeader.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(document).ready(function() {
		$("#reg-btn").click(function(){
			var title = $("input[name='title']").val();
			var writer = $("input[name='writer']").val();
			var startDate = $("#startDate").val();
			var endDate = $("#endDate").val();
			var image = $("input[name='image']").val();
			var content = $("input[name='content']").val();
			
			if(!title){
				alert("제목을 입력해주세요.");
				return false;
			}
			if(!writer){
				alert("작성자를 입력해주세요.");
				return false;
			}
			if(!startDate){
				alert("시작일을 입력해주세요.");
				return false;
			}
			if(!endDate){
				alert("종료일을 입력해주세요.");
				return false;
			}
			if(!image){
				alert("목록 이미지를 선택해주세요.");
				return false;
			}
			if(!content){
				alert("내용 이미지를 선택해주세요.");
				return false;
			}
			$("#startDate").val(startDate+ " 00:00:00");
			$("#endDate").val(endDate+" 23:59:59");
			document.writeForm.submit();
		});
		});
</script>
<script type="text/javascript">
$(function() {
	$("#startDate").datepicker(
			{
				dateFormat : 'yy-mm-dd',
				prevText : '이전 달',
				nextText : '다음 달',
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
						'8월', '9월', '10월', '11월', '12월' ],
				monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
						'7월', '8월', '9월', '10월', '11월', '12월' ],
				dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
				showMonthAfterYear : true,
				yearSuffix : '년',
				onClose : function(selectedDate) {
					// 시작일(startDate) datepicker가 닫힐때
					// 종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
					$("#endDate").datepicker("option", "minDate",
							selectedDate);
				}
			});
	$("#endDate").datepicker(
			{
				dateFormat : 'yy-mm-dd',
				prevText : '이전 달',
				nextText : '다음 달',
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
						'8월', '9월', '10월', '11월', '12월' ],
				monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
						'7월', '8월', '9월', '10월', '11월', '12월' ],
				dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
				showMonthAfterYear : true,
				yearSuffix : '년',
				onClose : function(selectedDate) {
					// 종료일(endDate) datepicker가 닫힐때
					// 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
					$("#startDate").datepicker("option", "maxDate",
							selectedDate);
				}
			});
});
$(function() {
	$("#startDate").datepicker({
		onSelect : function(dateText, inst) {
		}
	});
	$("#endDate").datepicker({
		onSelect : function(dateText, inst) {
		}
	});

});
</script>
<div class="right">
		<h1>게시판 관리</h1>
	<div class="write" style="height:640px">
		<form name="writeForm" action="/admin/board.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="mode" value="write"> <input
				type="hidden" name="boardCode" value="${boardCode}">
			<h2 style="text-align: center">글쓰기</h2>
			<table>
			<tr>
			<th>게시판</th>
			<td colspan="2" style="font-size:18px;">이벤트</td>
			</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" name="title"></td>
				</tr>
				<tr id="writer">
					<th>작성자</th>
					<td colspan="3"><input type="text" name="writer" value="관리자"></td>
				</tr>
				<tr>
					<th>시작일</th>
					<td><input type="text" name="eventStart" id="startDate"
						readonly> <input type="button" id="calendar"
						onclick="$('#startDate').datepicker('show');" /></td>
					<th>종료일</th>
					<td><input type="text" name="eventEnd" id="endDate" readonly>
						<input type="button" id="calendar"
						onclick="$('#endDate').datepicker('show');" /></td>
				</tr>
				<tr>
					<th>목록 이미지</th>
					<td colspan="3"><input type="file" name="image"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><input type="file" name="content"></td>
				</tr>
			</table>
			<div style="text-align: center; padding-top: 50px">
				<button id="reg-btn" type="button">등록</button>&nbsp;&nbsp;
					<button id="cancel-btn" type="button" onClick="history.go(-1)">취소</button>
			</div>
		</form>
	</div>
</div>
</section>
<%@include file="../includes/adminFooter.jsp"%>