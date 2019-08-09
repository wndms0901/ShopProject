package shop.vo;

import java.sql.Timestamp;

public class Cart {
	protected String mbId;
	protected int pno;
	protected String pName;
	protected int price;
	protected int pQuantity;
	protected String pImage;
	protected int pStock;
	protected Timestamp cartRegisterDate;

	public String getMbId() {
		return mbId;
	}

	public void setMbId(String mbId) {
		this.mbId = mbId;
	}

	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getpQuantity() {
		return pQuantity;
	}

	public void setpQuantity(int pQuantity) {
		this.pQuantity = pQuantity;
	}

	public String getpImage() {
		return pImage;
	}

	public void setpImage(String pImage) {
		this.pImage = pImage;
	}

	public int getpStock() {
		return pStock;
	}

	public void setpStock(int pStock) {
		this.pStock = pStock;
	}

	public Timestamp getCartRegisterDate() {
		return cartRegisterDate;
	}

	public void setCartRegisterDate(Timestamp cartRegisterDate) {
		this.cartRegisterDate = cartRegisterDate;
	}

}
