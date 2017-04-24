window.onload = function() {
	$('.rewardOption').eq(1).addClass('selected');
}

var img = document.createElement('input');
	img.setAttribute('type','file');
	img.setAttribute('name','childImage');
	img.setAttribute('id','image');

var isUsingAvatar = true;
var isMaleAvatar = true;
var isUsingMaleReader = true;
var rewardId = 2;
var childName = document.getElementsByName('name')[0];
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

function swapReader(reader) {
	$('.readerOption').removeClass('selected');
	$(reader).addClass('selected');
	isUsingMaleReader = ($(reader).attr('isMale') == 'true' ? true : false);
}

function swapReward(reward) {
	$('.rewardOption').removeClass('selected');
	$(reward).addClass('selected');
	rewardId = parseInt($(reward).attr('rewardID'));
}

function showProgressBar() {
    console.log('start');
    //$('#progressBar').fadeIn();
}

$('#submit').on('click touchdown' ,function(e) {
	e.preventDefault();
    var childNameValue = childName.value;
    console.log(childNameValue);
    if(childNameValue.length < 3) return;
    var childForm = new FormData();
        childForm.append('isUsingMaleReader', isUsingMaleReader);
        childForm.append('rewardId', rewardId);
        childForm.append('isUsingAvatar', isUsingAvatar);
        childForm.append('childName', childNameValue);
    if(!isUsingAvatar) {
        childForm.append('childImage', img.files[0]);
    } else {
        childForm.append('isMaleAvatar', isMaleAvatar);
    }
		
    $(document).ajaxStart(function(){
        showProgressBar();
    });

    $.ajax({
		url: 'addChild_helper.php',
		type: "POST",
		data: childForm,
		async: true,
		success: function (getReturn) {
            document.getElementById('info').innerHTML = getReturn;
            // var info = JSON.parse(getReturn);
            // if(info.permitted) window.location.href = 'main.php';
		},
		cache: false,
		contentType: false,
		processData: false
    });
});

