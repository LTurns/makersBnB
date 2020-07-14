require 'pg'

class Available_Dates

  attr_reader :id, :listing_id, :date_start, :date_end

  def initialize(id:, listing_id:, date_start:, date_end:)
    @id = id
    @listing_id = listing_id
    @date_start = date_start
    @date_end = date_end
  end

  def self.create(listing_id:, date_start:, date_end:)
    result = DatabaseConnection.query("INSERT INTO available_dates (listing_id, date_start, date_end) VALUES('#{listing_id}', '#{date_start}', '#{date_end}') RETURNING id, listing_id, date_start, date_end;")
    Available_Dates.new(id: result[0]['id'], listing_id: result[0]['listing_id'], date_start: result[0]['date_start'], date_end: result[0]['date_end'])
  end
end
