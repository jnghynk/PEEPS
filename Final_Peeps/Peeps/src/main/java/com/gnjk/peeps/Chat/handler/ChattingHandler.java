package com.gnjk.peeps.Chat.handler;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.gnjk.peeps.Member.dao.MessageDao;
import com.gnjk.peeps.Member.domain.Message;
import com.google.gson.Gson;

// 웹소켓 핸들러 
@CrossOrigin("*")
public class ChattingHandler extends TextWebSocketHandler {

	private void log(String logmsg) {
		System.out.println(new Date() + " : " +logmsg);
	}

	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);

	private List<WebSocketSession> connectedSessionList;
	
	public ChattingHandler() {
		connectedSessionList = new ArrayList<WebSocketSession>();
	}

	// 웹소켓 세션 저장
	private Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
	
	@Autowired
	private MessageDao dao;
	
	
	// client가 접속하면 afterConnectionEstablished 메서드 호출 
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		String sessionId  = (String) session.getId();

		users.put(sessionId , session);
		connectedSessionList.add(session);

		// 연결 확인 
		logger.info("{} 연결되었습니다.", session.getId()+":"+ sessionId);

		log(session.getId() + " getId() 연결 성공 ");

	}


	// client가 메세지를 보내면 handleTextMessage 메서드 호출 
	@Override
	protected void handleTextMessage (WebSocketSession session, TextMessage message) throws Exception {          

		String sessionId  = (String) session.getId();

		logger.info("{}로 부터 {}를 전달 받았습니다.", sessionId , message.getPayload());

		Gson gson = new Gson();
		
		Message mes = gson.fromJson(message.getPayload(), Message.class);

		TextMessage sendmes = new TextMessage(gson.toJson(mes));

		System.out.println("sendmes : " + sendmes);

		// 웹소켓 연결됐을 때
		for(WebSocketSession sockSession : connectedSessionList) {	 
			sockSession.sendMessage(sendmes);
		}

		dao.insertMessage(mes);

	}
	
	
	// client가 웹페이지를 벗어나거나 채팅을 나가면 afterConnectionClosed 메서드 호출 (접속 종료)
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		String sessionId  = (String) session.getId();   // "m_idx"
		
		log(session.getId() + " 연결 종료 " + sessionId );

		connectedSessionList.remove(session);
		
		users.remove(session.getId());

		logger.info("{} 연결이 끊김", session.getId()+ sessionId );
		
		System.out.println("채팅 퇴장 : " + sessionId );
	}

	
	// 에러 발생 시 실행 될 메서드
	@Override
	public void handleTransportError (WebSocketSession session, Throwable exception) throws Exception {

		log(session.getId() + "exception 발생 : " + exception.getMessage());

	}


}