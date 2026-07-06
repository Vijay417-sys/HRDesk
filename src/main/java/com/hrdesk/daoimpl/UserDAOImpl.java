package com.hrdesk.daoimpl;

import java.util.List;

import com.hrdesk.dao.UserDAO;
import com.hrdesk.dto.User;

public class UserDAOImpl implements UserDAO {

	@Override
	public boolean registerUser(User user) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public User login(String username, String password) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean updateUser(User user) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteUser(int userId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public User getUserById(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return null;
	}

}
