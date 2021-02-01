package com.gnjk.chat.handler;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.gnjk.chat.domain.Message;
import com.google.gson.Gson;

public class ChattingHandler extends TextWebSocketHandler {

	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);
	
	// session 저장 (연결된 세션 리스트)
	private List<WebSocketSession> connectedSessionList = new ArrayList<WebSocketSession>();
	
	//client 접속 -------------------------- 
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		String friend = (String) session.getAttributes().get("user");
		
		// 접속한 세션 정보 리스트에 저장 
		connectedSessionList.add(session);
		
		logger.info(session.getId()+"("+friend +")"+ "님이 접속하였습니다.");  // 채팅 구현할 때는 지우기
	}
	
	
	// 메세지 전송 ------------------------ (추가 수정 필요) 
	@Override
	protected void handleTextMessage (WebSocketSession session, TextMessage message)  throws Exception {          
		
		System.out.println(message.getPayload()); // 나중에 삭제 
		
		String friend = (String) session.getAttributes().get("user");
	
		// Json -> java 객체 
		Gson gson = new Gson();
		Message mes = gson.fromJson( message.getPayload(), Message.class);
		System.out.println(mes);
		
		// 전달 메세지_ 메세지객체 -> Json 
		TextMessage sendmessge = new TextMessage(gson.toJson(mes));
		
		// 메세지 보내기 
		for(WebSocketSession sockSession : connectedSessionList) {
			sockSession.sendMessage(sendmessge);
		}
		
	}
	
	
	// client 접속 종료 --------------------------
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		String friend = (String) session.getAttributes().get("user");
		
		logger.info(session.getId()+"("+friend +")"+ "님이 접속을 종료하였습니다.");  // 나중에 삭제 
		
		// 세션 삭제
		connectedSessionList.remove(session);
	}
	
	
	// 전송 오류 메세지 ------------------------------------
	@Override
	public void handleTransportError (WebSocketSession session, Throwable exception)throws Exception {
		
		logger.info(session.getId() + "오류 발생 :" + exception.getMessage());
		
	}
	
}

