$(document)
.ready(()=>{
	selectReceiveMessage(1,5)
})
.on("click","#deleteMessage",()=>{	
	deleteReceiveMessage() 
})
.on("change",".selectBox",function(){
	selectReceiveMessage(1,$(this).find("option:selected").text())
})
.on("click","#receiveMessageList tr:gt(0) td:nth-child(4)",function(){
	
	
	let senderId = $(this).parent("tr").find("input[id=senderId]").val()
	let receiverId = $("#userId").val();
	let noteNumber = $(this).parent("tr").find("input[name=juniorCheckBox]").val()
	console.log("보낸이 : "+senderId+"받는이 : "+receiverId+"노트 번호: "+noteNumber)
	
	$.ajax({url:"/updateRead",
			type:"post",
			dataType:"text",
			data:{noteNum:noteNumber,
				  noteRead:"yes"}
	})
	$(this).css("color","blue")
 	document.location = "/detailMg/"+senderId+"/"+receiverId+"/"+noteNumber+"/"+1
})

//-------------------------------------------함수------------------------------------------------//

function endPage(totalpage,amount){
	selectReceiveMessage(totalpage,amount)
}
function startPage(firstPage,amount){
	selectReceiveMessage(firstPage,amount)
}
function currentPage(page,amount){
		let pageNum = ($(page).text())
		selectReceiveMessage(pageNum,amount)
		if(pageNum<1){
			$("#privButton").addClass("disabled")
		}
}
function selectAll(selectAll){  	
	const checkboxes = document.getElementsByName("juniorCheckBox");
	checkboxes.forEach((checkbox) => {
 		checkbox.checked = selectAll.checked;
		})	
}
function deleteReceiveMessage(){
	let noteNumber="";
	console.log($("input[name='juniorCheckBox']:checked").length)
	for(let i=0; i<$("input[name='juniorCheckBox']:checked").length; i++){
		noteNumber += $("input[name='juniorCheckBox']:checked:eq("+i+")").val()+","
	}	
	 $.ajax({url:"/deleteReceiveMessage",
		type:"post",
		dataType:"text",
		data:{noteid:noteNumber},
		 success:()=>{
			document.location="/receive"
		}
	}) 
}
function makePageButton(pageNum,totalpage,amount){
	let startPage = Math.max(pageNum - 1 + 1,1) 
	let endPage = Math.min(pageNum + 3 - 1,totalpage)
	let pageButton="";
	if(totalpage!=0){
		pageButton += "<li id='privButton' class='page-item disabled' onclick=startPage("+startPage+","+amount+")><a class='page-link' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>"
	for(let i = startPage; i<=endPage; i++){
		if(pageNum===i){
			pageButton += "<li id='pageid"+i+"' class='page-item active' onclick='currentPage(this,"+amount+")'><a class='page-link'>"+i+"</a><li>"	
		}else{
			pageButton += "<li id='pageid"+i+"' class='page-item' onclick='currentPage(this,"+amount+")'><a class='page-link'>"+i+"</a><li>"	
		}
	}
		pageButton += "<li id='nextButton' class='page-item' onclick=endPage("+totalpage+","+amount+")><a class='page-link' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>"
	}
	$("#pageButtonBox").empty().append(pageButton)
	if(pageNum==totalpage){
		$("#nextButton").addClass("disabled")
	}
}
function selectReceiveMessage(pageNum,amount){
	$.ajax({url:"/selectReceiveMessage",
		type:"post",
		dataType:"json",
		data:{user:$("#userId").val(),
			  pageNum:pageNum,
			  amount:amount},
		success:(data)=>{
			if(data!=null){
				$("#receiveMessageList tr:gt(0)").remove()
				$("#pageButtonBox").empty()
				let totalpage=0
				for(let i=0; i<data.length; i++){
					let re = data[i]
					$("#totalMessage").text("total : "+re["total"])
					let read = re["noteread"]
					let tb = "<tr>"
						tb+= "<td><input type = checkbox name='juniorCheckBox' value="+re["noteNum"]+"></td>"
						tb+= "<td><input type = 'hidden' id='senderId' value="+re["senderId"]+"></td>"
						tb+="<td>"+re["sender"]+"</td>"
					
					if(read=="no"){
							tb+="<td><div>"+re["content"]+"</div></td>"	
					}else{
						tb+="<td style=color:blue><div>"+re["content"]+"</div></td>"
					}
					tb+="<td>"+re["senddate"]+"</td></tr>"
					$("#receiveMessageList").append(tb)
					totalpage = data[0]["totalPage"]
				}
				makePageButton(pageNum,totalpage,amount)
				$("#receiveMessageList tr td:nth-child(4) div").addClass("overflow");
			}
		}
	})
}