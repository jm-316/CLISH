package com.itwillbs.clish.common.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.itwillbs.clish.myPage.service.MyPageService;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Component
@AllArgsConstructor
public class SchedulerController {
	private final SchedulerService schedulerService;
	
//    @Scheduled(fixedDelay = 3000) // 작업 종료 후 3000ms(3초) 대기 후 재실행
//    public void printEvery3Seconds() {
//    	schedulerService.checkReservation();
//    	schedulerService.checkClassEndDate();
//    }
    
    @Scheduled(cron = "0 */15 * * * ?")
    public void deleteExpiredReservations() {
    	schedulerService.checkReservation();
    	schedulerService.checkClassEndDate();
    }
    
    
    
}
