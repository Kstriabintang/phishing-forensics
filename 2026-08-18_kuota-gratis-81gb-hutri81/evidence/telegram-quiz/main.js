
if(Telegram.WebApp.BackButton){
	Telegram.WebApp.BackButton.show();
	Telegram.WebApp.BackButton.onClick(function(){window.history.go(-1);});
}

//////////

function getCookie(name){
	if(document.cookie.length > 0){
		start = document.cookie.indexOf(name + '=');
		if(start != -1){
			start = start + name.length + 1;
			end = document.cookie.indexOf(';',start);
			if(end == -1){
				end = document.cookie.length;
			}
			return unescape(document.cookie.substring(start,end));
		}
	}
	return '';
}
function delCookie(name){
	var date = new Date();
	date.setTime(date.getTime() - 10000);
	document.cookie = name + '=a; expires=' + date.toGMTString();
}
function print_r(obj,deep){
	deep = deep || 0;
	if(typeof(obj) != 'object'){
		var str = obj;
		if(deep != 0){
			return str;
		}else{
			console.log(str);
			alert(str);
			return 0;
		}
	}
	var str = '';
	var t = '';
	for(var n = 0; n < deep; n ++){
		t += '->';
	}
	for(var i in obj){
		str += t + i + ' : ';
		if(typeof(obj[i]) == 'object'){
			var s = print_r(obj[i],deep + 1);
			str += '\n' + s;
		}else{
			str += obj[i] + '\n';
		}
	}
	if(deep != 0){
		if(str == ''){
			return t + '[obj] ' + String(obj) + '\n';
		}else{
			return str;
		}
	}else{
		console.log(str);
		alert(str);
		return 0;
	}
}
