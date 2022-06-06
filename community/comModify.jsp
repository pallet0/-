<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Board Modify</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
    <!-- C태그 -->
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!-- jquery -->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
      $(document).ready(function(){
    	  /* 만약 수정 완료 플래그가 true면 곧장 게시판 목록으로 간다. */
    	  if( '${frmSave}'=="true" ){
    		  alert("수정되었습니다.");
    		  $('#frmModify').attr({action : "/board/boardList.do"}).submit();
    	  }
    	  /* 만약 본디 글에 파일이 첨부돼 있다면 플래그를 be to be same으로 한다. */
    	  if( '${modifyAll.get(5)}'=="Y" ){
    		  $('#frmFlag').val("BtoBsame");
    	  /* 만약 본디 글에 첨부 파일이 없다면 플래그를 none to none으로 한다. */
    	  }else if( '${modifyAll.get(5)}'=="N" ){
    		  $('#frmFlag').val("NtoN");
    	  }else{
    		  $('#frmFlag').val("BtoBsame");
    	  }	  
    	  /* 파일 다시 올림, 파일 추가, 파일 삭제 버튼을 일단 숨긴다. */
    	  $('#frmfup').hide();
    	  $('#frmfadd').hide();
    	  $('#frmfnone').hide();
      });
    
      /* 수정 사항을 저장할 때 실행된다. */
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
    	  $('#frmModify').attr({action : "/board/boardSaveMod.do"}).submit();
      }
      
      /* 게시판 목록으로 돌아간다. */
      function fnGoBoardList(){
    	  $('#frmModify').attr({action : "/board/boardList.do"}).submit();
      }

      /* 있던 첨부 파일을 다른 첨부 파일로 바꿀 때의 함수 */
      function fnFileChange(){
    	  $('#frmfup').show();
    	  $('#frmfexist').hide();
    	  $('#frmfmodify').hide();
    	  $('#frmfdel').hide();
    	  /* 플래그를 be to be other로 바꾼다. */
    	  $('#frmFlag').val("BtoBother");
      }
      
      /* 있던 첨부 파일을 삭제할 때의 함수 */
      function fnFileDel(){
    	  $('#frmfnone').show();
    	  $('#frmfexist').hide();
    	  $('#frmfmodify').hide();
    	  $('#frmfdel').hide();
    	  /* 플래그를 be to none으로 바꾼다. */
    	  $('#frmFlag').val("BtoN");
      }
      
      /* 첨부 파일이 없었는데 추가할 때의 함수 */
      function fnFileAdd(){
    	  $('#frmfadd').show();
    	  $('#frmfno').hide();
    	  /* 플래그를 none to be로 바꾼다. */
    	  $('#frmFlag').val("NtoB");
      }
    </script>
  </head>
  <body>
    <h2 style="padding:0.1em 1em;">글 수정하기</h2>
    <form id="frmModify" name="frmModify" method="post" enctype = "multipart/form-data">
      <input type="hidden" id="frmSeq" name="frmSeq" value="${frmSeq}" />
      <input type="hidden" id="frmFlag" name="frmFlag" />
      <input type="hidden" id="frmSave" name="frmSave" />
      <table id="tmodify" border="1px dashed #EEEEEE" width="50%">
        <thead>
          <tr>
            <th>제목</th>
            <!-- 컨트롤러에서 받아온 ArrayList의 내용 중 제목을 화면에 뿌린다. -->
            <td colspan="7"><input id="frmTitle" name="frmTitle" type="text" onkeydown="if(event.keyCode==13) fnSave()" value="${modifyAll.get(1)}" style="height:auto;width:90%;color:#010101" /></td>
          </tr>        
        </thead>
        <tbody>
          <tr>
            <th>글쓴이</th>
            <td colspan="3">${modifyAll.get(3)}</td>
            <th>작성일시</th>
            <td colspan="3">${modifyAll.get(4)}</td>
          </tr>
          <tr>
            <th>본문</th>
            <!-- 컨트롤러에서 받아온 ArrayList의 내용 중 본문을 화면에 뿌린다. -->
            <td colspan="7"><textarea id="frmContents" name="frmContents" cols="50%" rows="10%" style="color:#010101;">${modifyAll.get(2)}</textarea></td>
          </tr>
          <tr>
            <th>첨부된 파일</th>
            	<!-- C태그의 if-else 중 if문 -->
            	<c:choose>
            		<!-- 만일 파일 첨부 여부가 Y면 -->
          			<c:when test='${modifyAll.get(5) eq "Y"}'>
          				<td colspan="7">
          					<!-- 원래 글에 첨부되어 있던 파일 정보 -->
          					<a id="frmfexist" href="/board/boardFileDownload.do?filePath=${modifyAll.get(8)}&fileName=${modifyAll.get(7)}">
          					 ${modifyAll.get(6)}
          					</a>
          					<!-- 파일을 수정할지 말지 결정하는 버튼 -->
          					<input type="button" id="frmfmodify" name="frmfmodify" value="파일 수정" onclick="fnFileChange()"/>
          					<!-- 파일 수정 버튼을 누르면 활성화되는 input -->
          					<input style="font-family:'바탕체', Georgia, serif;font-size:14px;" type="file" id="frmfup" name="frmfup"/>
          					<!-- 파일을 삭제할지 말지 결정하는 버튼 -->
          					<input type="button" id="frmfdel" name="frmfdel" value="파일 삭제" onclick="fnFileDel()"/>
          					<!-- 파일 삭제 버튼을 누르면 보이는 부분 -->
          					<div id="frmfnone" name="frmfnone">첨부 파일 없음</div>
          				</td>
          			</c:when>
          			<c:otherwise>
          				<td colspan="7">
          					<div id="frmfno" name="frmfno">
          						첨부 파일 없음
          						<!-- 파일을 추가할지 말지 결정하는 버튼 -->
          						<input type="button" id="frmadd" name="frmadd" value="파일 추가" onclick="fnFileAdd()"/>
          					</div>
          					<!-- 파일 추가 버튼을 누르면 활성화되는 input -->
          					<input style="font-family:'바탕체', Georgia, serif;font-size:14px;" type="file" id="frmfadd" name="frmfadd" />
          				</td>
          			</c:otherwise>
          		</c:choose>
          </tr>
        </tbody>
      </table>
      <div class="mybutton">
        <input id="frmUpdate" name="frmUpdate" type="button" onclick="fnSave()" value="저장" />
        <input id="frmCancel" name="frmCancel" type="button" onclick="fnGoBoardList()" value="수정 취소" />
      </div>
    </form>
  </body>
</html>