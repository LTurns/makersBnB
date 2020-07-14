require 'picture'
require 'database_helpers'

describe Picture do
  describe '.create' do
    it 'submits a picture url to the database' do
      user_sign_in
      listing = Listing.create(name: 'Minerva', description: 'A really fun place on the surface of the sun', price: '25.00')
      picture = Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: "#{listing.id}")

      expect(listing.id).to eq picture.listing_id
      expect(picture.url).to eq 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg'
    end
  end

  describe '.update' do
    it 'updates a picture url' do
      user_sign_in
      listing = Listing.create(name: 'Minerva', description: 'A really fun place on the surface of the sun', price: '25.00')
      picture = Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: "#{listing.id}")

      updated_picture = Picture.update(url: 'https://live.staticflickr.com/8651/29886969203_d3d69bac5e_w.jpg', listing_id: "#{listing.id}")

      #expect(updated_picture.id).to eq picture.id
      expect(updated_picture.listing_id).to eq listing.id
      expect(updated_picture.url).to eq 'https://live.staticflickr.com/8651/29886969203_d3d69bac5e_w.jpg'
    end
  end

  describe '.delete' do
    it 'deletes picture from the database' do
      user_sign_in
      listing = Listing.create(name: 'Minerva', description: 'A really fun place on the surface of the sun', price: '25.00')
      picture = Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: "#{listing.id}")
      picture_1 = Picture.create(url: 'https://live.staticflickr.com/8651/29886969203_d3d69bac5e_w.jpg', listing_id: "#{listing.id}" )
      Picture.delete(listing_id: listing.id)
      search = DatabaseConnection.query("SELECT * FROM pictures WHERE listing_id = '#{listing.id}'")

      expect(search.first).to be nil 
    end
  end
end
