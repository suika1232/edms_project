<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="/resources/css/hwMypage.css">
<title>HWmypage</title>
</head>
<body>
	<div class="title">HumanGroupWare<br>Mypage!</div>
  	<div class="body">
    	<div class="container_1">
      	<div class="label">Name:</div>
      	<div class="input">
        	<input type="text" id="emp_name">
      	</div>
      	<div class="label">ID:</div>
      	<div class="input">
        	<input type="text" id="emp_id">
      	</div>
      	<div class="label">PW:</div>
      	<div class="input">
        	<input type="password" id="emp_password" placeholder="비밀번호 입력해주세요..." size="20">
      	</div>
      	<div id="hiddenPW"></div>
      	<div class="label">RE-PW:</div>
      	<div class="input">
        	<input type="password" id="emp_password2" placeholder="비밀번호를 재입력해주세요..." size="20">
        	<button id="Change">변경</button>
      	</div>
      	<div id="hiddenRE-PW"></div>
      	<div class="label">Birth:</div>
      	<div class="input">
        	<input type="text" id="birth">
      	</div>
      	<div class="label">Mobile:</div>
      	<div class="input">
        	<input type="text" id="mobile">
        	<button id="mobileInput">변경</button>
      	</div>
      	<div id="hiddenMobile"></div>
      	<div class="label">Email:</div>
      	<div class="input">
        	<input type="text" id="email">
      	</div>
      	<div class="label">Gender:</div>
      	<div class="input">
        	<input type="text" id="gender">
      	</div>
      	<div class="label">부서:</div>
      	<div class="input">
        	<input type="text" id="depart">
      	</div>
      	<div class="label">직급:</div>
      	<div class="input">
        	<input type="text" id="position">
      	</div>
    	</div>
    	<div class="container_2">
      		<div class="label">본인 사진:</div>
      		<div class="input">
        		<div class="getImg" id="getImg"></div>
        		<img id="showImg">
      		</div>
      		<div class="label">이미지:</div>
      		<div class="input">
        		<input type="file" id="img">
      		</div>
      		<div class="label">우편번호:</div>
      		<div class="input">
        		<input class="form-control" placeholder="우편번호" name="addr1" id="addr1" type="text" readonly="readonly">
        		<button type="button" class="btn btn-default" onclick="execPostCode();" id="addressBtn">
        		<i class="fa fa-search"></i> 우편번호 찾기</button>
      		</div>
      		<div class="label"></div>
      		<div class="input">
        		<input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="addr2" id="addr2" type="text"
          		readonly="readonly">
      		</div>
      		<div class="label"></div>
      		<div class="input">
        		<input class="form-control" placeholder="상세주소" name="addr3" id="addr3" type="text">
        		<button id="save">저장</button>
      		</div>
    	</div>
  	</div>
  	<div class="btn">
    	<button id="ok">완료</button>
    	<button id="x">취소</button>
    	<button id="delete">탈퇴</button>
  	</div>
