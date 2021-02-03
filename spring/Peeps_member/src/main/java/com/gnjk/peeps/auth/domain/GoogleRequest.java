package com.gnjk.peeps.auth.domain;

import com.gnjk.peeps.domain.Peeps;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Builder
public class GoogleRequest {

	private String clientId;
	private String clientSecret;
	private String redirectUri;
	private String grantType;
	private String code;
	private String email;
	private String picture;
	private String name;

}
