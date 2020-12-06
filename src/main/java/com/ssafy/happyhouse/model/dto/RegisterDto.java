package com.ssafy.happyhouse.model.dto;

public class RegisterDto {
	private String userid;
	private String userpwd;
	private String confirm;
    private String nickname;
    private String email;
    private String sido;
    private String gugun;
    private boolean admin;

    public RegisterDto() {}

    public RegisterDto(String userid, String userpwd, String confirm, String nickname, String email, String sido,
			String gugun, boolean admin) {
		this.userid = userid;
		this.userpwd = userpwd;
		this.confirm = confirm;
		this.nickname = nickname;
		this.email = email;
		this.sido = sido;
		this.gugun = gugun;
		this.admin = admin;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserpwd() {
		return userpwd;
	}

	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSido() {
		return sido;
	}

	public void setSido(String sido) {
		this.sido = sido;
	}

	public String getGugun() {
		return gugun;
	}

	public void setGugun(String gugun) {
		this.gugun = gugun;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public MemberDto toMember() {
        return new MemberDto(this.getUserid(), this.getUserpwd(), this.getNickname(), this.getEmail(), this.getSido(), this.getGugun(), this.isAdmin());
    }

	@Override
	public String toString() {
		return "RegisterDto [userid=" + userid + ", userpwd=" + userpwd + ", confirm=" + confirm + ", nickname="
				+ nickname + ", email=" + email + ", sido=" + sido + ", gugun=" + gugun + ", admin=" + admin + "]";
	}
}
