$(document)
.ready(()=>{
	selectSendMessage(1,5);
})
.on("click","#deleteMessageButton",()=>{
	deleteMessage()
})
.on("change","#select",function(){
	
	amount = $(this).find("option:selected").text()
	
	selectSendMessage(1,amount)
})
.on("click","#sendMessageList tr:gt(0) td:nth-child(4)",function(){
	
	let senderID = $("#userId").val() 
	
	let receiverID = $(this).parent("tr").find("input[id=receiverId]").val()

	let noteNumber = $(this).parent("tr").find("input[type=checkbox]").val()
	
	console.log(senderID + receiverID + noteNumber);
		
 	document.location = "/detailMg/"+senderID+"/"+receiverID+"/"+noteNumber+"/"+2 
})

//-----------------------------------------------함수---------------------------------------------------//

function privPageButton(amount){
	selectSendMessage(1,amount);
}
function lastPageButton(totalPage,amount){
	selectSendMessage(totalPage,amount)
}
function currentPage(page,amount){
	selectSendMessage($(page).text(),amount);
	if($(page).text()>1){
		$("#privButton").removeClass("disabled")
	}
}
function selectAll(selectAll){  	
	const checkboxes = document.getElementsByName("juniorCheckBox");
	checkboxes.forEach((checkbox) => {
 		checkbox.checked = selectAll.checked;
		})	
}

function deleteMessage(){
	
	let noteNumber="";
	
	for(let i=0; i<$("input[name='juniorCheckBox']:checked").length; i++){

		noteNumber += $("input[name='juniorCheckBox']:checked:eq("+i+")").val()+","
	}	
	 $.ajax({url:"/deleteSendMessage",
		type:"post",
		dataType:"text",
		data:{noteid:noteNumber},
		 success:()=>{
			document.location="/send"
		}
	}) 
}

function makePageButton(pageNum,totalPage,amount){
		let startNum = Math.max(pageNum - 1, 1)
  		let endNum = Math.min(pageNum + 3-1, totalPage)
  		let	pageButton=""
  		if(totalPage!=0){
			pageButton+="<li id='privButton' class='page-item disabled' onclick=privPageButton("+amount+")><a class='page-link' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>"
  			 for (let i=startNum; i<=endNum; i++) {  				
  	    		if (i===pageNum) {  	    			
  	    			pageButton+="<li id='page-id" +i+"' class='page-item active' onclick='currentPage(this,"+amount+")'><a class='page-link'href='#'>"+i+"</a></li>"
  	   		 	} else {
  	     		 	pageButton+="<li id='page-id"+i+"' class='page-item' onclick='currentPage(this,"+amount+")'><a class='page-link' href='#'>"+i+"</a></li>";  	        		
  	    		}
  	  		}
  			pageButton +="<li id='nextButton' class='page-item' onclick=lastPageButton("+totalPage+","+amount+")><a class='page-link' href='#' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>"  
		  }
  		$("#pageButtonBox").empty().append(pageButton)
  		
		$("#page-id"+pageNum).addClass("active")
		
		if(pageNum==totalPage){
			$("#nextButton").addClass("disabled")
		}
}
function selectSendMessage(pageNum,amount){
	$.ajax({url:"/selectSendMessage",
			type:"post",
			dataType:"json",
			data:{userId:$("#userId").val(),
				  pageNum:pageNum,
				  amount:amount},
			success:(list)=>{
				
				$("#sendMessageList tr:gt(0)").remove()
				
				$("#pageButtonBox").empty()
				let totalPage=0
				for(let i=0; i<list.length; i++){
					let li = list[i]
					$("#totalMessage").text("total : "+li["total"])
					let tb = "<tr>"
						tb += "<td><input type='checkbox' name='juniorCheckBox' value="+li["noteNum"]+"></td><td></td>"
						tb += "<td><input type='hidden' id='receiverId' value="+li["receiverId"]+">"+li["receiver"]+"</td>"
						tb += "<td><div>"+li["content"]+"</div></td>"
						tb += "<td>"+li["senddate"]+"</td></tr>"
						
					$("#sendMessageList").append(tb)
					totalPage = list[0]["totalPage"]
				}
				
	
				$("#sendMessageList tr td:nth-child(4) div").addClass("overflow");
				
				makePageButton(pageNum,totalPage,amount)
			}
	})
}

