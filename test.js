$(document).ready(function(){
		
		/*
		window.api = new api();

		window.api.events.add("derpderp");
		
		window.api.events.deleteEvent(5);*/

		$.ajax({
			type: 'post',
			url:"api/events.php",
			data:{"name": "derp"},
			success: function(data){
				console.log(data);
				
			}
		});	

});