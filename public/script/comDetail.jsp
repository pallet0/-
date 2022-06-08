<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ajax 통신을 위한 json 설정 -->
<%@ page import="org.json.simple.JSONObject"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Board Detail</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" /> 
	<!-- C태그 -->
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<!-- jquery -->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
      /* 삭제를 실행했는지 아닌지 체크해서 삭제 실행 완료라면 목록 화면으로 간다. */
      $(document).ready(function(){
    	  if( '${frmDel}'=="true" ){
    		  alert("삭제되었습니다.");
    		  $('#frmDetail').attr({action : "/board/boardList.do"}).submit();
    	  }
      });
    
      /* 게시판으로 간다. */
      function fnGoBoardList(){
    	  $('#frmDetail').attr({action : "/board/boardList.do"}).submit();
      }
      
      /* 수정 화면으로 간다. */
      function fnGoBoardModify(){
    	  $('#frmDetail').attr({action : "/board/boardModify.do"}).submit();
      }
      
      /* 삭제를 실행한다. */
      function fnDelete(){
    	  $('#frmDetail').attr({action : "/board/boardDelete.do"}).submit();
      }
      
      /* 상세 조회를 실행할 때마다 게시글 조회수가 올라간다. */
      function cntPlus(){
    	  var rtn = false;
    	  $.ajax({
    		  type: "POST",
    		  url: "/board/boardFileDownCnt.do",
    		  timeout: 1000,
    		  data: "frmSeq=" + $('#frmSeq').val(),
    		  dataType: "json",
    		  async: false,
    		  success: function(msg){
    			  if( msg.jResult==true )
    				  rtn = true;
    		  },error: function(e){
    			  alert("FileDownCnt Ajax Error : "+e);
    		  }
    	  });
    	  return rtn;
      }
    </script>
  </head>
  <body>
    <h2 style="padding:0.1em 1em;">글 상세 정보</h2>
    <form id="frmDetail" name="frmDetail" method="post">
      <!-- 목록에서 글 번호를 받아 와서 수정 또는 삭제 화면으로 넘긴다. -->
      <input type="hidden" id="frmSeq" name="frmSeq" value="${frmSeq}"/>
      <!-- 삭제했는지 체크하는 플래그 -->
      <input type="hidden" id="frmDel" name="frmDel" />
      <table id="tdetail" border="1px dashed #EEEEEE">
        <thead>
          <tr>
            <th>글번호</th>
            <!-- 컨트롤러에서 받아온 ArrayList detailAll에서 정보를 뽑는다. -->
            <td>${detailAll.get(0)}</td>
            <th>제 목</th>
            <td colspan="5">${detailAll.get(1)}</td>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th>글쓴이</th>
            <td>${detailAll.get(3)}</td>
            <th>작성일시</th>
            <td>${detailAll.get(4)}</td>
            <th>고친이</th>
            <td>${detailAll.get(5)}</td>
            <th>수정일시</th>
            <td>${detailAll.get(6)}</td>
          </tr>
          <tr>
            <!-- 본문 -->
            <td colspan="8" rowspan="10" style="padding:1em;text-align:left;">${detailAll.get(2)}</td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
          	<th>첨부 파일</th>
          	<!-- C태그의 if-else문 -->
          	<c:choose>
          		<c:when test='${detailAll.get(8) eq "Y"}'>
          			<td colspan="5">
          			    <!-- onclick 결과가 true일 때만 href가 실행된다. -->
          				<a href="/board/boardFileDownload.do?filePath=${detailAll.get(11)}&fileName=${detailAll.get(10)}" onclick="return cntPlus();">
          					${detailAll.get(9)}
          				</a>
          			</td>
          			<!-- 첨부파일의 다운로드 횟수. 첨부파일이 없으면 이 부분도 없다. -->
          			<th>다운로드 횟수</th>
          			<td>${detailAll.get(12)}</td>
          		</c:when>
          		<!-- C태그의 else문 -->
          		<c:otherwise>
          			<td colspan="7">첨부 파일 없음</td>
          		</c:otherwise>
          	</c:choose>
          </tr>
        </tfoot>
      </table>
      <div class="mybutton">
      <!-- C태그로 조회한 사용자가 글을 쓴 사용자와 일치하는지 확인한다. -->
      <c:if test='${detailAll.get(3) eq frmShow}'>
        <input type="button" id="delete" name="delete" onclick="fnDelete()" value="삭제"/>
        <input type="button" id="modify" name="modify" onclick="fnGoBoardModify()" value="수정"/>
	  <!-- else가 없는 경우에만 c:if를 쓴다. -->
      </c:if>
        <input type="button" id="cancel" name="cancel" onclick="fnGoBoardList()" value="목록으로"/>
      </div>
    </form>    
  </body>
</html>