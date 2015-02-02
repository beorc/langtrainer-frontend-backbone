// Sticky v1.0 by Daniel Raftery
// http://thrivingkings.com/sticky
//
// http://twitter.com/ThrivingKings

(function( $ )
	{

	// Using it without an object
	$.sticky = function(note, options, callback) { return $.fn.sticky(note, options, callback); };

	$.fn.sticky = function(note, options, callback)
		{
		// Default settings
		var position = 'top-right'; // top-left, top-right, bottom-left, or bottom-right

		var settings =
			{
			'speed'			:	'fast',	 // animations: fast, slow, or integer
			'duplicates'	:	true,  // true or false
			'autoclose'		:	5000  // integer or false
			};

		// Passing in the object instead of specifying a note
		if(!note)
			{ note = this.html(); }

		if(options)
			{ $.extend(settings, options); }

		// Variables
		var display = true;
		var duplicate = 'no';

		// Somewhat of a unique ID
		var uniqID = Math.floor(Math.random()*99999);

		// Handling duplicate notes and IDs
		$('.sticky-note').each(function()
			{
			if($(this).html() == note && $(this).is(':visible'))
				{
				duplicate = 'yes';
				if(!settings['duplicates'])
					{ display = false; }
				}
			if($(this).attr('id')==uniqID)
				{ uniqID = Math.floor(Math.random()*9999999); }
			});

		// Make sure the sticky queue exists
		if(!$(this).find('.sticky-queue').html())
			{ $(this).append('<div class="sticky-queue ' + position + '"></div>'); }

		// Can it be displayed?
		if(display)
			{
			// Building and inserting sticky note
			$(this).find('.sticky-queue').prepend('<div class="sticky border-' + position + '" id="' + uniqID + '"></div>');
			$(this).find('#' + uniqID).append('<img src="/assets/close.png" class="sticky-close" rel="' + uniqID + '" title="Close" />');
			$(this).find('#' + uniqID).append('<div class="sticky-note" rel="' + uniqID + '">' + note + '</div>');

			// Smoother animation
			var height = $(this).find('#' + uniqID).outerHeight();
			$(this).find('#' + uniqID).css('height', height);

			$(this).find('#' + uniqID).slideDown(settings['speed']);
			display = true;
			}

		// Listeners
		$(this).find('.sticky').ready(function()
			{
			// If 'autoclose' is enabled, set a timer to close the sticky
			if(settings['autoclose'])
				{ $('#' + uniqID).delay(settings['autoclose']).fadeOut(settings['speed']); }
			});
		// Closing a sticky
		$(this).find('.sticky-close').click(function()
			{ $('#' + $(this).attr('rel')).dequeue().fadeOut(settings['speed']); });


		// Callback data
		var response =
			{
			'id'		:	uniqID,
			'duplicate'	:	duplicate,
			'displayed'	: 	display,
			'position'	:	position
			}

		// Callback function?
		if(callback)
			{ callback(response); }
		else
			{ return(response); }

		}
})( jQuery );
