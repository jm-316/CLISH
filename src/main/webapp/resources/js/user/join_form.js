export function initJoinForm() {
	console.log('initJoinForm 실행됨');
	// const값 모음
	const nicknameInput = document.getElementById('userRepName');
	const resultSpan = document.getElementById('nicknameCheckResult');
	const idInput = document.getElementById("userId");
	const idResultSpan = document.getElementById('idCheckResult');
	const pwInput = document.getElementById("userPassword");
	const pwConf = document.getElementById("userPasswordConfirm");
	const phoneInput = document.getElementById("userPhoneNumber");
	const agreeChk = document.getElementById("agreeTerms");
	const submitBtn = document.getElementById("submitBtn");
	const addressBtn = document.getElementById("btnSearchAddress");
	const postcodeInput = document.getElementById("userPostcode");
	const address1Input = document.getElementById("userAddress1");
	const address2Input = document.getElementById("userAddress2");
	const birthInput = document.getElementById("userBirth");
	const disabledFields = document.querySelectorAll('.required_auth input, .required_auth select, .required_auth button');
	
	let isNicknameOk = false;
	let isBirthOk = false;
	let isIdOk = false;
	let isPwOk = false;
	let isPwMatchOk = false;
	let isPhoneOk = false;
	let isAddressOk = false;
	let isAgreeChkOk = false;

	
	// 이메일 인증전 disabled 처리 
	disabledFields.forEach(el => {
		el.disabled = true;
	});
	
	// 서브밋 비활성화
	if(submitBtn) submitBtn.disabled = true;
	
	// 1. 닉네임 중복체크
	let timerDelay = null;
	
	nicknameInput.addEventListener('input', function() {
	    clearTimeout(timerDelay);
	    const nickname = this.value.trim();

	    if(nickname.length < 2) {
	        resultSpan.innerText = '닉네임은 2글자 이상 입력';
	        resultSpan.style.color = 'gray';
	        return;
	    }

	    timerDelay = setTimeout(() => {
	        fetch(`/user/checkNname?nickname=${encodeURIComponent(nickname)}`)
	            .then(res => res.json())
	            .then(data => {
					console.log("nicknameInput:", nicknameInput);
	                if(data.exists) {
	                    resultSpan.innerText = '이미 사용 중인 닉네임입니다';
	                    resultSpan.style.color = 'red';
						isNicknameOk = false;
	                } else{
	                    resultSpan.innerText = '사용 가능한 닉네임입니다!';
	                    resultSpan.style.color = 'green';
						isNicknameOk = true;
	                }
					updateSubmitButton();
	            }).catch(_err => {
	                resultSpan.innerText = '중복 확인 실패';
	                resultSpan.style.color = 'gray';
					isNicknameOk = false;
					updateSubmitButton();
	            });
			
		    }, 600); // 0.6초
		});
	
	
	
	// 2. 생년월일 정규표현식 체크
	birthInput.addEventListener('blur', function() {
	    const birth = this.value.replace(/\s+/g, "");
	    const resultSpan = document.getElementById('birthCheckResult');
	
	    const pattern = /^\d{4}-\d{2}-\d{2}$/;
	    if(!pattern.test(birth)) {
	        resultSpan.innerText = '생년월일 형식은 ****-**-**입니다.';
	        resultSpan.style.color = 'red';
			isBirthOk = false;
	    } else{
	        resultSpan.innerText = '올바른 전화번호 형식입니다!';
	        resultSpan.style.color = 'green';
			isBirthOk = true;
	    }
		updateSubmitButton();
	});
	
	
	// 3. 아이디 중복 & 정규표현식 체크
	let idTimerDelay = null;

	idInput.addEventListener('input', function() {
	    clearTimeout(idTimerDelay);
	    const userId = this.value.replace(/\s+/g, "");

	    if(userId.length < 4) {
	        idResultSpan.innerText = '아이디는 4글자 이상 입력';
	        idResultSpan.style.color = 'gray';
	        return;
	    }

	    idTimerDelay = setTimeout(() => {
	        fetch(`/user/checkId?userId=${encodeURIComponent(userId)}`)
	            .then(res => res.json())
	            .then(data => {
	                if(data.exists) {
	                    idResultSpan.innerText = '이미 사용 중인 아이디입니다';
	                    idResultSpan.style.color = 'red';
						isIdOk = false;
	                } else{
	                    idResultSpan.innerText = '사용 가능한 아이디입니다!';
	                    idResultSpan.style.color = 'green';
						isIdOk = true;
	                }
	            }).catch(_err => {
	                idResultSpan.innerText = '중복 확인 실패';
	                idResultSpan.style.color = 'gray';
					isIdOk = false;
	            });
				updateSubmitButton();
			}, 600);
		});
	
	
	// 4. 비밀번호1 안전도검사
	if(pwInput) {
		pwInput.onblur = function () {
			const pwd = this.value;
			const result = document.getElementById("checkPasswdResult");

			const pattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%])[A-Za-z\d!@#$%]{8,16}$/;
			if(!pattern.test(pwd)) {
				result.innerText = "영문자, 숫자, 특수문자(!@#$%) 조합 8 ~ 16글자 필수!";
				result.style.color = "red";
				isPwOk = false;
			} else{
				result.innerText = pwd.length >= 12 ? "안전" : (pwd.length >= 10 ? "보통" : "위험");
				result.style.color = pwd.length >= 12 ? "green" : (pwd.length >= 10 ? "orange" : "red");
				isPwOk = true;
			}
			updateSubmitButton();
		};
	}

	// 5. 비밀번호2 1과의 동일한 값 확인
	if(pwInput && pwConf) {
		pwConf.onblur = function () {
			const pwd = pwInput.value;
			const pwd2 = this.value;
			const result = document.getElementById("checkPasswd2Result");

			if(pwd === pwd2) {
				result.innerText = "비밀번호 확인 완료!";
				result.style.color = "green";
				isPwMatchOk = true;
			} else{
				result.innerText = "비밀번호 다름!";
				result.style.color = "red";
				isPwMatchOk = false;
			}
			updateSubmitButton();
		};
	}
	
	// 6. 전화번호 중복 & 정규표현식 체크
	phoneInput.addEventListener('blur', function() {
	    const phone = this.value.replace(/\s+/g, "");
	    const resultSpan = document.getElementById('phoneCheckResult');
	    const pattern = /^\d{3}-\d{4}-\d{4}$/;
	
	    // 1차: 정규표현식 체크
	    if (!pattern.test(phone)) {
	        resultSpan.innerText = '전화번호 형식은 ***-****-**** 입니다.';
	        resultSpan.style.color = 'red';
	        isPhoneOk = false;
	        updateSubmitButton();
	        return;
	    }
	
	    // 2차: 서버에 중복체크 요청
	    fetch(`/user/checkPhone?userPhone=${encodeURIComponent(phone)}`)
	        .then(res => res.json())
	        .then(data => {
	            if (data.exists) {
	                resultSpan.innerText = '이미 등록된 전화번호입니다.';
	                resultSpan.style.color = 'red';
	                isPhoneOk = false;
	            } else {
	                resultSpan.innerText = '사용 가능한 전화번호입니다!';
	                resultSpan.style.color = 'green';
	                isPhoneOk = true;
	            }
	            updateSubmitButton();
	        })
	        .catch(_err => {
	            resultSpan.innerText = '중복 확인 실패';
	            resultSpan.style.color = 'gray';
	            isPhoneOk = false;
	            updateSubmitButton();
	        });
	});
	
	// 7. 주소 검색 API
	
	if(addressBtn) {
	    addressBtn.onclick = function () {
	        new daum.Postcode({
	            oncomplete: function (data) {
	                const address = data.buildingName
	                    ? `${data.address} (${data.buildingName})`
	                    : data.address;
	                postcodeInput.value = data.zonecode;
	                address1Input.value = address;
	                address2Input.focus();
	                checkAddressFields();
	            }
	        }).open();
	    };
	}
	
	function checkAddressFields() {
	    if (
	        postcodeInput.value.trim() &&
	        address1Input.value.trim() &&
	        address2Input.value.trim()
	    ) {
	        isAddressOk = true;
	    } else {
	        isAddressOk = false;
	    }
	    updateSubmitButton();
	}
	
	[postcodeInput, address1Input, address2Input].forEach(input => {
	    input.addEventListener('input', checkAddressFields);
	});
	
	// 8. 약관동의
	if(agreeChk) {
    agreeChk.addEventListener('change', function() {
	        isAgreeChkOk = this.checked;
	        updateSubmitButton();
	    });
	}
	
	// 9. 전체 입력 확인 체크
	function updateSubmitButton() {
	    if(isNicknameOk && isBirthOk && isIdOk && isPwOk && isPwMatchOk && 
					isPhoneOk && window.isEmailVerified && isAddressOk && isAgreeChkOk) {
	        submitBtn.disabled = false;
	    } else{
	        submitBtn.disabled = true;
	    }
	}
	
}
