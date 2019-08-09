package shop.vo;

import java.sql.Date;

public class Mileage {
	protected String mbId;
	protected int mileage;
	protected String orderId;
	protected String content;
	protected Date mileageDate;

	public String getMbId() {
		return mbId;
	}

	public void setMbId(String mbId) {
		this.mbId = mbId;
	}

	public int getMileage() {
		return mileage;
	}

	public void setMileage(int mileage) {
		this.mileage = mileage;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getMileageDate() {
		return mileageDate;
	}

	public void setMileageDate(Date mileageDate) {
		this.mileageDate = mileageDate;
	}

}
