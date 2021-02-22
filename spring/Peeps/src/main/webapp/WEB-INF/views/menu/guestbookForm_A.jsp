
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="">

<head>

<title>방명록</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%@ include file="/WEB-INF/views/include/basicset.jsp"%>



</head>
<style>

.msg_wrap{
	background-color: #eef0ed;
	height: 270px;
	width: 850px;
	margin:20px auto;
}

.msg_wrap2{
	background-color: #eef0ed;
	height: auto;
	width: 850px;
	margin:20px auto;
}


.ginsert_wrap>ul>li {
	list-style-type: none;
	float: left;
	margin: 5px;
	margin-top: 30px;
}

.gimg {
    
	background-color: white;
	width: 70px;
	height: 70px;
	margin: 10px;
	border-radius: 50px;
}
.upgphoto, .upgid {
	float: left;
}

.msg_wrap2{
 padding: 20px;    
}

.writerboutton{
    float: right;
    margin-left: 10px;
}
.writerPhoto{
 
    width: 35px;
    height: 35px;
    margin: 0px;
    border-radius: 50px;
    
}


.gUpDate{
float: right;

//font-size: 20px; 
    
}
.upMsg{

    height: auto;
	width: 600px;
    margin: 0 auto;
    
}

.gUpPhoto{
    height: 400px;
	width: 400px;
   
}

.cmt{
   
	
	margin:10px auto;
    
}
.cmt_area{
    
}
#gCmtbtn{
    margin-bottom: 30px;
    
}
#hr2{
    color: black;
}

#sbmtbtn{
margin-top:30px;
}

.paging {
	text-align: center;
	margin-bottom: 100px;
}

.paging>span {
	padding: 5px 10px;
	border-radius: 4px;
	border-right: 1px solid #ccc;
	border-left: 1px solid #ccc;
	font-size: 1.2em;
}

.postidx {
	color: black;
}

.col-sm-4 {
	width: 383px;
}

.row {
	/* margin: auto;
	width: 1150px; */
}

.container {
	/* max-width: 100%; 
	height: auto; */
	width: 1150px;
}

.pageBtn:link {
	text-decoration: none;
	color: gray;
}
.pageBtn:visited {
	text-decoration: none;
	color: gray;
}
.pageBtn:active {
	text-decoration: none;
	color: gray;
}
.pageBtn:hover {
	text-decoration: none;
	color: gray;
}
.bnt3{
   background-color: aqua;
   color: black;
   border: 1px solid black;
   font-size: 10px;
   padding: 5px;
   
}
</style>


<body>

	<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	<!----------------------------------------------------------------------------------------->
	<div id="main_wrap">
		<%@ include file="/WEB-INF/views/include/user.jsp"%>
		<%@ include file="/WEB-INF/views/include/menu.jsp"%>
	</div>
	<!--=====================context======================-->
	<div class="changing" id="changing">

<div class="msg_wrap">
	<form id="insertGForm" enctype="multipart/form-data">
         <div class="ginsert_wrap">
            <!-- 방명록 입력 div -->
            <ul>
               <li><img
                  src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTAxMDVfNiAg%2FMDAxNjA5ODUyMjAyODkx.SGiMYE0GV5JhjH_FVZUCfOREl7yH6ipmytqZ6ynDP9gg.81AO4sM4kRPOR8_50gibNZ3YmoIsHIaAgbpTNkGCKGYg.JPEG.nbsupporter%2F%25B0%25AD%25BE%25C6%25C1%25F6_2.jpg&type=a340"
                  class="gimg"></li>
               <li><textarea rows="9" cols="80" id="gmessage" name="gmessage"></textarea><br>
               <input type="file" id="gphoto" name="gphoto"></li>
               
            </ul>
         </div>
        
      </form>
              <button id="sbmtbtn">등록</button> 




        </div> <!-- msg_wrap -->
        
        
        
        
  

        <div id="ginsert_wrap2">
        <!-- 방명록 리스트 반복  -->
        </div>




     
