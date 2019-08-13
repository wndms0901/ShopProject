console.log("Product Module........");
var productService = (function(){
	
	function addCart(params, callback,error){
		console.log("params: "+params);
		$.ajax({
			type: 'GET',
			url: '../order/cartA.do'+params,
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
			var mCode = params.substr(7,3);
			var lowCode = params.substr(19);
			$.ajax({
				type: 'GET',
				url: '../product/bestA.do'+params,
				success: function(result,status,xhr){
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
		function pStock(params, callback,error){
			console.log("params: "+params);
			$.ajax({
				type: 'GET',
				url: '../product/stockCheckA.do'+params,
				async: false, // ture: 비동기, false: 동기
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
		function pStockCheck(params, callback,error){
			console.log("params: "+params);
			$.ajax({
				type: 'GET',
				url: '../product/stockCheckA.do'+params,
				async: false, // ture: 비동기, false: 동기
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
		
	return {addCart:addCart,
		chgCart:chgCart,
		bestProduct:bestProduct,
		mbCheck:mbCheck,
		mbIdCheck:mbIdCheck,
		categoryList:categoryList,
		orderList:orderList,
		pStock:pStock,
		pStockCheck:pStockCheck
	}
		
})();