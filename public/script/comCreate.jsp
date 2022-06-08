<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
    <title>Board Create</title>
    <!-- C태그 라이브러리 사용을 위해 써준다. -->
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!-- jquery를 사용하기 위한 코드 -->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
    
      $(document).ready(function(){
    	  /* 플래그 frmSave를 체크한다. */
    	  if( '${frmSave}' == "true" ) {
    		  alert("저장되었습니다.");
    		  $('#frmCreate').attr({action : "/board/boardList.do"}).submit();
    	  }
      });
    
      /* 게시판 목록으로 */ 
      function fnGoBoardList(){  
    	  $('#frmCreate').attr({action : "/board/boardList.do"}).submit();
      }
    
      /* 저장 버튼을 누르면 실행된다. */
      function fnSave(){   	  
    	  if( $('#frmTitle').val()=="" || $('#frmTitle').val()==null ){
    		  alert("제목을 입력하세요.");
    		  $('#frmTitle').focus();
    		  return;
    	  }
    	  if( $('#frmContents').val()=="" || $('#frmContents').val()==null ){
    		  alert("본문을 입력하세요.");
    		  $('#frmContents').focus();
    		  return;
    	  }
    	  if( $('#frmfup').val()!="" && $('#frmfup').val()!=null ){
    		  //alert("파일 "+$('#frmfup').val()+"를 첨부합니다.");
    	  }
    	  $('#frmCreate').attr({action : "/board/boardSaveCre.do"}).submit();
      }
    </script>    
  </head>
  <body>
    <h2 style="padding:0.1em 1em;">새로이 글쓰기</h2>
    <!-- 파일 첨부를 위해서는 multipart/form-data를 추가해야 한다. -->
    <form id="frmCreate" name="frmCreate" method="post" enctype = "multipart/form-data">
      <input type="hidden" id="frmSave" name="frmSave" />
      <table id="tcreate" border="1px dashed #EEEEEE" width="50%">
        <thead>
          <tr>
            <th>제목</th>
            <!-- input type이 text -->
            <td><input id="frmTitle" name="frmTitle" type="text" onkeydown="if(event.keyCode==13) fnSave()" style="height:auto;width:90%;color:#010101"/></td>
          </tr>        
        </thead>
        <tbody>
          <tr>
            <th>본문</th>
            <!-- input type이 textarea -->
            <td><textarea id="frmContents" name="frmContents" cols="50%" rows="10%" style="color:#010101;"></textarea></td>
          </tr>
          <tr>
            <th>파일첨부</th>
            <!-- input type이 file -->
            <td><input style="font-family:'바탕체', Georgia, serif;font-size:14px;" type="file" id="frmfup" name="frmfup"/></td>
          </tr>
        </tbody>
      </table>
    
      <br />
      <div class="mybutton">
        <input id="frmInsert" name="frmInsert" type="button" onclick="fnSave()" value="저장" />
        <input id="frmCancel" name="frmCancel" type="button" onclick="fnGoBoardList()" value="글쓰기 취소" />
      </div>
    </form>
  </body>
</html>