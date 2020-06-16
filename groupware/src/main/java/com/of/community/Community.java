package com.of.community;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Community {
	private int listNum, commuNum;
	private String clubCode;
	private String clubType;
	private String title;
	private String writer;
	private String name;
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	private String content;
	private String created; 
	private int hitCount;

	private int fileNum;
	private String originalFilename, saveFilename;	
	private int fileCount;
	
	// 스프링에서 파일 받기
	// 하나만 받을 경우 : MultipartFile upload;
	private List<MultipartFile> upload; // <input type="file" name="upload"

	private long gap;

	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
	}

	public int getCommuNum() {
		return commuNum;
	}

	public void setCommuNum(int commuNum) {
		this.commuNum = commuNum;
	}

	public String getClubCode() {
		return clubCode;
	}

	public void setClubCode(String clubCode) {
		this.clubCode = clubCode;
	}	

	public String getClubType() {
		return clubType;
	}

	public void setClubType(String clubType) {
		this.clubType = clubType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreated() {
		return created;
	}

	public void setCreated(String created) {
		this.created = created;
	}

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public int getFileNum() {
		return fileNum;
	}

	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public String getSaveFilename() {
		return saveFilename;
	}

	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}

	public int getFileCount() {
		return fileCount;
	}

	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}

	public List<MultipartFile> getUpload() {
		return upload;
	}

	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}

	public long getGap() {
		return gap;
	}

	public void setGap(long gap) {
		this.gap = gap;
	}

	@Override
	public String toString() {
		return "Community [listNum=" + listNum + ", commuNum=" + commuNum + ", clubCode=" + clubCode + ", clubType="
				+ clubType + ", title=" + title + ", writer=" + writer + ", content=" + content + ", created=" + created
				+ ", hitCount=" + hitCount + ", fileNum=" + fileNum + ", originalFilename=" + originalFilename
				+ ", saveFilename=" + saveFilename + ", fileCount=" + fileCount + ", upload=" + upload + ", gap=" + gap
				+ "]";
	}	
}
