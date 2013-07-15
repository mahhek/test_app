			$(document).ready(function () {  

				var sidebar = $('#sidebar_content');
				var top = sidebar.offset().top - parseFloat(sidebar.css('marginTop'));

				$(window).scroll(function (event) {
					var ypos = $(this).scrollTop();
					if (ypos >= top) {
						sidebar.addClass('fixed');
					}
					else {
						sidebar.removeClass('fixed');
					}
				});

				$.localScroll();
				
			});