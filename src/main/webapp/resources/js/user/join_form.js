// resources/js/user/join_form.js
export function initJoinForm() {
	// 1. 비밀번호 복잡도 검사
	const passwordInput = document.getElementById("userPassword");
	const confirmInput = document.getElementById("userPasswordConfirm");

	if(passwordInput) {
		passwordInput.onblur = function () {
			const pwd = this.value;
			const result = document.getElementById("checkPasswdResult");

			const pattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%])[A-Za-z\d!@#$%]{8,16}$/;
			if(!pattern.test(pwd)) {
				result.innerText = "영문자, 숫자, 특수문자(!@#$%) 조합 8 ~ 16글자 필수!";
				result.style.color = "red";
			} else {
				result.innerText = pwd.length >= 12 ? "안전" : (pwd.length >= 10 ? "보통" : "위험");
				result.style.color = pwd.length >= 12 ? "green" : (pwd.length >= 10 ? "orange" : "red");
			}
		};
	}

	// 2. 비밀번호 확인
	if(passwordInput && confirmInput) {
		confirmInput.onblur = function () {
			const pwd = passwordInput.value;
			const pwd2 = this.value;
			const result = document.getElementById("checkPasswd2Result");

			if(pwd === pwd2) {
				result.innerText = "비밀번호 확인 완료!";
				result.style.color = "green";
			} else {
				result.innerText = "비밀번호 다름!";
				result.style.color = "red";
			}
		};
	}

	// 3. 주소 검색 API
	const btn = document.getElementById("btnSearchAddress");
	if(btn) {
		btn.onclick = function () {
			new daum.Postcode({
				oncomplete: function (data) {
					const address = data.buildingName
						? `${data.address} (${data.buildingName})`
						: data.address;

					document.getElementById("userPostcode").value = data.zonecode;
					document.getElementById("userAddress1").value = address;
					document.getElementById("userAddress2").focus();
				}
			}).open();
		};
	}
}
