<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ajax 통신을 위한 json 설정 -->
<%@ page import="org.json.simple.JSONObject"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Board Sign In</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
    	$(document).ready(function(){
    		if('${frmFlag}'=="DONE"){
    			alert("성공적으로 가입되었습니다.");
    			$('#frmSignin').attr({action : "/board/boardLogin.do"}).submit();
    		}
    		
    		/* 아이디는 한글 또는 특수문자가 포함되면 삭제한다. */
    		$("#frmid").bind("keyup", function(){ 
    			re = /[가-힣|~!@\#$%^&*\()\-=+_{}']/gi; 
    			var temp=$("#frmid").val(); 
    			if(re.test(temp)){ 
    				$("#frmid").val(temp.replace(re,"")); } 
    		}); 
    		
    		/* 이름은 영어, 특수문자가 포함되면 삭제한다. */
    		$("#frmname").bind("keyup", function(){ 
    			re = /[A-Z|a-z|0-9|~!@\#$%^&*\()\-=+_{}']/gi; 
    			var temp=$("#frmname").val(); 
    			if(re.test(temp)){ 
    				$("#frmname").val(temp.replace(re,"")); } 
    		}); 
    		
    		/* 비밀번호는 한글, 특수문자가 포함되면 삭제한다.  */
    		$("#frmpw").bind("keyup", function(){ 
    			re = /[가-힣|~!@\#$%^&*\()\-=+_{}']/gi; 
    			var temp=$("#frmpw").val(); 
    			if(re.test(temp)){ 
    				$("#frmpw").val(temp.replace(re,"")); } 
    		});    		
    	});
    	
    	/* 로그인 화면으로 돌아간다. */
    	function fnGoBack(){
    		$('#frmFlag').val("");
    		$('#frmSignin').attr({action: "/board/boardLogin.do"}).submit();
    	}
    
    	/* 아이디 중복을 체크한다. */
    	function fnCheckID(){
    		
			if( $('#frmid').val()=="" ){
				alert("ID를 입력해 주세요.")
				$('#frmFlag').val("");
				return false;
			}else if( $('#frmid').val().match(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g) ){
    			alert("ID는 영어 또는 숫자로 만들 수 있습니다.")
    			$("#frmid").val(""); 
    			$('#frmFlag').val("");
    			return false;
    		}
			/* 아이디 체크할 때, 기본 리턴값은 false다. */
			var rtn = false;
    		$.ajax({
    			type: "POST",
    			url: "/board/boardSignCheck.do",
    			timeout: 1000,
    			data: "checkid=" + $('#frmid').val(),
    			dataType: "json", 
    			async: false, 
    			success: function(msg){
    				/* msg가 아니라 다른 이름으로 지정해도 상관 없다. */
    				if( msg.jResult=="CHECK OK"){
    					/* jResult는 컨트롤러에서 json.put()이로 지정한 key다. */
    					/* jResult라는 key의 value가 CHECK OK면 true를 리턴한다. */
    					alert("사용할 수 있는 ID입니다.");
    					$('#frmFlag').val("SAVE");
    					rtn = true;
    				}else{
    					alert("이미 사용 중인 ID입니다.");
    					$('#frmFlag').val("");
    					$("#frmid").val(""); 
    				}
    			}, error: function(e){
    				alert("SignCheckID Ajax Error : "+e);
    			}
    		});
    		/* 오로지 CHECK OK일 때만 true를 리턴한다. */
			return rtn;
    	}
    	
    	/* 이름 중복을 체크한다. */ 
    	function fnCheckName(){
			if( $('#frmname').val()=="" ){
				alert("이름을 입력해 주세요.")
				$('#frmFlag').val("");
				return false;
			}else if( !$('#frmname').val().match(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g) ){
    			alert("이름은 한글로만 입력할 수 있습니다.")
    			$('#frmFlag').val("");
    			$("#frmname").val(""); 
    			return false;
    		}
			/* 이름을 체크할 때, 기본 리턴값은 false다. */
			var ret = false;
			$.ajax({
				type: "POST"
				, url: "/board/boardSignCheck.do"
				/* 컨트롤러에 넘겨줄 값 */
				, data: "checkname="+ $('#frmname').val()
				, timeout: 1000
				, dataType: "json"
				, async: false
				, success: function(msg){
					if( msg.jResult=="CHECK OK"){
						alert("사용할 수 있는 이름입니다.");
						$('#frmFlag').val("SAVE");
						ret = true;
					}else{
						alert("이미 사용 중인 이름입니다.");
    					$("#frmname").val(""); 
    					$('#frmFlag').val("");
    					return false;
					}
				}, error: function(e){
					console.log("SignCheckName Ajax Error : "+e);
				}
			});
			return ret;
    	}
    	
    	/* 비밀번호를 체크한다. */
    	function fnCheckPw(){
			if( $('#frmpw').val()=="" ){
				alert("비밀번호를 입력해 주세요.")
				$('#frmFlag').val("");
				return false;
			}else if( !$('#frmpw').val().match(/[A-Z|a-z|0-9]/g) ){
    			alert("비밀번호는 영어 또는 숫자로만 입력할 수 있습니다.")
    			$('#frmFlag').val("");
    			$('#frmpw').val("");
    			return false;
    		}else{
    			$('#frmFlag').val("SAVE");
    			return true;
    		}
    	}
    	
    	/* 가입하기를 클릭하면 호출되는 함수 */
    	function fnSignin(){
    		if( !fnCheckID() ) return;
    		if( !fnCheckPw() ) return;
    		if( !fnCheckName()) return;

			if( $('#frmFlag').val()=="SAVE" ){
				$('#frmSignin').attr({action : "/board/boardSignin.do"}).submit();
			}
			return false;
    	}
    
    </script>
  </head>
  <body>
    <h2 style="padding:0.1em 1em;">회원 가입</h2>
    <form id="frmSignin" name="frmSignin" method="post">
      <input type="hidden" id="frmFlag" name="frmFlag" />
    
    <table id="tsign" border="1px dashed #EEEEEE">
      <thead>
        <tr>
          <td colspan="8" style="color:Orange;font-size:20px;background-color:LightYellow;font-family:'Lucida Console';">Board의 회원 가입을 환영합니다!</td> 
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>아이디(ID)</th>
          <td><input type="text" id="frmid" name="frmid" onkeydown="if(event.keyCode==13) fnCheckID();" style="height:auto;width:90%;color:#010101"/></td>
          <td><input type="button" id="btnid" name="btnid" onclick="fnCheckID();" value="ID중복확인"/></td>
        </tr>
        <tr>
          <th>비밀번호</th>
          <td colspan="2"><input type="text" id="frmpw" name="frmpw" onkeydown="if(event.keyCode==13) fnCheckPw();" style="height:auto;width:90%;color:#010101"/></td>
        </tr>
        <tr>
          <th>이름(사용자명)</th>
          <td><input type="text" id="frmname" name="frmname" onkeydown="if(event.keyCode==13) fnCheckName();" style="height:auto;width:90%;color:#010101"/></td>
          <td><input type="button" id="btnname" name="btnname" onclick="fnCheckName();" value="이름중복확인"/></td>
        </tr>
        <tr>
          <th>E-mail</th>
          <td colspan="2"><input type="text" id="frmemail" name="frmemail" style="height:auto;width:90%;color:#010101"/></td>
        </tr>
        <tr>
          <th>전화번호</th>
          <td colspan="2"><input type="text" id="frmtel" name="frmtel" style="height:auto;width:90%;color:#010101"/></td>
        </tr>
      </tbody>
    </table>
    
    <div class="mybutton">
      <input type="button" id="goSave" name="goSave" onclick="fnSignin()" value="가입하기" /> 
      <input type="button" id="goBack" name="goBack" onclick="fnGoBack()" value="가입취소" />
    </div>
    </form>
  </body>
</html>