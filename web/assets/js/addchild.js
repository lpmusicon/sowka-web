window.onload = function() {
	$('.rewardOption').eq(1).addClass('selected');
}

//Input ze zdjęciem
var img = document.createElement('input');
	img.setAttribute('type','file');
	img.setAttribute('name','childImage');
	img.setAttribute('id','image');

//Czy używa avatara
var isUsingAvatar = true;
var isMaleAvatar = true;
var isUsingMaleReader = true;
var rewardId = 2;

function selectPhoto(photo) {
	if(photo != undefined) {
		isUsingAvatar = ($(photo).attr('isAvatar') == 'true' ? true : false);
		if(isUsingAvatar) isMaleAvatar = ($(photo).attr('isMale') == 'true' ? true : false);
		$('body #container form div.imageContainer').children().removeClass('selected');
		$(photo).addClass('selected');
	}
}

function addPhoto(photo) {
	img.click();
	isUsingAvatar = false;
	selectPhoto(photo);
}

$(img).change(function(){
	readURL(img);
});

function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function (e) {
			$('.imageContainer').fadeOut("normal", function() {
				$('#imagePreview').attr('src', e.target.result);
			});
			$('.imageContainer').fadeIn("normal");
		}
		reader.readAsDataURL(input.files[0]);
	}
}

function swapReward(reward) {
	$('.rewardOption').removeClass('selected');
	$(reward).addClass('selected');
	rewardId = parseInt($(reward).attr('rewardID'));
}

