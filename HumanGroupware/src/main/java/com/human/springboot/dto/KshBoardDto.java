package com.human.springboot.dto;

import lombok.Data;

@Data
public class KshBoardDto {
    // board 
    private int board_id;
    private String board_title;
    private String board_content;
    private int board_writer;
    private String board_created;
    private String board_updated;
    private int board_hit;
    private String board_file_name;
    private String board_file_path;
    private int board_comment;
    private int notice_no;
    private int free_no;

    public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public int getBoard_writer() {
		return board_writer;
	}

	public void setBoard_writer(int board_writer) {
		this.board_writer = board_writer;
	}

	public String getBoard_created() {
		return board_created;
	}

	public void setBoard_created(String board_created) {
		this.board_created = board_created;
	}

	public String getBoard_updated() {
		return board_updated;
	}

	public void setBoard_updated(String board_updated) {
		this.board_updated = board_updated;
	}

	public int getBoard_hit() {
		return board_hit;
	}

	public void setBoard_hit(int board_hit) {
		this.board_hit = board_hit;
	}

	public String getBoard_file_name() {
		return board_file_name;
	}

	public void setBoard_file_name(String board_file_name) {
		this.board_file_name = board_file_name;
	}

	public String getBoard_file_path() {
		return board_file_path;
	}

	public void setBoard_file_path(String board_file_path) {
		this.board_file_path = board_file_path;
	}

	public int getBoard_comment() {
		return board_comment;
	}

	public void setBoard_comment(int board_comment) {
		this.board_comment = board_comment;
	}

	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public int getFree_no() {
		return free_no;
	}

	public void setFree_no(int free_no) {
		this.free_no = free_no;
	}

	public int getBoard_category() {
		return board_category;
	}

	public void setBoard_category(int board_category) {
		this.board_category = board_category;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	// board_category
    private int board_category;
    private String category_name;

    private String emp_name;  
}
