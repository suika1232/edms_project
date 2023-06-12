let value=0;
$(document)
.ready(()=>{
	value =0;
 	if($("#val").val()==1){
 		value = 1
 	}else if($("#val").val()==2){
 		value = 2  
 	}else if($("#val").val()==3){
		value = 3 
	 }else{
		value = 4 
	 }
})
.on("click","#returnPage",()=>{
	if(value==1){
		returnReceive()
 	}else if(value==2){
 		returnSend()
 	}else if(value==3||value==4){
		returnTom()	 
	 }
})

//-------------------------------------------------------함수-----------------------------------------//

function returnSend(){
	document.location = "/send"
}
function returnReceive(){
	document.location = "/receive"
}
function returnTom(){
	document.location = "/tom"
}
function reply(){
	let senderID=$("#sender_id").val();
	document.location = "/New/"+senderID 
}