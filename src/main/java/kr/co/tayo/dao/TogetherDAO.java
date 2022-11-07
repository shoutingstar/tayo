package kr.co.tayo.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.tayo.dto.TogetherDTO;

public interface TogetherDAO {

	ArrayList<TogetherDTO> list(int offset);

	void write(HashMap<String, String> params);

	TogetherDTO detail(String num);

	void upHit(String num);

	void update(HashMap<String, String> params);

	void delete(String num);

	int totalCount();
	
}
