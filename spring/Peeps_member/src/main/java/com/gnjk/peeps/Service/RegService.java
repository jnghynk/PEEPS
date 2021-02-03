package com.gnjk.peeps.Service;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.Peeps;
import com.gnjk.peeps.domain.RegRequest;

@Service
public class RegService {

	private PeepsDao dao;

	@Autowired
	private SqlSessionTemplate template;

	@Autowired
	private MailSenderService mailSenderService;

	// 파일을 업로드, 데이터베이스 저장
	@Transactional
	public int memberReg(RegRequest regRequest, HttpServletRequest request) {

		int result = 0;

		Peeps peeps = regRequest.toPeeps();

		try {
			// 데이터 베이스 입력
			dao = template.getMapper(PeepsDao.class);

			// 회원 DB insert
			result = dao.insertMember(peeps);

			// 메일발송
			int mailsendCnt = mailSenderService.send(peeps);
			System.out.println(mailsendCnt + "통의 메일이 발송되었습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