</body>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
$(document)
.ready(function(){
	Mypage_List();
	$('#img').click();
	setInterval(createStar, 1000);
})
.on('click','#ok',function(){
	let result = confirm("변경사항은 변경/저장 버튼을 따로 눌러야 저장됩니다.메인으로 돌아가시겠습니까?");
	if(result){
		alert("메인으로 돌아갑니다!");
		window.location.href = '/temp/temp_main';
	} else {
		alert("다시 수정하세요");
		window.location.href = '/employee/mypage';
	}
})
// 취소 버튼을 누르면 Yes 누르면 메인으로 돌아가고 No 누르면 마이페이지로 다시 정보수정 할 수 있게됩니다.
.on('click','#x', function(){
	let result = confirm("주의: 변경사항이 저장되지 않았습니다!");
	if(result){
		alert("메인으로 돌아갑니다");
		window.location.href = '/temp/temp_main';
	}else {
		alert("다시 수정해주세요!")
		window.location.href = '/employee/mypage';
	}
})
// 마이페이지에서 비밀번호 변경 코드입니다.
.on('click','#Change', function(){
	if($('#emp_password').val()=="" || $('#emp_password2').val() ==""){
		alert('비밀번호를 입력해주세요!')
		return false;
	}
	$.ajax({
		url:'/Mypage_pw',
		data: { id : $('#emp_id').val(),
				password : $('#emp_password').val(),
				password2 : $('#emp_password2').val()},
		type:'post',
		dataType:'text',
		success : function(data){
			if(data=="ok"){
				alert("비밀번호가 변경되었습니다.");
			}else if(data=="checkfalse") {
				alert("비밀번호가 서로 다릅니다!");
			}else {
				alert("실패하였습니다");
			}
		}
	})
})
// 마이페이지에서 비밀번호가 서로 일치하는지 확인하는 코드입니다.
.on('keyup','#emp_password2',function(){
	if($('#emp_password2').val() == $('#emp_password').val()){
		$('#hiddenRE-PW').val('ok');
		$('#hiddenRE-PW').html('<a style="color:blue;">비밀번호가 일치합니다!</a>');
	} else{
		$('#hiddenRE-PW').val('ok');
		$('#hiddenRE-PW').html('<a style="color:red;">비밀번호가 일치하지않습니다!</a>');
	}
})
// 마이페이지에서 비밀번호가 8~14글자가 있는지 확인하고 영문 숫자 섞어 사용하는 코드입니다.
.on('keyup','#emp_password',function(){
	let pdc = /^[a-zA-Z0-9]{8,14}$/;
	let passcode = $('#emp_password').val();
	
	if(pdc.test(passcode) && !/\s/.test(passcode)){
		$('#hiddenPW').val('ok');
		$('#hiddenPW').html('<a style="color:blue;">사용가능한 비밀번호 입니다!</a>');
	} else if(passcode.length < 8){
		$('#hiddenPW').val('fail');
		$('#hiddenPW').html('<a style="color:red;">영문과 숫자를 혼합하여 8~14자리 이하의 비밀번호를 입력해주세요</a>');
	} else if(/\s/.test(passcode)){
		$('#hiddenPW').val('fail');
		$('#hiddenPW').html('<a style="color:red;">공백을 넣을 수 없습니다!</a>');
	} else {
		$('#hiddenPW').val('fail');
		$('#hiddenPW').html('<a style="color:blue;">사용불가한 비밀번호입니다!</a>');
	}	
})
// 마이페이지에서 모바일 번호를 변경하는 코드입니다.
.on('click','#mobileInput',function(){
	if($('#mobile').val()==""){
		alert('모바일 번호를 넣어주세요!');
		return false;
	}
	$.ajax({
		url:'/Mypage_mobile',
		data:{id: $('#emp_id').val(),
			  mobile: $('#mobile').val()},
		dataType:'text',
		type:'post',
		success:function(data){
			if(data=='ok'){
				alert('모바일 번호가 변경되었습니다');
			} else {
				alert('실패');
			}
		}
	})
})
// 마이페이지에서 mobile 번호를 숫자만 입력 받을 수 있게 만든 코드입니다. 
.on('keyup','#mobile',function(){
	this.value = this.value.replace(/[^0-9]/g, '');
})
// 마이페이지에서 mobile 번호가 11개만 들어가게하는 코드입니다.
.on('keyup','#mobile',function(){
	let mdc = /^[0-9]{11}$/;
	let mobile = $('#mobile').val();
	
	if(mdc.test(mobile) &&  !/\s/.test(mobile)){
		$('#hiddenMobile').val('ok');
		$('#hiddenMobile').html('<a style="color:blue;">유효한 번호입니다!</a>');
	} else if(mobile.length <11){
		$('#hiddenMobile').val('fail');
		$('#hiddenMobile').html('<a style="color:red;">번호는 (-) 없이 12글자 이내로 입력하세요!</a>');
	} else if(/\s/.test(mobile)){
		$('#hiddenMobile').val('fail');
		$('#hiddenMobile').html('<a style="color:red;">공백 없이 입력해주세요!</a>');
	} else {
		$('#hiddenMobile').val('fail');
		$('#hiddenMobile').html('<a style="color:red;">유효하지 않은 번호입니다 ㅜㅜ</a>');
	}
})
//마이페이지에서 address 주소를 넣는 코드입니다.
.on('click','#save',function(){
	let addr1 = $('#addr1').val();
	let addr2 = $('#addr2').val();
	let addr3 = $('#addr3').val();
	
	if(addr1 == "" || addr2 == "" || addr3 == ""){
		alert("빈 공간이 없이 입력해주세요");
		return false;
	}
	let address = addr1+addr2+" "+addr3
	$.ajax({
		url:'/Mypage_address',
		data:{ id : $('#emp_id').val(),
			   address : address},
		dataType : 'text',
		type : 'post',
		success : function(data){
			if(data == 'ok'){
				alert("주소가 저장됐습니다");
			} else {
				alert("실패하였습니다");
			}
		}
	})
})
//마이페이지에서 회원 삭제하는 코드입니다. 
.on('click', '#delete', function() {
  	let result = confirm("정말로 탈퇴하시겠습니까?");
  	if (result) {
    	$.ajax({
      	url: '/Mypage_emp_delete',
      	type: 'post',
      	data: { emp_id: $('#emp_id').val() },
      	dataType: 'text',
      	success: function(data) {
        	if (data === 'ok') {
          		alert("탈퇴되었습니다.");
          		window.location.href = '/temp/temp_main';
        	} else {
          		alert("탈퇴 실패");
        	}
      	},
      	error: function(xhr, status, error) {
        	alert("서버 에러: " + error);
      		}
    	})
  	}else {
    	alert("탈퇴가 취소되었습니다.");
    	window.location.href = '/employee/mypage';
  	}
})
//마이페이지에서 이미지를 넣는 코드입니다.
$('#img').change(function() {
    let file = $(this).prop('files')[0];
    if (file && file.type.includes('image')) {
        let reader = new FileReader();
        reader.onload = function(e) {
            let imgSrc = e.target.result;
            let imgElement = $('<img>').attr('src', imgSrc);
            
            $('#getImg').empty().append(imgElement);

            let formData = new FormData();
            formData.append("img", file);
            formData.append("id", $('#emp_id').val());
            
            $.ajax({
                url: "/Mypage_img",
                type: "post",
                contentType: false,
                processData: false,
                data: formData,
                success: function(data) {
                    console.log(data);
                    // 현재 넣은 이미지 표시
                    $('#showImg').attr('src', imgSrc);
                    $('#getImg img').not('#showImg').remove(); // 기존 이미지 삭제
                }
            })
        }
        reader.readAsDataURL(file);
    }
})
//마이페이지에서 우편번호 찾는 코드입니다.
function execPostCode() {
	new daum.Postcode({
         oncomplete: function(data) {
       	 let addr1 = data.zonecode; // 우편번호 변수
         let addr2 = data.roadAddress; // 도로명 주소 변수
         let addr3 = ''; // 상세 주소 변수 (비워둠)
         // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
         // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
         // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
         let fullRoadAddr = data.roadAddress; // 도로명 주소 변수
         let extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
         // 법정동명이 있을 경우 추가한다. (법정리는 제외)
         // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
         if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
             extraRoadAddr += data.bname;
         }
         // 건물명이 있고, 공동주택일 경우 추가한다.
         if(data.buildingName !== '' && data.apartment === 'Y'){
             extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
        }
         // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
         if(extraRoadAddr !== ''){
             extraRoadAddr = ' (' + extraRoadAddr + ')';
         }
         // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
         if(fullRoadAddr !== ''){
             fullRoadAddr += extraRoadAddr;
         }
 
         // 우편번호와 주소 정보를 해당 필드에 넣는다.
         $("[name=addr1]").val(addr1);
         $("[name=addr2]").val(addr2);
         $("[name=addr3]").val(addr3);
                
		}
    }).open()
}
//마이페이지에 필요한 입력값을 넣는 코드이며, 변경을 못하게 막는 코드입니다.
function Mypage_List() {
  $.ajax({
    url: '/Mypage_list',
    type: 'POST',
    dataType: 'json',
    data: { emp_id: $('#emp_id').val() },
    success: function(data) {
    	
      if (data && data.length > 0) {
        let empData = data[0];

        // 입력값 못넣게 하는 코드
        $('#emp_name').prop('disabled', true).addClass('disabled');
        $('#emp_id').prop('disabled', true).addClass('disabled');
        $('#birth').prop('disabled', true).addClass('disabled');
        $('#email').prop('disabled', true).addClass('disabled');
        $('#gender').prop('disabled', true).addClass('disabled');
        $('#depart').prop('disabled', true).addClass('disabled');
        $('#position').prop('disabled', true).addClass('disabled');

        $('#emp_name').val(empData.emp_name);
        $('#emp_id').val(empData.emp_id);
        $('#emp_password').val(empData.emp_password);
        $('#birth').val(empData.emp_birth);
        $('#mobile').val(empData.emp_mobile);
        $('#email').val(empData.emp_email).prop('disabled', true);
        $('#gender').val(empData.emp_gender).prop('disabled', true);
        $('#depart').val(empData.emp_depart).prop('disabled', true);
        $('#position').val(empData.emp_position).prop('disabled', true);

        let imgName = empData.emp_img.split('/').pop();
        $('#getImg').text(imgName);

        $('#showImg').attr('src', '/img/' + imgName);
        $('#getImg img').not('#showImg').remove();

        let address = empData.emp_address;
        let addrArray = address.match(/(\d{5})(.*)\s+(.*)/); // 우편번호, 도로명주소로 나눔
        let addr1 = addrArray[1];
        let addr2 = addrArray[2].trim(); // 도로명주소에서 앞뒤 공백 제거
        let addr3 = addrArray[3];

        $('#addr1').val(addr1);
        $('#addr2').val(addr2);
        $('#addr3').val(addr3);
      }
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log('Error: ' + textStatus);
      console.log('Error Detail:', errorThrown);
    }
  });
}
// 별이 반짝이게 하는 코드입니다.
function createStar() {
	  const star = $('<div class="star"></div>');
	  const screenWidth = $(window).width();
	  const screenHeight = $(window).height();
	  const size = Math.floor(Math.random() * 10) + 5; // 랜덤한 크기 설정
	  const posX = Math.random() * (screenWidth - size);
	  const posY = Math.random() * (screenHeight - size);

	  // 랜덤한 RGB 색상 생성
	  const red = Math.floor(Math.random() * 256);
	  const green = Math.floor(Math.random() * 256);
	  const blue = Math.floor(Math.random() * 256);
	  const color = `rgb(${red}, ${green}, ${blue})`;

	  star.css({
	    width: size + 'px',
	    height: size + 'px',
	    top: posY + 'px',
	    left: posX + 'px',
	    background: color
	  });
	  $('body').append(star);

	  setTimeout(function() {
	    star.fadeOut(500, function() {
	      star.remove();
	    });
	  }, 1000); // 2초 후에 별이 사라짐
	}

</script>
</html>