package com.gnjk.post.mypost.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.post.mypost.domain.Comment;
import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.service.TimeLineService;

@RestController
@CrossOrigin(origins = "*")
public class CrossOriginController {
	
	@Autowired
	private TimeLineService timeLineService;
	
	// 타임라인 게시물 리스트
	@GetMapping("/user/PostList")
	public List<Post> PostList(int member_idx) {
		
		System.out.println("포스트 컨트롤러");
		System.out.println(member_idx);
		
		return timeLineService.PostList(member_idx);
	}
	
	// 타임라인 댓글 리스트
	@GetMapping("/user/CmtList")
	public List<Comment> CmtList(int post_idx) {
		
		System.out.println("댓글 컨트롤러");
		System.out.println(post_idx);
		
		return timeLineService.CmtList(post_idx);
	}


}
