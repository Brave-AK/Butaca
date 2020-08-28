//($(document).ready(function() {
//	$('.sidebarr .collapse-a').click( function(event){
//	    event.preventDefault();
//	    $(this).siblings('ul').collapse('toggle');
//	});
//
//	$('.sidebarr ul.collapse').on('show.bs.collapse', function(){
//	    $(this).siblings('a').find('.fa').removeClass('fa-angle-right').addClass('fa-angle-down');
//	});
//
//	$('.sidebarr ul.collapse').on('hidden.bs.collapse', function(){
//	    $(this).siblings('a').find('.fa').removeClass('fa-angle-down').addClass('fa-angle-right');
//	});
//
//	// var handlerClick = function(event) {
//	// 	event.preventDefault();
//
//	// 	var href = $(this).attr('href');
//	// 	var $href = $(href);
//	// 	var $icon = $(this).find('.fa');
//
//	// 	if ($href.hasClass('in')) {
//	// 		$href.removeClass('in');
//	// 	} else {
//	// 		$href.addClass('in');
//	// 	}
//
//	// 	if ($icon.hasClass('fa-angle-down')) {
//	// 		$icon.removeClass('fa-angle-down');
//	// 		$icon.addClass('fa-angle-right')
//	// 	} else if ($icon.hasClass('fa-angle-right')) {
//	// 		$icon.removeClass('fa-angle-right');
//	// 		$icon.addClass('fa-angle-down')
//	// 	}
//	// }
//
//	// $(document)
//	// 	.off('click', '.collapse-a')
//	// 	.on('click', '.collapse-a', handlerClick)
//}));