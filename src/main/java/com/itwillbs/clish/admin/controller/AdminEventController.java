package com.itwillbs.clish.admin.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.clish.admin.dto.EventDTO;
import com.itwillbs.clish.admin.service.AdminEventService;
import com.itwillbs.clish.common.dto.PageInfoDTO;
import com.itwillbs.clish.common.utils.PageUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("admin")
@RequiredArgsConstructor
public class AdminEventController {
	private final AdminEventService adminEventService;

	// 이벤트 리스트
	@GetMapping("/event")
	public String eventList(Model model, @RequestParam(defaultValue = "1") int pageNum) {
		int listLimit = 5;
		int eventCount = adminEventService.getEventCount();
		
		if (eventCount > 0) {
			PageInfoDTO pageInfoDTO = PageUtil.paging(listLimit, eventCount, pageNum, 3);
			
			if (pageNum < 1 || pageNum > pageInfoDTO.getMaxPage()) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "/admin/event/notice_list");
				return "commons/result_process";
			}
			model.addAttribute("pageInfo", pageInfoDTO);
			
			List<EventDTO> eventList = adminEventService.getEvents(pageInfoDTO.getStartRow(), listLimit);
			model.addAttribute("eventList", eventList);
		}
		
		return "/admin/event/event_list";
	}
	
	// 이벤트 등록 페이지
	@GetMapping("/event/write")
	public String eventWriteForm() {
		return "/admin/event/event_write_form";
	}
	
	// 이벤트 등록
	@PostMapping("/event/write")
	public String eventWrite(EventDTO eventDTO,  RedirectAttributes rttr) throws IllegalStateException, IOException {
		int insert = adminEventService.registEvent(eventDTO);
		
		if (insert > 0) {
			rttr.addFlashAttribute("msg", "이벤트가 등록되었습니다.");
		} else {
			rttr.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "redirect:/admin/event";
	}
	
}
