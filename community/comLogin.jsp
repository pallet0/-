<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Board Log In</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
		$(document).ready(function(){
			/* frmScc는 로그인의 성공 여부를 판별한다. */
			if( '${frmScc}'=="SUCCESS" ){
				alert("정상적으로 로그인되었습니다.");
				$('#frmLgn').attr({action : "/board/boardList.do"}).submit();
			}else if( '${frmScc}'=="WRONG ID" ){
				alert("잘못된 ID입니다.");
				$('#frmScc').val("");
				$('#frmLgn').attr({action : "/board/boardLogin.do"}).submit();
			}else if( '${frmScc}'=="WRONG PW" ){
				alert("잘못된 비밀번호입니다.");
				$('#frmScc').val("");
				$('#frmLgn').attr({action : "/board/boardLogin.do"}).submit();
			}else if( '${frmScc}'=="INDEX" ){
				$('#frmScc').val("");
				$('#frmLgn').attr({action : "/board/index.jsp"}).submit();
			}else if( '${frmScc}'=="ERROR" ){
				alert("알 수 없는 오류입니다.");
			}
		});
    
		/* 인덱스 페이지로 간다. */
    	function fnGoIdx(){
    		$('#frmLgn').attr({action : "/board/index.jsp"}).submit();
    	}
    	
    	/* 아이디와 비밀번호를 받아 컨트롤러로 넘겨준다. */
    	function fnSave(){
    		if( $('#frmid').val()==null || $('#frmid').val()=="" ){
    			alert("ID를 입력해 주세요.");
    			return false;
    		}
    		if( $('#frmpw').val()==null || $('#frmpw').val()=="" ){
    			alert("비밀번호를 입력해 주세요.");
    			return false;
    		}
    		/* GO는 체크가 끝났으니 서브밋하라는 표시다. */
    		$('#frmScc').val("GO");
    		$('#frmLgn').attr({action : "/board/boardLogin.do"}).submit();
    	}
    	
    	/* 회원가입 페이지로 간다. */
		function fnGoSignin(){
			$('#frmLgn').attr({action : "/board/boardSignin.do"}).submit();		  
		}

    </script>
  </head>
  <body>
    <h2>사용자 로그인</h2>
    <h5 style="margin:1.5em;color:DarkBlue;">로그인 후 게시판 이용이 가능합니다.</h5>
	  <form id="frmLgn" name="frmLgn" method="post">
	  <input type="hidden" id="frmScc" name="frmScc" />
	    <table id="tlgn" border="1px dashed #EEEEEE">
	      <tr>
	        <th> I D : </th>
	        <!-- 엔터 키를 치면 fnSave()를 호출한다. -->
	        <td><input type="text" id="frmid" name="frmid" onkeydown="if(event.keyCode==13) fnSave();"/></td>
	      </tr>
	      <tr>
	        <th> password : </th>
	        <!-- input type은 password -->
	        <td><input type="password" id="frmpw" name="frmpw" onkeydown="if(event.keyCode==13) fnSave();"/></td>
	      </tr>
	    </table>
	    <input type="button" id="frmsave" name="frmsave" value="로그인" onclick="fnSave()" />
	    <input id="goSignin" name="goSignin" type="button" onclick="fnGoSignin()" value="회원가입" />
	    <input type="button" id="frmcancel" name="frmcancle" value="취소" onclick="fnGoIdx()" />	  
	  </form>
  </body>
</html>