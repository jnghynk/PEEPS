package com.gnjk.post.mypost.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostEditRequest;
import com.gnjk.post.mypost.domain.PostFile;
import com.gnjk.post.mypost.domain.PostListView;
import com.gnjk.post.mypost.domain.PostWriteRequest;
import com.gnjk.post.mypost.service.PostDeleteService;
import com.gnjk.post.mypost.service.PostEditService;
import com.gnjk.post.mypost.service.PostListService;
import com.gnjk.post.mypost.service.PostUploadService;

@RestController
@RequestMapping("rest/member/post")
public class PostController {

	@Autowired
	private PostListService listService;
	@Autowired
	private PostUploadService uploadService;
	@Autowired
	private PostDeleteService deleteService;
	@Autowired
	private PostEditService editService;
	
	// 게시글 업로드
	@PostMapping("/upload")
	@ResponseBody
	public int uploadPost(PostWriteRequest writeRequest, HttpServletRequest request, Model model) {

		return uploadService.uploadPost(writeRequest, request, model);
	}

	// 게시글 리스트 출력
	@GetMapping("/list")
	public PostListView postList(@RequestParam(value = "p", defaultValue = "1") int page, Model model) {

//		model.addAttribute("listView", listService.getPostListView(page));

		return listService.getPostListView(page);
	}
	
	// 게시글 하나 출력
	@GetMapping("/detail")
	public Post getPostDetail(
			@RequestParam("idx") int postIdx
			) {
		return listService.getDetail(postIdx);
	}
	
	// 게시글의 이미지 출력
	@GetMapping("/detail/image")
	public List<PostFile> getPostDetailImgs(
			@RequestParam("idx") int postIdx
			){
		
		return listService.getDetailImgs(postIdx);
	}
	
	// 게시글 삭제 
	@GetMapping("/delete")
	public int deletePost(
			@RequestParam("idx") int postIdx
			) {
		
		return deleteService.deletePost(postIdx);
	}
	
	// 수정한 게시글 업데이트 
	@PostMapping("/edit")
//	@ResponseBody
	public int updatePost(
			PostEditRequest editRequest,
			HttpServletRequest request,
			Model model
			) {
		
		return editService.editPost(editRequest, request, model);
	}
	
	// 지도 리스트 출력
	@GetMapping("/map")
	public List<Post> mapList(HttpServletRequest request, Model model) {
		
		// test용 회원idx
		int midx = 1;
		
		return listService.getMapListView(midx);
	}
	
	// 지도로 주소별 게시글 리스트 출력
	@GetMapping("/postmaplist")
	public PostListView getMapPostList(
			@RequestParam Map<String, Object> param,
			HttpServletRequest request,
			Model model) {
			
		String mIdx = request.getParameter("memberidx");
		String pAddr = request.getParameter("postAdd");
			
		int memberIdx = Integer.parseInt(mIdx);
			
		return listService.getPostListByMapView(memberIdx, pAddr);
	}
		
	// 좋아요 
	@GetMapping("/likes")
	public Post updateLikes(
			HttpServletRequest request
			) {
		
		int postIdx = Integer.parseInt(request.getParameter("pIdx"));
		System.out.println("포스트인덱스 : "+postIdx);
		
		return listService.updateLikes(postIdx, request);
	}
	
	// 좋아요 여부
	@GetMapping("/likeChk")
	public Post getLikes(
			HttpServletRequest request
			) {
		
		int postIdx = Integer.parseInt(request.getParameter("pIdx"));
		System.out.println("포스트인덱스 : "+postIdx);
		
		return listService.getLikes(postIdx, request);
	}
	



}