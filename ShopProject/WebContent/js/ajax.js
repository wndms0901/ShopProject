console.log("Product Module........");
var productService = (function(){
	
	function addCart(params, callback,error){
		console.log("params: "+params);
		$.ajax({
			type: 'GET',
			url: '../order/cartA.do'+params,
			/*data: JSON.stringify(pno),*/
			/*data: pno,
			contentType: "application/html; charset=utf-8",*/
			success: function(result,status,xhr){
				console.log('성공');
			},
			error : function(xhr, status,er){
				if(error){
					error(er);
				}
			}
		});
	}
		function chgCart(params, callback,error){
			console.log("params: "+params);
			$.ajax({
				type: 'GET',
				url: '../order/cartChgA.do'+params,
				/*data: JSON.stringify(pno),*/
				/*data: pno,
				contentType: "application/html; charset=utf-8",*/
				success: function(result,status,xhr){
					console.log('성공');
				},
				error : function(xhr, status,er){
					if(error){
						error(er);
					}
				}
			});
	}
		function bestProduct(params, callback,error){
			//console.log("params: "+params);
			var mCode = params.substr(7,3);
			var lowCode = params.substr(19);
			//console.log(mCode);
			//console.log(lowCode);
			$.ajax({
				type: 'GET',
				url: '../product/bestA.do'+params,
				/*data: JSON.stringify(pno),*/
				/*data: pno,
				contentType: "application/html; charset=utf-8",*/
				success: function(result,status,xhr){
					//console.log(result);
					$("."+mCode+" #"+mCode+lowCode).append(result);
				},
				error : function(xhr, status,er){
					if(error){
						error(er);
					}
				}
			});
	}
		function mbCheck(params, callback,error){
			console.log("params: "+params);
			$.ajax({
				type: 'GET',
				url: '../member/mbCheckA.do'+params,
				async: false, // ture: 비동기, false: 동기
				/*data: JSON.stringify(pno),*/
				/*data: pno,
				contentType: "application/html; charset=utf-8",*/
				success: function(result,status,xhr){
					value = result;
				},
				error : function(xhr, status,er){
					if(error){
						error(er);
					}
				}
			});
			return value;
	}
		function mbIdCheck(params, callback,error){
			console.log("params: "+params);
			$.ajax({
				type: 'GET',
				url: '../member/mbCheckA.do'+params,
				async: false, // ture: 비동기, false: 동기
				/*data: JSON.stringify(pno),*/
				/*data: pno,
				contentType: "application/html; charset=utf-8",*/
				success: function(result,status,xhr){
					value = result;
				},
				error : function(xhr, status,er){
					if(error){
						error(er);
					}
				}
			});
			return value;
	}
		function categoryList(params, callback,error){
			console.log("params: "+params);
			$.ajax({
				type: 'GET',
				url: '/admin/productA.do'+params,
				success: function(result,status,xhr){
					if(params.substr(7,1)=="m"){
						$("select[id='mediumCtgryNo']").append(result);
					}else{
						$("select[id='lowCtgryName']").append(result);
					}
				},
				error : function(xhr, status,er){
					if(error){
						error(er);
					}
				}
			});
	}
		function orderList(params, callback,error){
			var find = params.lastIndexOf("=") + 1;
			var index  = params.substring(find,params.length);
			$.ajax({
				type: 'GET',
				url: '../admin/orderA.do'+params,
				success: function(result,status,xhr){
					$(".productList:eq("+index+")").append(result);
				},
				error : function(xhr, status,er){
					if(error){
						error(er);
					}
				}
			});
	}
	
	/*function add(reply,callback,error){
		console.log("reply.................")
		
		$.ajax({
			type: 'post',
			url: '/replies/new',
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	function getList(param, callback, error){
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/"+bno+"/"+page+".json",
				function(data){
			if(callback){
				callback(data);
				callback(data.replyCnt, data.list);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	function remove (rno, callback, error){
		$.ajax({
			type:'delete',
			url : '/replies/'+rno,
			success:function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	function update(reply, callback, error){
		console.log("RNO: "+reply.rno);
		$.ajax({
			type: 'put',
			url: '/replies/'+reply.rno,
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	
	function displayTime(timeValue){
		var today = new Date();
		var gap = today.getTime() - timeValue;
		var dateObj = new Date (timeValue);
		var str ="";
		
		if(gap < (1000*60*60*24)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			return [ (hh > 9 ? '' : '0') + hh, ':',(mi>9?'':'0')+mi,
				':', (ss > 9? '' : '0')+ ss].join('');
		}else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; //getMonth() is zero-based
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9? '' : '0')+mm, '/',
				(dd > 9? '' : '0')+dd].join('');
		}
	};*/
	return {addCart:addCart,
		chgCart:chgCart,
		bestProduct:bestProduct,
		mbCheck:mbCheck,
		mbIdCheck:mbIdCheck,
		categoryList:categoryList,
		orderList:orderList
	}
		
})();