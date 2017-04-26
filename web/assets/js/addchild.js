//Input ze zdjęciem
const img = document.getElementsByName('child[imageFile]')[0];
let isUsingAvatar = document.getElementsByName('child[isUsingAvatar]')[0];
let isMaleAvatar = document.getElementsByName('child[isMaleAvatar]')[0];;
var rewardId = 0;

$('.avatar').on('click', (ev) => {
	const selected = ev.target;
	const $selected = $(selected);

	$('.avatar').removeClass('selected');

	isUsingAvatar.checked = true;
	isMaleAvatar.checked = $selected.attr('isMale') == 'true' ? true : false;
	$selected.addClass('selected');
});

$('#imagePreview').on('click', (ev) => {
	const selected = ev.target;
	const $selected = $(selected);

	return img.click();
})

$(img).change(() => readURL(img));

function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function (e) {
			$('.imageContainer').fadeOut("normal", function() {
				$('#imagePreview').attr('src', e.target.result);
			});
			$('.imageContainer').fadeIn("normal");
			isUsingAvatar.checked = false;
			isMaleAvatar.checked = false;
		}
		reader.readAsDataURL(input.files[0]);
	}
}

function swapReward(reward) {
	$('.rewardOption').removeClass('selected');
	$(reward).addClass('selected');
	const rewards = document.getElementsByName('child[singleReward]');
	const newReward = $(reward).attr('rewardID');
	for(let i = 0; i < rewards.length; i++)
	{
		if(rewards[i].value == newReward) {
			rewards[i].checked = true;
		}
	}
	rewardId = parseInt(newReward);
}

