$(document).ready(function()
{
	$('.next_drop_order').off('click').on('click', function(e){
		e.preventDefault();
		var next = $(this).attr('value');
		$('#div_drop_'+next).show();
	});
});