require 'pg'

def persisted_data(id:, table:)
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.query("SELECT * FROM #{table} WHERE id = #{id};")
end

def user_sign_in
  user = User.create(username: 'username', email: 'email@email.com', password: 'test_password')
  authenticated_user = User.authenticate(username: 'username',password: 'test_password')
end
