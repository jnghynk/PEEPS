package com.gnjk.chat.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gnjk.chat.domain.Alarm;

@Repository
public class AlarmDaoImpl implements AlarmDao {

	@Inject
	private SqlSession session;
	private static String namespace = "com.gnjk.chat.dao.mapper.mybatisAlarmDao";

	@Override
	public void insertAlarm(Alarm alarm) throws Exception {

		session.insert(namespace + ".insertAlarm", alarm); 
	}


}
