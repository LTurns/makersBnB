require 'pg'

class Booking

  attr_reader :id, :listing_id, :user_id, :book_from, :book_to

  def initialize(id:, listing_id:, user_id:, book_from:, book_to:)
    @id = id
    @listing_id = listing_id
    @user_id = user_id
    @book_from = book_from
    @book_to = book_to
  end

  def self.create(listing_id:, user_id:, book_from:, book_to:)
    result = DatabaseConnection.query("INSERT INTO bookings (listing_id, user_id, book_from, book_to) VALUES('#{listing_id}', '#{user_id}', '#{book_from}', '#{book_to}') RETURNING id, listing_id, user_id, book_from, book_to;")
    Booking.new(id: result[0]['id'], listing_id: result[0]['listing_id'], user_id: result[0]['user_id'], book_from: result[0]['book_from'], book_to: result[0]['book_to'])
  end
end
