/**
 * 
 */

/**  Opens sub-navigation on hover  마우스를 올리면 하위 탐색이 열립니다. */
window.onload = () => {
	
	const flexItem2 = document.getElementById('flex-item2');
	const subNav = document.getElementById('sub-nav');
	
	flexItem2.addEventListener('mouseenter', () => {
	    subNav.style.display = 'flex';
	});
	subNav.addEventListener('mouseenter', () => {
	    subNav.style.display = 'flex';
	});
	subNav.addEventListener('mouseleave', () => {
	    subNav.style.display = 'none';
	});
	
	(function() {
		let timer;
 		let count = 600;
//		let count = 10;
		
			function updateCountdown() {
				let minutes = Math.floor(count / 60);
				let seconds = count % 60;
				let displayCount = 
					(minutes < 10 ? "0" + minutes : minutes) + ":"
					+ (seconds < 10 ? "0" + seconds : seconds);
				$("#countdow").text(displayCount);
				if(count > 0) {
					count--;
					
				}
				else {
					
					clearInterval(timer);
				}
			
			}
		timer = setInterval(updateCountdown, 1000);
		updateCountdown();
		});
		
//		item.addEventListener('mouseleave', () => {
//	
//		});
//		const links = document.querySelectorAll('#flex-item2 > li > a');
//		const surroundings = document.querySelectorAll('body > *:not(#flex-item2)');
//		
//		links.forEach(link => {
//		  link.addEventListener('mouseenter', () => {
//		    surroundings.forEach(el => el.classList.add('blur-background'));
//		  });
//		
//		  link.addEventListener('mouseleave', () => {
//		    surroundings.forEach(el => el.classList.remove('blur-background'));
//		  });
//		});
		

}		

function logout() {
	// confirm() 함수 활용하여 "로그아웃하시겠습니까?" 질문을 통해
	if(confirm("로그아웃하시겠습니까?")) {
		location.href = "/logout";
		
	}

}

