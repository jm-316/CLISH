// ✅ 이메일 인증 모듈
export function initEmailAuth(emailInputId, buttonId, statusSpanId) {
	let emailCheckInterval = null;

	const emailInput = document.getElementById(emailInputId);
	const verifyBtn = document.getElementById(buttonId);
	const resultSpan = document.getElementById(statusSpanId);

	if (!emailInput || !verifyBtn || !resultSpan) {
		console.error("email_auth.js 초기화 실패: 요소 확인 필요");
		return;
	}

	// 이메일 인증 버튼 클릭 시
	verifyBtn.addEventListener("click", () => {
		const email = emailInput.value;
		if (!email) {
			alert("이메일을 입력하세요!");
			emailInput.focus();
			return;
		}

		fetch("/email/send", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify({ userEmail: email })
		})
			.then(res => res.text())
			.then(token => {
				if (token && token.length > 0) {
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

	// 인증 여부 확인 polling
	function startEmailPolling(email) {
		if (emailCheckInterval) clearInterval(emailCheckInterval);

		emailCheckInterval = setInterval(() => {
			fetch(`/email/check?email=${encodeURIComponent(email)}`)
				.then(res => res.json())
				.then(data => {
					if (data.verified) {
						resultSpan.innerText = "이메일 인증 완료!";
						resultSpan.style.color = "green";
						clearInterval(emailCheckInterval);
						console.log("✅ 이메일 인증 성공 → polling 중지");
					}
				})
				.catch(err => console.error("인증 상태 확인 실패", err));
		}, 3000);
	}
}

// ✅ verify.jsp에서 부모창에게 인증 성공 알림
window.setEmailVerified = function () {
	const resultSpan = document.getElementById("email-auth-result");
	if (resultSpan) {
		resultSpan.innerText = "이메일 인증 완료!";
		resultSpan.style.color = "green";
		console.log("✅ verify.jsp → 부모창 setEmailVerified 호출 성공");
	} else {
		console.warn("❌ email-auth-result 요소를 찾을 수 없음");
	}
};