</div><!-- changing end -->


   <div class="paging">
	</div>
	
        <script>
        
		
    	// 뷰컨트롤러 통해 페이지 번호 받기
		function getParameterByName(name) {name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name+ "=([^&#]*)"), results = regex.exec(location.search);
		return results === null ? "": decodeURIComponent(results[1].replace(/\+/g, " "));
	  }

		
		var p = getParameterByName('p');
		var gidx =getParameterByName('gidx');
		console.log("방명록인덱스 : ",gidx);
	    console.log(p);
	    
		$(document).ready(function(){
			
			   /*  방명록 데이터 등록 */
				
				$('#sbmtbtn').click(function() {
					   var data =$('#insertGForm')[0];
			            var form_data = new FormData(data);

				       $.ajax({
			               url : 'http://localhost:8080/peeps/rest/guestbook/upload',
			               type : 'post',
			               data : form_data,
			               dataType : 'json',
			               async : true,
			               enctype : 'multipart/form-data',
			               processData : false,
			               contentType : false,
			               cache : false ,
			               success : function(data){
			                  console.log("ajax data",data);
			                  console.log("작성완료");
			                  alert("방명록이 작성 되었습니다");
			                  
			               }
			            });
			            
			            
			            
			         
			         }); //-------방명록 작성 ajax끝 
				
				
				
				
			

						/*게스트북 리스트 출력*/
						$.ajax({
							url : 'http://localhost:8080/peeps/rest/guestbook?p='+p,
							type : 'GET',
							success : function(data){
								console.log(data);
								//alert(data);
								//alert(JSON.stringify(data));
								console.log("ajax로 받아온 데이터 : ", data);
								var list = $(data.gbList);
								console.log(list);
								$.each(list, function(index, item){
								
									var date = item.gdate-540*60*1000;
									
									date = new Date(date).toLocaleDateString();
								
									console.log("날짜: ", date);
								 
									
									var html  = ' <div class="msg_wrap2">';
									/* 작성자와 세션 아이디가 같으면  버튼이 보이게하기 */
									if(item.gwriter =="test"){
										
										html +='  <div class="writerboutton">';
										html +='  <button id="edit_but" onclick="edit_btn('+item.gidx+');">수정</button>';
										html +='  <button id="del_but" onclick="del_btn('+item.gidx+');">삭제</button>';
										html +='  </div>';
									}
									
									html +='  <span class="writerPhoto"><img src="../imgs/photo.png" class="writerPhoto"></span>';
									html +='  <span class="writerid">'+ item.gwriter+'</span>';
									html +='  <span class="gUpDate">'+date+'</span>';
									html +='  <div class="upMsg">';
									if(! item.gphoto ==" "){
										html +='  <span><img src="<c:url value="/fileupload/guestbook/'+item.gphoto+'"/>" class="gUpPhoto" > </span> ';	
										
									}
									 
						            html +='  <h3 class="gUptext">'+item.gmessage+'</h3>';
						            html +='  </div>';
						            html +='  <div class="cmt">';
						            html +='  <span>';
						            html +='  <hr id="hr2">';
						            html +='  <h4 class="id">'+ item.gwriter+' :</h4>';
						            html +='  </span>';
						            html +=' <textarea rows="3" cols="97" name="cmt_content" class="cmttxt" id="cmttxt" placeholder="댓글을 입력해주세요." required></textarea>';
						            html +=' <input type="submit" id="gCmtbtn" value="등록">';
						            html +=' </div>';
						            html +=' <hr>';
						            html +=' </div>';
													
									   $('#ginsert_wrap2').append(html); 
								 
								});
							
								// 페이징 처리
								 if (data.totalGbCount>0){
									 console.log('totalPageCount :' + data.totalPageCount);
									for(var i=1; i <= data.totalPageCount; i++){	/* test 계정아이디 들어가야 함 */			
										 var html2 =' <span><a class="pageBtn" href="<c:url value="/guestbook"/>?p='+i+'">'+i+'</a></span> ';																		
										 $('.paging').append(html2);
									}										 
								 };	
								
								
							},
							error:function(e){
							console.log("에러발생!! :",e);	
							}
						
							
						}); //----리스트 ajax end
						
				});
	    
    
        
        /* 방명록 수정   */
            function edit_btn(gidx) {
            	
            	if (confirm('방명록을 수정하시겠습니까? ')) {
            	
            	$.ajax({
            		url : 'http://localhost:8080/peeps/rest/guestbook/' + gidx,
            		type : 'get',
            		success : function(data){
						console.log("수정값 받아오기  data",data);
						
						
						var html = '<span>'+data.gmessage+'<span>';
						$('textarea.gmessage').append(html);
						
						
						
						
						
				
					     
					       },
					       
					       error : function(e){
			    				console.log("에러발생!! : ", e);
			    			}
            	});

            	}
            	
            	} /* 방명록 수정    ---end*/
            
            
            
            
            
           /* 방명록 삭제  */
            function del_btn(gidx) {
            	
            	if (confirm('방명록을 삭제하시겠습니까?')) {
    				
    				
    				$.ajax({
    					url : 'http://localhost:8080/peeps/rest/guestbook/delete?gidx=' + gidx,
    					type : 'post',
    					success : function(data){
    						console.log("ajax data",data);
    						
    						//window.location.href="http://localhost:8080/peeps/guestbook";
    						alert("방명록이 삭제 되었습니다");
    						
    						newdiv();
    						
    					}
    				});
    			}	
                

            }/*function del_btn(gidx) --end  */
            
    /*         
        function addpho_btn(){
            var str = document.getElementById("test");
		str.innerHTML = '<div><input type="file" id="gphoto" name="gphoto"></div>';
        };    
             */
            
            
        function newdiv(){
        	$("#main_wrap").load(location.href + "#main_wrap");
        	
        }      
            
            

        </script>
			
			
		
			
	




</body>

</html>
