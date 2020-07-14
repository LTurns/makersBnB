require 'user'
require 'database_helpers'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(
        email: 'email@email.com',
        password: 'Password123',
        username: 'username'
      )
      persisted_data = persisted_data(table: :users, id: user.id)

      expect(user).to be_a User
      expect(user.id).to eq persisted_data.first['id']
      expect(user.email).to eq 'email@email.com'
      expect(user.username).to eq 'username'
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('Password123')

      User.create(
        email: 'email@email.com',
        password: 'Password123',
        username: 'username'
      )
    end
  end

  describe '.find' do
    it 'finds a user by ID' do
      user = User.create(
        email: 'email@email.com',
        password: 'Password123',
        username: 'username'
      )
      result = User.find(id: user.id)

      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
      expect(result.username).to eq user.username
    end

    it 'returns nil if there is no ID given' do
      expect(User.find(id: nil)).to eq nil
    end
  end

    describe '.authenticate' do
      it 'returns a user if the credentials match' do
        user = User.create(username: 'username', email: 'email@email.com', password: 'test_password')
        authenticated_user = User.authenticate(username: 'username',password: 'test_password')

        expect(authenticated_user.id).to eq user.id
      end

      it 'returns nil given an incorrect username' do
        user = User.create(username: 'username', email: 'email@email.com', password: 'test_password')
        authenticated_user = User.authenticate(username: 'wrong_username', password: 'test_password')

        expect(authenticated_user).to be_nil
      end

      it 'returns nil given an incorrect password' do
        user = User.create(username: 'username', email: 'email@email.com', password: 'test_password')
        authenticated_user = User.authenticate(username: 'username', password: 'wrong_password')

        expect(authenticated_user).to be_nil
      end

      it 'sets current user' do
        user = User.create(username: 'username', email: 'email@email.com', password: 'test_password')
        authenticated_user = User.authenticate(username: 'username',password: 'test_password')

        expect(User.current_user).to eq authenticated_user
      end
    end

    describe '.current_user' do
      it 'sets current user' do
        user = User.create(username: 'username', email: 'email@email.com', password: 'test_password')
        authenticated_user = User.authenticate(username: 'username',password: 'test_password')

        expect(User.current_user).to eq authenticated_user
      end

      it 'resets current user after sign out' do
        user = User.create(username: 'username', email: 'email@email.com', password: 'test_password')
        authenticated_user = User.authenticate(username: 'username',password: 'test_password')
        User.sign_out

        expect(User.current_user).to eq nil
      end
    end

  describe '#listings' do
    it 'gets a array of all listings of a particular user' do
      user = User.create(username: 'username', email: 'email@email.com', password: 'test_password')
      authenticated_user = User.authenticate(username: 'username',password: 'test_password')
      listing = Listing.create(name: 'Boat House', description: 'A boat house on the shores of lake Loch Ness', price: '35.00')
      listings = authenticated_user.listings

      expect(listings.length).to eq (1)
      expect(listings.first.name).to eq("Boat House")
      expect(listings.first.description).to eq("A boat house on the shores of lake Loch Ness")
      expect(listings.first.price).to eq("35.00")
    end
  end
end
