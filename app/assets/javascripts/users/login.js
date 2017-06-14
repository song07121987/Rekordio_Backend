$(document).ready(function() {
	console.log(">>> >>> X1:");
});

$("form#login_form").on("ajax:success", function(event, data, status, xhr) {
	console.log(data);
})