$(document).ready(function() {
	
	// Смена текста в контролах форм
	$('input.change-text').each(function() {
		var textControlDef = $(this).val();
		$(this).focus(function() {
			var textControlCur = $(this).val();
			if(textControlCur === textControlDef) {
				$(this).val('').addClass('write-color');
				$(this).blur(function() {
					var textControlNew = $(this).val();
					if(textControlNew == 0) {
						$(this).val(textControlCur).removeClass('write-color');
					}
				});
			}
		});
	});
	
	// Попап подписки на новости
	$('.js-subscribe').click(function() {
		$(this).siblings('.subscribe-popup').fadeToggle();
		return false;
	});
	
	// Социалки на внутренних
	$('.share-box .link').click(function() {
		$(this).siblings('.share-box-c').fadeToggle();
		return false;
	});
	
	// Меню разделов на внутренних
	$('.link-toggle-sections').click(function() {
		if($('.library-sections').hasClass('hidden') == true) {
			$(this).siblings('.library-sections-c').slideDown(500, function() {
				$('.link-toggle-sections i').text('Скрыть');
				$('.library-sections').removeClass('hidden');
			});
		} else {
			$(this).siblings('.library-sections-c').slideUp(500, function() {
				$('.link-toggle-sections i').text('Показать');
				$('.library-sections').addClass('hidden');
			});
		}
		return false;
	});
	
});
