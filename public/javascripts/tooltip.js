$(document).ready(function() 
{
	$('a[thumb]').each(function()
	{
		$(this).qtip(
		{
			content: '<img src="'+$(this).attr('thumb')+'" />'
		});
	});
});
