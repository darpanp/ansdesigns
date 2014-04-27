$(document).ready(function() {
		//hide the rotation images
		$("#img1").hide();
		$("#img2").hide();
	
        // store url for current page as global variable
		current_page = document.location.href
		//alert(current_page);
		$("ul.nav li a").removeClass('current');
		  
		// apply selected state to header menu depending on current page
		if (current_page.match('pages/about')) { 
			$("ul.nav li:eq(1) a").addClass('current');
		} else if (current_page.match('pages/contacts')) {
			$("ul.nav li:eq(2) a").addClass('current');
		} else {
			$("ul.nav li:eq(0) a").addClass('current');
		};
		
		//This code is responsible for displaying quantity textbox next to check-box
		$(".testClass").click(function() {
			var htmlCode = "<input type=\"text\" class=\"quote_text\" id=\"txt_" + this.id +"\" name=\"work_qty[" + this.id + "]\" value=\"1\" onclick=\"javascript:this.value=''\" />";
			if($(this).is(":checked")) {
				ToggleTextBox(this.id, this.checked, htmlCode);
			}
			else {
				ToggleTextBox(this.id, this.checked, htmlCode);
			}	
		});
			
		//First time animation on hompage
		if (current_page.match('pages/home')) {
			$("#companylogo").hide();
			$("#extrabox").hide();
			$(".article").hide();
			$(".aside").hide();
			
			//This code is for displaying the curtain roll
			$("#header .container").removeClass('first');
			$("#header .container").addClass('second').animate({height:'toggle'}, 0);
			if($("#header .container").attr('class').match('second')) {
				$("#header .container").removeClass('second');
				$("#header .container").addClass('first').animate(
					{height:'toggle'}, 1000, 
					function() {
						//display other items
						$("#img1").css('left', '40px');
						$("#img1").fadeIn(800);
						$("#img1").animate({left: 0}, 1500);
			
						$("#extrabox").css('left', '-30px');
						$("#extrabox").fadeIn(800);
						$("#extrabox").animate({left: 0}, 1000, function () {
							$(".article").fadeIn(500);
							$(".aside").fadeIn(500);
						});
						
						$("#companylogo").css('top', '-20px');
						$("#companylogo").animate({top: 27}, {duration: 'slow'}, {easing:'easeOutBounce'}).show();
					}
				);	
			}
		}
		else
		{
			$("#img1").show().fadeIn(5000);
		}	
		
		container_class = 'second';
				
		//This code is responsible for switching/blending the image in header for a given delay
		window.setInterval(function() {
			$("#header .container").removeClass('second');
			$("#header .container").removeClass('first');
			
			if(container_class.match('first')) {
				$("#img2").fadeOut(2000);
				$("#img1").fadeIn(2000);
				container_class = 'second';
				
			} else {
				if(container_class.match('second')) {	
					$("#img1").fadeOut(2000);
					$("#img2").fadeIn(2000);
					container_class = 'first';	
				}
			}
		}, 10000); //<== Code that controls delay, 10 seconds right now 
		
		$("#user_fullname").keyup(function(){
			$.get(this.action, $(this).serialize(), null, 'script');
			return false;
		});
		
});

function ToggleTextBox(id, checked, html) {
	
	//get the parent based on id
	if(checked)
	{
		$("#"+id).parent("td").append(html);
	} else {
		$("#txt_"+id).remove();
	}
}