//	document.addEventListener("DOMContentLoaded", () => {
////		
//			const track = document.querySelector(".carousel-track"); //
//			const cards = document.querySelectorAll(".deconstructed-card");
//			const prevBtn = document.querySelector(".carousel-button.prev"); //
//			const nextBtn = document.querySelector(".carousel-button.next"); //
//			const dotsContainer = document.querySelector(".dots-container"); //
//			const carousels = document.querySelectorAll(".carousel");
////   		 carousels.forEach(carousel => {
////			dotsContainer.innerHTML = "";
//			
//			cards.forEach((_, index) => {
//				const dot = document.createElement("div");
//				dot.classList.add("dot");
//				if (index === 0) dot.classList.add("active");
//				dot.addEventListener("click", () => goToCard(index));
//				dotsContainer.appendChild(dot);
//			});
////		});
//		const dots = document.querySelectorAll(".dot");
////		const visibleCards = 4; // added
//		const cardWidth = cards[0].offsetWidth;
//		const cardMargin = 40;
//		const totalCardWidth = cardWidth + cardMargin;
//
//		let currentIndex = 0;
//
//		cards.forEach((card) => {
//			card.addEventListener("mousemove", (e) => {
//				const rect = card.getBoundingClientRect();
//				const x = (e.clientX - rect.left) / rect.width;
//				const y = (e.clientY - rect.top) / rect.height;
//				const xDeg = (y - 0.5) * 8;
//				const yDeg = (x - 0.5) * -8;
//				card.style.transform = `perspective(1200px) rotateX(${xDeg}deg) rotateY(${yDeg}deg)`;
//				const layers = card.querySelectorAll(".card-layer");
//				layers.forEach((layer, index) => {
//					const depth = 30 * (index + 1);
//					const translateZ = depth;
//					const offsetX = (x - 0.5) * 10 * (index + 1);
//					const offsetY = (y - 0.5) * 10 * (index + 1);
//					layer.style.transform = `translate3d(${offsetX}px, ${offsetY}px, ${translateZ}px)`;
//				});
//				const waveSvg = card.querySelector(".wave-svg");
//				if (waveSvg) {
//					const moveX = (x - 0.5) * -20;
//					const moveY = (y - 0.5) * -20;
//					waveSvg.style.transform = `translate(${moveX}px, ${moveY}px) scale(1.05)`;
//					const wavePaths = waveSvg.querySelectorAll("path:not(:first-child)");
//					wavePaths.forEach((path, index) => {
//						const factor = 1 + index * 0.5;
//						const waveX = moveX * factor * 0.5;
//						const waveY = moveY * factor * 0.3;
//						path.style.transform = `translate(${waveX}px, ${waveY}px)`;
//					});
//				}
//				const bgObjects = card.querySelectorAll(".bg-object");
//				bgObjects.forEach((obj, index) => {
//					const factorX = (index + 1) * 10;
//					const factorY = (index + 1) * 8;
//					const moveX = (x - 0.5) * factorX;
//					const moveY = (y - 0.5) * factorY;
//					if (obj.classList.contains("square")) {
//						obj.style.transform = `rotate(45deg) translate(${moveX}px, ${moveY}px)`;
//					} else if (obj.classList.contains("triangle")) {
//						obj.style.transform = `translate(calc(-50% + ${moveX}px), calc(-50% + ${moveY}px)) scale(1)`;
//					} else {
//						obj.style.transform = `translate(${moveX}px, ${moveY}px)`;
//					}
//				});
//			});
//
//			card.addEventListener("mouseleave", () => {
//				card.style.transform = "";
//				const layers = card.querySelectorAll(".card-layer");
//				layers.forEach((layer) => {
//					layer.style.transform = "";
//				});
//				const waveSvg = card.querySelector(".wave-svg");
//				if (waveSvg) {
//					waveSvg.style.transform = "";
//					const wavePaths = waveSvg.querySelectorAll("path:not(:first-child)");
//					wavePaths.forEach((path) => {
//						path.style.transform = "";
//					});
//				}
//				const bgObjects = card.querySelectorAll(".bg-object");
//				bgObjects.forEach((obj) => {
//					if (obj.classList.contains("square")) {
//						obj.style.transform = "rotate(45deg) translateY(-20px)";
//					} else if (obj.classList.contains("triangle")) {
//						obj.style.transform = "translate(-50%, -50%) scale(0.5)";
//					} else {
//						obj.style.transform = "translateY(20px)";
//					}
//				});
//			});
//		});
//		 
//		function goToCard(index) {
//			index = Math.max(0, Math.min(index, cards.length - 1));
////			index = Math.max(0, Math.min(index, cards.length - visibleCards));
//
//			currentIndex = index;
//			updateCarousel();
//		}
//
//		function updateCarousel() {
//			
//			const translateX = -currentIndex * totalCardWidth;
//
//			track.style.transform = `translateX(${translateX}px)`;
//
//			dots.forEach((dot, index) => {
//				dot.classList.toggle("active", index === currentIndex);
//			});
//		}
//
//		prevBtn.addEventListener("click", () => {
//			goToCard(currentIndex - 1);
////			goToCard(currentIndex - visibleCards);
//		});
//
//		nextBtn.addEventListener("click", () => {
//			goToCard(currentIndex + 1);
////			goToCard(currentIndex + visibleCards);
//		});
//
//		document.addEventListener("keydown", (e) => {
//			if (e.key === "ArrowLeft") {
//				goToCard(currentIndex - 1);
//			} else if (e.key === "ArrowRight") {
//				goToCard(currentIndex + 1);
//			}
//		});
//
//		let touchStartX = 0;
//		let touchEndX = 0;
//
//		track.addEventListener("touchstart", (e) => {
//			touchStartX = e.changedTouches[0].screenX;
//		});
//
//		track.addEventListener("touchend", (e) => {
//			touchEndX = e.changedTouches[0].screenX;
//			handleSwipe();
//		});
//
//		function handleSwipe() {
//			if (touchStartX - touchEndX > 50) {
//				goToCard(currentIndex + 1);
//			} else if (touchEndX - touchStartX > 50) {
//				goToCard(currentIndex - 1);
//			}
//		}
//
//		window.addEventListener("resize", () => {
//			const newCardWidth = cards[0].offsetWidth;
//			const newTotalCardWidth = newCardWidth + cardMargin;
//
//			const translateX = -currentIndex * newTotalCardWidth;
//			track.style.transition = "none";
//			track.style.transform = `translateX(${translateX}px)`;
//
//			setTimeout(() => {
//				track.style.transition = "transform 0.6s cubic-bezier(0.16, 1, 0.3, 1)";
//			}, 50);
//		});
//
//		updateCarousel();
//	
//	});
document.addEventListener("DOMContentLoaded", () => {
    const carousels = document.querySelectorAll(".carousel");

    carousels.forEach(carousel => {
        const track = carousel.querySelector(".carousel-track");
        const cards = track.querySelectorAll(".deconstructed-card");
        const prevBtn = carousel.querySelector(".carousel-button.prev");
        const nextBtn = carousel.querySelector(".carousel-button.next");
        const dotsContainer = carousel.querySelector(".dots-container");

        // Clear any existing dots to prevent duplicates
        if (dotsContainer) dotsContainer.innerHTML = "";

        // State for this carousel
        let currentIndex = 0;
        const cardWidth = cards[0]?.offsetWidth || 0;
        const cardMargin = 40;
        const totalCardWidth = cardWidth + cardMargin;

        // Create dots for this carousel
        const dots = [];
        cards.forEach((_, index) => {
            const dot = document.createElement("div");
            dot.classList.add("dot");
            if (index === 0) dot.classList.add("active");
            dot.addEventListener("click", () => goToCard(index));
            dotsContainer && dotsContainer.appendChild(dot);
            dots.push(dot);
        });

        function goToCard(index) {
            index = Math.max(0, Math.min(index, cards.length - 1));
            currentIndex = index;
            updateCarousel();
        }

        function updateCarousel() {
            const translateX = -currentIndex * totalCardWidth;
            track.style.transform = `translateX(${translateX}px)`;
            dots.forEach((dot, index) => {
                dot.classList.toggle("active", index === currentIndex);
            });
        }

        if (prevBtn) {
            prevBtn.addEventListener("click", () => {
                goToCard(currentIndex - 1);
            });
        }

        if (nextBtn) {
            nextBtn.addEventListener("click", () => {
                goToCard(currentIndex + 1);
            });
        }

//         Optional: Keyboard navigation per carousel (if desired)
         carousel.addEventListener("keydown", (e) => {
             if (e.key === "ArrowLeft") goToCard(currentIndex - 1);
             else if (e.key === "ArrowRight") goToCard(currentIndex + 1);
         });

        // Touch support per carousel
        let touchStartX = 0;
        let touchEndX = 0;

        track.addEventListener("touchstart", (e) => {
            touchStartX = e.changedTouches[0].screenX;
        });

        track.addEventListener("touchend", (e) => {
            touchEndX = e.changedTouches[0].screenX;
            handleSwipe();
        });

        function handleSwipe() {
            if (touchStartX - touchEndX > 50) {
                goToCard(currentIndex + 1);
            } else if (touchEndX - touchStartX > 50) {
                goToCard(currentIndex - 1);
            }
        }

        // Responsive: update card width on resize
        window.addEventListener("resize", () => {
            const newCardWidth = cards[0]?.offsetWidth || 0;
            const newTotalCardWidth = newCardWidth + cardMargin;
            const translateX = -currentIndex * newTotalCardWidth;
            track.style.transition = "none";
            track.style.transform = `translateX(${translateX}px)`;
            setTimeout(() => {
                track.style.transition = "transform 0.6s cubic-bezier(0.16, 1, 0.3, 1)";
            }, 50);
        });

        updateCarousel();
    });
});

