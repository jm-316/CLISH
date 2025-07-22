export function initEmailAuth(emailInputId, buttonId, statusSpanId, options) {
	
	options = options || {};
	const emailInput = document.getElementById(emailInputId);
	const verifyBtn = document.getElementById(buttonId);
	const resultSpan = document.getElementById(statusSpanId);
	const purpose = typeof options.purpose !== "undefined" ? options.purpose : "user";
	
	let emailCheckInterval = null;

	if(!emailInput || !verifyBtn || !resultSpan) {
		console.error("email_auth.js 초기화 실패: 요소 확인 필요");
		return;
	}

	verifyBtn.addEventListener("click", () => {
		const email = emailInput.value;
		if(!email) {
			alert("이메일을 입력하세요!");
			emailInput.focus();
			return;
		}
		
		var bodyData = { userEmail: email };
		if (purpose) {
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
					startEmailPolling(email);
				} else {
					alert("이메일 전송 실패!");
				}
			})
			.catch(err => {
				console.error("서버 오류", err);
				alert("서버 오류로 메일 전송 실패!");
			});
	});

	function startEmailPolling(email) {
		clearInterval(emailCheckInterval);

		emailCheckInterval = setInterval(() => {
			fetch(`/email/check?email=${encodeURIComponent(email)}`)
				.then(res => res.json())
				.then(data => {
					if(data.verified) {
						resultSpan.innerText = "이메일 인증 완료!";
						resultSpan.style.color = "green";
						
						clearInterval(emailCheckInterval);
						
						emailInput.readOnly = true;
						verifyBtn.disabled = true;
						
						document.querySelectorAll('.required_auth input, .required_auth select, .required_auth button')
								.forEach(el => el.disabled = false);
						const submitBtn = document.getElementById("submitBtn");
						if(submitBtn) submitBtn.disabled = false;
					}
				})
				.catch(err => console.error("인증 상태 확인 실패", err));
		}, 3000);
	}
}

// verify.jsp에서 부모창에게 인증 성공 알림
window.setEmailVerified = function() {
	const resultSpan = document.getElementById("email-auth-result");
	if(resultSpan) {
		resultSpan.innerText = "이메일 인증 완료!";
		resultSpan.style.color = "green";
	}
};
