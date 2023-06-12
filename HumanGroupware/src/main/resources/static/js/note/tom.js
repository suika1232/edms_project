$(document)
.ready(()=>{
	getSeDel(1, 5);
	getReDel(1, 5);
})
.on("click","#se_recover",function(){
	let noteNum="";
	for(let i=0; i<$("input[type=checkbox]:checked").length; i++){
			noteNum+=$("input[name=juniorCheckBox]:checked:eq("+i+")").val()+","
	}
	noteNum=noteNum.replace("undefined","")
	$.ajax({url:"/recover_sedel",
			type:"post",
			dataType:"text",
			data:{noteNum : noteNum},
			beforeSend:function(){
				console.log("복구할 번호 "+noteNum)
			},
			success:function(){
				document.location="/send"
			},
	})
})
.on("click","#re_recover",function(){
	let noteNum = "";
	for(let i=0; i<$("input[type=checkbox]:checked").length; i++){
		noteNum+=$("input[name=juniorCheckBox2]:checked:eq("+i+")").val()+","
	}
	noteNum=noteNum.replace("undefined","")
	$.ajax({url:"/recover_redel",
			type:"post",
			dataType:"text",
			data:{noteNum : noteNum},
			beforeSend:function(){
				console.log(noteNum)
			},
			success:function(){
				document.location="/receive"
			},
	})
})
.on("click","#se_hardDelete",function(){
	let noteNum="";
	for(let i=0; i<$("input[type=checkbox]:checked").length; i++){
			noteNum+=($("input[name=juniorCheckBox]:checked:eq("+i+")").val())+","
	}
	noteNum=noteNum.replace("undefined","")
	$.ajax({url:"/update_sedel",
			type:"post",
			dataType:"text",
			data:{noteNum : noteNum},
			beforeSend:()=>{
				console.log("삭제될 메시지 번호: "+noteNum)
			},
			success:()=>{
				document.location="/tom"
			}
	})
})
.on("click","#re_hardDelete",function(){
	let noteNum="";
	console.log($("input[type=checkbox]:checked").length)
	for(let i=0; i<$("input[type=checkbox]:checked").length; i++){
			noteNum+=($("input[name=juniorCheckBox2]:checked:eq("+i+")").val())+","
	}
	noteNum=noteNum.replace("undefined","")
	$.ajax({url:"/update_redel",
			type:"post",
			dataType:"text",
			data:{noteNum : noteNum},
			beforeSend:()=>{
				console.log("삭제될 메시지 번호: "+noteNum)
			},
			success:()=>{
				document.location="/tom"
			}
	})
})
.on("click","#setableBox tr td:nth-child(3) div",function(){
	let receiverID =$(this).parent("td").parent("tr").find("td:nth-child(2)").attr("id")
	let senderID= $("#userId").val()
	let noteNumber= $(this).parent("td").parent("tr").find("input[type=checkbox]").val()
	document.location = "/detailMg/"+senderID+"/"+receiverID+"/"+noteNumber+"/"+3 
})
.on("click","#RetableBox tr td:nth-child(3) div",function(){
	let senderID = $(this).parent("td").parent("tr").find("td:nth-child(2)").attr("id")
	let receiverID=$("#userId").val()
	let noteNumber= $(this).parent("td").parent("tr").find("input[type=checkbox]").val()
	document.location = "/detailMg/"+senderID+"/"+receiverID+"/"+noteNumber+"/"+4 
})

function selectAll(selectAll){  	
	const checkboxes = document.getElementsByName("juniorCheckBox");
	checkboxes.forEach((checkbox) => {
 		checkbox.checked = selectAll.checked;
		})	
}
function selectAll2(selectAll){  	
	const checkboxes = document.getElementsByName("juniorCheckBox2");
	checkboxes.forEach((checkbox) => {
 		checkbox.checked = selectAll.checked;
		})	
}
function ReceiveFirstPage(firstPage, amount) {
	getReDel(firstPage, amount);
}

