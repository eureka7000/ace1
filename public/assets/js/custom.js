/* Write here your custom javascript codes */
function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function ajaxLoading(){
	$("#loading").bind("ajaxSend", function() {
		$('body').css('opacity', '0.5');
    $(this).show();
  }).bind("ajaxComplete", function() {
		$('body').css('opacity', '');
    $(this).hide();
  });
}

