let sendMail = null;

export function initEmailAuth(emailInputId, buttonId, statusSpanId, options) {
	
	// DOM 요소 참조
	options = options || {};
	const emailInput = document.getElementById(emailInputId);
	const verifyBtn = document.getElementById(buttonId);
	const checkBtn = document.getElementById("checkEmailVerifiedBtn");
	const resultSpan = document.getElementById(statusSpanId);
	const purpose = typeof options.purpose !== "undefined" ? options.purpose : "user";
	
//	let emailCheckInterval = null;
	
	// 이메일 인증
	verifyBtn.addEventListener("click", () => {
		
		// 이메일 미입력시
		const email = emailInput.value.trim();
		if(!email) {
			alert("이메일을 입력하세요!");
			emailInput.focus();
			return;
		}
		
		// purpose값이 존재하면 추가
		var bodyData = { userEmail: email };
		if(purpose) {
			bodyData.purpose = purpose;
		}
		
		fetch("/email/send", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify(bodyData)
		})
		.then(res => res.text())
		.then(token => {
			if(token) {
				alert("이메일이 전송되었습니다. 받은 메일에서 인증 링크를 클릭하세요.");
				
				resultSpan.innerText = "이메일 인증 중...";
				resultSpan.style.color = "orange";
				checkBtn.style.display = "inline-block";
				sendMail = email;

//				startEmailPolling(email);
					
			} else {
				alert("이메일 전송 실패!");
			}
		})
		.catch(() => {
			alert("서버 오류로 메일 전송 실패!");
		});
	});
	
	// 로직 변경로 주석처리
//	function startEmailPolling(email) {
//		clearInterval(emailCheckInterval);
//
//		emailCheckInterval = setInterval(() => {
//			fetch(`/email/check?email=${encodeURIComponent(email)}`)
//				.then(res => res.json())
//				.then(data => {
//					if(data.verified) {
//						resultSpan.innerText = "이메일 인증 완료!";
//						resultSpan.style.color = "green";
//						
//						clearInterval(emailCheckInterval);
//						
//						emailInput.readOnly = true;
//						verifyBtn.disabled = true;
//						
//						document.querySelectorAll('.required_auth input, .required_auth select, .required_auth button')
//								.forEach(el => el.disabled = false);
//								
//						window.isEmailVerified = true; 
//						if(typeof window.updateSubmitButton === "function") updateSubmitButton();
//					}
//				}).catch(err => console.error("인증 상태 확인 실패", err));
//		}, 3000);
//	}
	
	
	
	// 인증 완료 버튼
	checkBtn.addEventListener("click", () => {
		const email = emailInput.value.trim().toLowerCase();
		console.log("email : " + email)
		console.log("sendMail : " + sendMail)
		
		if(!email) {
			alert("이메일을 입력하세요!");
			emailInput.focus();
			return;
		}
		
		if (email != sendMail) {
	        alert("인증 요청한 이메일과 일치하지 않습니다.");
	        return;
	    }

		fetch(`/email/check?email=${encodeURIComponent(email)}`)
		.then(res => res.json())
		.then(data => {
			if(data.verified) {
				resultSpan.innerText = "이메일 인증 완료!";
				resultSpan.style.color = "green";

				emailInput.readOnly = true;
				verifyBtn.disabled = true;
				checkBtn.disabled = true;
				checkBtn.style.display = "none";
				
				// 모든 버튼 활성화
				document.querySelectorAll('.required_auth input, .required_auth select, .required_auth button')
					.forEach(el => el.disabled = false);
			
			} else {
				resultSpan.innerText = "아직 인증되지 않았습니다.";
				resultSpan.style.color = "red";
			}
		})
		.catch(() => {
			alert("인증 확인 중 오류 발생");
		});
	});
}

