package shop.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class Member {
	protected String mbId; // 아이디
	protected String mbPwd; // 비밀번호
	protected Timestamp mbPwdDate; // 비밀번호 변경일
	protected String mbName; // 이름
	protected String mbEmail; // 이메일
	protected Date mbBirth; // 생일
	protected String mbTel; // 전화번호
	protected String mbPhone; // 폰번호
	protected String mbZip; // 우편번호
	protected String mbAddr1; // 기본주소
	protected String mbAddr2; // 상세주소
	protected int mbMileage; // 적립금
	protected Timestamp mbLoginTime; // 마지막 로그인시간
	protected Timestamp mbRegisterDate; // 가입일
	protected String mbMemo; // 메모

	public String getMbId() {
		return mbId;
	}

	public void setMbId(String mbId) {
		this.mbId = mbId;
	}

	public String getMbPwd() {
		return mbPwd;
	}

	public void setMbPwd(String mbPwd) {
		this.mbPwd = mbPwd;
	}

	public Timestamp getMbPwdDate() {
		return mbPwdDate;
	}

	public void setMbPwdDate(Timestamp mbPwdDate) {
		this.mbPwdDate = mbPwdDate;
	}

	public String getMbName() {
		return mbName;
	}

	public void setMbName(String mbName) {
		this.mbName = mbName;
	}

	public String getMbEmail() {
		return mbEmail;
	}

	public void setMbEmail(String mbEmail) {
		this.mbEmail = mbEmail;
	}

	public Date getMbBirth() {
		return mbBirth;
	}

	public void setMbBirth(Date mbBirth) {
		this.mbBirth = mbBirth;
	}

	public String getMbTel() {
		return mbTel;
	}

	public void setMbTel(String mbTel) {
		this.mbTel = mbTel;
	}

	public String getMbPhone() {
		return mbPhone;
	}

	public void setMbPhone(String mbPhone) {
		this.mbPhone = mbPhone;
	}

	public String getMbZip() {
		return mbZip;
	}

	public void setMbZip(String mbZip) {
		this.mbZip = mbZip;
	}

	public String getMbAddr1() {
		return mbAddr1;
	}

	public void setMbAddr1(String mbAddr1) {
		this.mbAddr1 = mbAddr1;
	}

	public String getMbAddr2() {
		return mbAddr2;
	}

	public void setMbAddr2(String mbAddr2) {
		this.mbAddr2 = mbAddr2;
	}

	public int getMbMileage() {
		return mbMileage;
	}

	public void setMbMileage(int mbMileage) {
		this.mbMileage = mbMileage;
	}

	public Timestamp getMbLoginTime() {
		return mbLoginTime;
	}

	public void setMbLoginTime(Timestamp mbLoginTime) {
		this.mbLoginTime = mbLoginTime;
	}

	public Timestamp getMbRegisterDate() {
		return mbRegisterDate;
	}

	public void setMbRegisterDate(Timestamp mbRegisterDate) {
		this.mbRegisterDate = mbRegisterDate;
	}

	public String getMbMemo() {
		return mbMemo;
	}

	public void setMbMemo(String mbMemo) {
		this.mbMemo = mbMemo;
	}

}