function ReceiveFinalPage(totalPage, amount, pageNum) {
	if (pageNum == totalPage) {
		return false;
	} else {
		getReDel(totalPage, amount);
	}
}
function ReceiveCurrentPage(page, amount) {
	let pageNum = $(page).text();
	getReDel(pageNum, amount);
	if (pageNum > 1) {
		$("#RePrivButton").removeClass("disabled");
	}
}
function getReDel(pageNum, amount) {
	$.ajax({
		url: "/getRedel",
		type: "post",
		dataType: "json",
		data: {
			userId: $("#userId").val(),
			pageNum: pageNum,
			amount: amount
		},
		success: function(data) {
			let totalPage=0
			let amount=0
			$("#Retable tr:gt(0)").remove();
			for (let i = 0; i < data.length; i++) {
				let li = data[i];
				let tb = "<tr>";
				tb += "<td><input type='checkbox' value = "+li["noteId"]+" name='juniorCheckBox2'></td>"
				tb += "<td id="+li["senderID"]+">" + li["sender"] + "</td>";
				tb += "<td><div>" + li["content"] + "</div></td>";
				tb += "<td>" + li["receivedate"] + "</td></tr>";
				$("#Retable").append(tb);
				totalPage = data[0]["totalPage"];
			 	amount = data[0]["amount"];
			}
			ReceiveDivset(pageNum, amount, totalPage);
			$("#Retable tr td:nth-child(3) div").addClass("overflow");
		}
	});
}
function ReceiveDivset(pageNum, amount, totalPage) {
	let acc = pageNum % amount;
	let firstPage = Math.max(pageNum - acc + 1, 1);
	let lastPage = Math.min(firstPage - acc + amount, totalPage);
	let pagediv ="";
	if(pagediv!=0){
		pagediv+="<li id='RePrivButton' class='page-item disabled' onclick='ReceiveFirstPage(" + firstPage + "," + amount + ")'><a class='page-link' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
	for (let i = firstPage; i <= lastPage; i++) {
		if (pageNum == i) {
			pagediv += "<li id='RePage-id" + i + "' class='page-item active' onclick='ReceiveCurrentPage(this)'><a class='page-link' href='#'>" + i + "</a></li>";
		} else {
			pagediv += "<li id='RePage-id" + i + "' class='page-item' onclick='ReceiveCurrentPage(this," + amount + ")'><a class='page-link' href='#'>" + i + "</a></li>";		
		}
	}
	pagediv += "<li id='ReNextButton' class='page-item' onclick='ReceiveFinalPage(" + totalPage + "," + amount + "," + pageNum + ")'><a class='page-link' href='#' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
	}
	$("#ReceivePageBox").empty().append(pagediv);
	$("#RePage-id" + pageNum).addClass("active");
	if (pageNum == totalPage) {
		$("#ReNextButton").addClass("disabled");
	}
}
function SendFirstPage(firstPage, amount) {
	getSeDel(firstPage, amount);
}

function SendCurrentPage(page, amount) {
	let pageNum = $(page).text();
	console.log("pageNum : "+pageNum)
	getSeDel(pageNum, amount);
	if (pageNum < 1) {
		$("#SePrivButton").addClass("disabled");
	}
}

function SendFinalPage(totalPage, amount, pageNum) {
	if (pageNum == totalPage) {
		return false;
	} else {
		getSeDel(totalPage, amount);
	}
}
function getSeDel(pageNum, amount) {
	$.ajax({
		url: "/getSedel",
		type: "post",
		dataType: "json",
		data: {
			userId: $("#userId").val(),
			pageNum: pageNum,
			amount: amount
		},
		success:function(data) {
			let totalPage=0
			let amount=0
			$("#setable tr:gt(0)").remove();
			for (let i = 0; i < data.length; i++) {
				let li = data[i];
				let tb = "<tr>";
				tb += "<td><input type='checkbox' value = "+li["noteId"]+" name='juniorCheckBox'></td>"
				tb += "<td id="+li["receiverID"]+">" + li["receiver"] + "</td>";
				tb += "<td><div>" + li["content"] + "</div></td>";
				tb += "<td>" + li["senddate"] + "</td></tr>";
				$("#setable").append(tb);
				totalPage= data[0]["totalPage"];
				amount= data[0]["amount"];
			}
			SendDivSet(pageNum,amount,totalPage)
			$("#setable tr td:nth-child(3) div").addClass("overflow")
		}
	});
}
function SendDivSet(pageNum, amount, totalPage) {
	
	let firstPage = Math.max(pageNum-1+1,1);
	let lastPage = Math.min(firstPage +3 - 1, totalPage);
	let pagediv="";
	if(totalPage!=0){
		 pagediv = "<li id='SePrivButton' class='page-item disabled' onclick='SendFirstPage(" + firstPage + "," + amount + ")'><a class='page-link' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
	for (let i = firstPage; i <= lastPage; i++) {
		if (pageNum == i) {
			pagediv += "<li id='SePage-id" + i + "' class='page-item active' onclick='SendCurrentPage(this,"+amount+")'><a class='page-link' href='#'>" + i + "</a></li>";
		} else {
			pagediv += "<li id='SePage-id" + i + "' class='page-item' onclick='SendCurrentPage(this," + amount + ")'><a class='page-link' href='#'>" + i + "</a></li>";
		}
	}
	pagediv += "<li id='SeNextButton' class='page-item' onclick='SendFinalPage(" + totalPage + "," + amount + "," + pageNum + ")'><a class='page-link' href='#' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
	
	}
	$("#SendPageBox").empty().append(pagediv);
	$("#SePage-id" + pageNum).addClass("active");
	if (pageNum == totalPage) {
		$("#SeNextButton").addClass("disabled");
	}
}