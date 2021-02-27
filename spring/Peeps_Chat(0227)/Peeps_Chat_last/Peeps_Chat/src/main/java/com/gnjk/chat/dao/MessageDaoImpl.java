package com.gnjk.chat.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gnjk.chat.domain.Message;

@Repository
public class MessageDaoImpl implements MessageDao {

	@Inject
	private SqlSession session;
	private static String namespace = "com.gnjk.chat.dao.mapper.mybatisMessageDao";

	@Override
	public void insertMessage(Message mes) throws Exception {

		session.insert(namespace + ".insertMessage", mes); 
	}

}
