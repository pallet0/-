<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
	<meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Board List</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
	<!-- C태그를 사용하기 위한 라이브러리 --> 
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!-- jquery 공식 홈페이지에서는 버전 번호를 쓰도록 추천하고 있다. --> 
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
	  $(document).ready(function(){
		  $('.initial').hide();
		  $('.initial').fadeIn(6000);
		  $('.tdTtl').mouseenter(function(){
			  //To do
		  });
	  });
	
	  function fnGoBoardCreate(){
		  $('#frmList').attr({action : "/board/boardCreate.do"}).submit();
	  }
	  
	  function fnGoBoardDetail(listseq){
		  $('#frmSeq').val(listseq);
		  $('#frmList').attr({action : "/board/boardDetail.do"}).submit();
	  }	  
	  
	  function fnLogOut(){
		  $('#frmList').attr({action : "/board/boardLogout.do"}).submit();
	  }
	</script>
  </head>
  <body>
    <h2 style="padding:0.1em 1em;">게시판 목록</h2>
    <form id="frmList" name="frmList" method="post">
      <input type="hidden" id="frmSeq" name="frmSeq" />
      <table id="tlist" border="1px dashed #EEEEEE">
        <thead>
          <tr>
            <th>글번호</th>
            <th colspan="3">제 목</th>
            <th>글쓴이</th>
            <th>작성일</th>
            <th>고친이</th>
            <th>수정일</th>
            <th>조회수</th>
          </tr>
        </thead>
        <tbody>
          <!-- 컨트롤러에서 받은 listAll을 i로 치환해 반복한다. -->
          <c:forEach var="i" items="${listAll}"> 
            <tr>         
              <td>${i.boardSeq}</td>
              <!-- 제목을 클릭하면 글 번호를 파라미터로 받는 함수를 호출한다. -->
              <td class="tdTtl" colspan="3" onclick="fnGoBoardDetail(${i.boardSeq})">${i.boardTtl}</td>
              <td>${i.boardWusr}</td>
              <!-- C태그에서 날짜 자르기 -->
              <td><c:out value="${fn:substring(i.boardWdt,0,10)}"/></td>
              <td>${i.boardMusr}</td>
              <td><c:out value="${fn:substring(i.boardMdt,0,10)}"/></td>
              <td>${i.boardCnt}</td> 
            </tr>
          <!-- C태그 반복문이 끝난다. -->
          </c:forEach>
        </tbody>
      </table>
      <div class="mybutton">
        <input id="goCreate" name="goCreate" type="button" onclick="fnGoBoardCreate()" value="새로이 글쓰기" />
        <input id="logOut" name="logOut" type="button" value="로그아웃" onclick="fnLogOut()"/>
      </div>
      <div class="initial">
        <p>by csh</p> 
        <p></p>
      </div>
    </form>
  </body>
</html>