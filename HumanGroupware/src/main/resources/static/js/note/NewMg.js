$(document)
.ready(()=>{
/*	getUserName()*/
})
.on("click","#cancelButton",()=>{
	document.location="/receive"
})
.on("click","#sendButton",()=>{
	sendMessage()
})
.on("click","#serchUserButton",()=>{
	serchUserSelect()
})
.on("click","#okbutton",()=>{
	  $('#userBox').modal('hide');
})

.on("change","#userSelect",function(){	
	let str = $(this).children("option:selected").val();
	let ar=str.split(".")
	$("#mg_Receiver").val(ar[0]);
	$("#userId").val(ar[1])
})


//---------------------------------------------함수----------------------------------------------------//
function openUserBox() {
      $('#userBox').modal('show');
      
}
/*function getUserName(){
	$.ajax({url:"/userName",
			type:"post",
			dataType:"text",
			data:{user:$("#userNo").val()},
			success:(data)=>{	
					$("#mg_Writer").val(data)
			}	
	})
}*/
function sendMessage(){
	$.ajax({url:"/sendMg",
			type:"post",
			dataType:"text",
			data:{Writer:$("#userNo").val(),
				  Content:$("#mg_Content").val(),
				  Receiver:$("#userId").val()},
			beforeSend:()=>{
				if($("#mg_receiver").val()=="" || $("#mg_Content").val()==""){
					alert("메시지를 작성해주세요")
					return false;
				}
			},
			success:(data)=>{
				if(data=="ok"){
					document.location="/receive"					
				}else{
					console.log("실패")
				}
			}
	})			
}
function serchUserSelect(){
	$.ajax({url:"/serchUser",
			dataType:"json",
			type:"post",
		success: (data) => {
			if (data != "") {
					$("#userSelect").empty()
					for(let i = 0; i<data.length; i++){
						let box = data[i]
						let op=""
						if(box["name"]!=$("#mg_Writer").val()){
							op+= "<option value="+box["name"]+"."+box["no"]+">"
							op+=box["name"]+"/"+box["depart"]+"</option>"	
						}
						$("#userSelect").append(op)
					}
					
				}else{
					alert("data is null")
				}						
			}
	})
}