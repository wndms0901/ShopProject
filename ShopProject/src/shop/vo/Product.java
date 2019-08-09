package shop.vo;

import java.sql.Timestamp;

public class Product {
	protected int pno;
	protected String highCtgryName;
	protected int mediumCtgryNo;
	protected String mediumCtgryName;
	protected String mediumCtgryCode;
	protected String lowCtgryName;
	protected String pName;
	protected String pCompany;
	protected int price;
	protected int pMileage;
	protected int pStock;
	protected int pBuyNum;
	protected String pStatus;
	protected String pImage;
	protected String pContent;
	protected Timestamp pRegisterDate;
	protected int pQuantity;
	protected int count;
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public String getHighCtgryName() {
		return highCtgryName;
	}
	public void setHighCtgryName(String highCtgryName) {
		this.highCtgryName = highCtgryName;
	}
	public int getMediumCtgryNo() {
		return mediumCtgryNo;
	}
	public void setMediumCtgryNo(int mediumCtgryNo) {
		this.mediumCtgryNo = mediumCtgryNo;
	}
	public String getMediumCtgryName() {
		return mediumCtgryName;
	}
	public void setMediumCtgryName(String mediumCtgryName) {
		this.mediumCtgryName = mediumCtgryName;
	}
	public String getMediumCtgryCode() {
		return mediumCtgryCode;
	}
	public void setMediumCtgryCode(String mediumCtgryCode) {
		this.mediumCtgryCode = mediumCtgryCode;
	}
	public String getLowCtgryName() {
		return lowCtgryName;
	}
	public void setLowCtgryName(String lowCtgryName) {
		this.lowCtgryName = lowCtgryName;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpCompany() {
		return pCompany;
	}
	public void setpCompany(String pCompany) {
		this.pCompany = pCompany;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getpMileage() {
		return pMileage;
	}
	public void setpMileage(int pMileage) {
		this.pMileage = pMileage;
	}
	public int getpStock() {
		return pStock;
	}
	public void setpStock(int pStock) {
		this.pStock = pStock;
	}
	public int getpBuyNum() {
		return pBuyNum;
	}
	public void setpBuyNum(int pBuyNum) {
		this.pBuyNum = pBuyNum;
	}
	public String getpStatus() {
		return pStatus;
	}
	public void setpStatus(String pStatus) {
		this.pStatus = pStatus;
	}
	public String getpImage() {
		return pImage;
	}
	public void setpImage(String pImage) {
		this.pImage = pImage;
	}
	public String getpContent() {
		return pContent;
	}
	public void setpContent(String pContent) {
		this.pContent = pContent;
	}
	public Timestamp getpRegisterDate() {
		return pRegisterDate;
	}
	public void setpRegisterDate(Timestamp pRegisterDate) {
		this.pRegisterDate = pRegisterDate;
	}
	public int getpQuantity() {
		return pQuantity;
	}
	public void setpQuantity(int pQuantity) {
		this.pQuantity = pQuantity;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}

}
