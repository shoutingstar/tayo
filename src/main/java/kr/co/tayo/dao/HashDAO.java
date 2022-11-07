package kr.co.tayo.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.tayo.dto.HashDTO;

public interface HashDAO {

	

	ArrayList<HashDTO> hashlist();



	ArrayList<HashDTO> list();

	int delete(String id);


	int write(HashMap<String, String> params);



	


	int update(HashMap<String, String> params);



	HashDTO Form(HashMap<String, String> ha_num);



	ArrayList<HashDTO> search(HashMap<String, String> param); 

	/*
	 * ArrayList<HashDTO> search(String param);
	 */

}
