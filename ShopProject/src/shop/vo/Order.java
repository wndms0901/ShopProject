package shop.vo;

import java.sql.Timestamp;

public class Order {
	protected int orderNo;
	protected String orderId;
	protected String mbId;
	protected int productsCount;
	protected String buyerName;
	protected String buyerEmail;
	protected String buyerPhone;
	protected String buyerTel;
	protected String recipientName;
	protected String recipientZip;
	protected String recipientAddr1;
	protected String recipientAddr2;
	protected String recipientTel;
	protected String recipientPhone;
	protected String orderMessage;
	protected int productAmount;
	protected int finalAmount;
	protected String payType;
	protected String bankName;
	protected String depositName;
	protected Timestamp depositDate;
	protected String orderState;
	protected Timestamp orderDate;
	protected int mileageUse;
	protected int mileageAdd;
	protected String accountNumber;

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getMbId() {
		return mbId;
	}

	public void setMbId(String mbId) {
		this.mbId = mbId;
	}

	public int getProductsCount() {
		return productsCount;
	}

	public void setProductsCount(int productsCount) {
		this.productsCount = productsCount;
	}

	public String getBuyerName() {
		return buyerName;
	}

	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}

	public String getBuyerEmail() {
		return buyerEmail;
	}

	public void setBuyerEmail(String buyerEmail) {
		this.buyerEmail = buyerEmail;
	}

	public String getBuyerPhone() {
		return buyerPhone;
	}

	public void setBuyerPhone(String buyerPhone) {
		this.buyerPhone = buyerPhone;
	}

	public String getBuyerTel() {
		return buyerTel;
	}

	public void setBuyerTel(String buyerTel) {
		this.buyerTel = buyerTel;
	}

	public String getRecipientName() {
		return recipientName;
	}

	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}

	public String getRecipientZip() {
		return recipientZip;
	}

	public void setRecipientZip(String recipientZip) {
		this.recipientZip = recipientZip;
	}

	public String getRecipientAddr1() {
		return recipientAddr1;
	}

	public void setRecipientAddr1(String recipientAddr1) {
		this.recipientAddr1 = recipientAddr1;
	}

	public String getRecipientAddr2() {
		return recipientAddr2;
	}

	public void setRecipientAddr2(String recipientAddr2) {
		this.recipientAddr2 = recipientAddr2;
	}

	public String getRecipientTel() {
		return recipientTel;
	}

	public void setRecipientTel(String recipientTel) {
		this.recipientTel = recipientTel;
	}

	public String getRecipientPhone() {
		return recipientPhone;
	}

	public void setRecipientPhone(String recipientPhone) {
		this.recipientPhone = recipientPhone;
	}

	public String getOrderMessage() {
		return orderMessage;
	}

	public void setOrderMessage(String orderMessage) {
		this.orderMessage = orderMessage;
	}

	public int getProductAmount() {
		return productAmount;
	}

	public void setProductAmount(int productAmount) {
		this.productAmount = productAmount;
	}

	public int getFinalAmount() {
		return finalAmount;
	}

	public void setFinalAmount(int finalAmount) {
		this.finalAmount = finalAmount;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getDepositName() {
		return depositName;
	}

	public void setDepositName(String depositName) {
		this.depositName = depositName;
	}

	public Timestamp getDepositDate() {
		return depositDate;
	}

	public void setDepositDate(Timestamp depositDate) {
		this.depositDate = depositDate;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public Timestamp getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}

	public int getMileageUse() {
		return mileageUse;
	}

	public void setMileageUse(int mileageUse) {
		this.mileageUse = mileageUse;
	}

	public int getMileageAdd() {
		return mileageAdd;
	}

	public void setMileageAdd(int mileageAdd) {
		this.mileageAdd = mileageAdd;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

}
