require 'listing'
require './lib/user.rb'
require 'database_helpers'

describe Listing do
    describe '.all' do
      it 'shows all the listings' do
        user_sign_in
        listing = Listing.create(name: 'Minerva', description: 'A tiny house in the middle nowhere', price: '10.50')
        Listing.create(name: 'Boat House', description: 'A boat house on the shores of lake Loch Ness', price: '35.00')

        listings = Listing.all

        expect(listings.length).to eq 2
        expect(listings.first).to be_a Listing
        expect(listings.first.id).to eq listing.id
        expect(listings.first.name).to include "Minerva"
        expect(listings.first.description).to include "A tiny house in the middle nowhere"
        expect(listings.first.price).to include "10.50"
      end
    end

    describe '.create' do
      it 'lets a user create a new listing' do
        user_sign_in
        listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
        persisted_data = persisted_data(table: :listings, id: listing.id)

        expect(listing).to be_a Listing
        expect(listing.id).to eq persisted_data.first['id']
        expect(listing.name).to include "Village House"
        expect(listing.description).to include "Lovely cottage in the countryside"
        expect(listing.price).to include "50.00"
      end

    it 'accesses the user_id from the user table' do
      user_sign_in
      listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
      expect(listing.user_id).to eq(User.current_user.id)
    end
  end 

    describe '.find' do
      it 'lets the user view listing in full' do
        user_sign_in
        listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')

        result = Listing.find(id: "#{listing.id}")

        expect(result.id).to eq listing.id
        expect(result.name).to eq "Village House"
        expect(result.description).to eq "Lovely cottage in the countryside"
        expect(result.price).to eq "50.00"
      end
    end

    describe '#pictures' do
      it 'integrates pictures to the listing' do
        user_sign_in
        listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
        Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: "#{listing.id}")

        picture = listing.pictures.first

        expect(picture['listing_id']).to eq listing.id
      end
    end


    describe '#available_dates' do 
      it 'intergrates available dates to the listing' do 
        user_sign_in
        listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
        Available_Dates.create(listing_id: "#{listing.id}", date_start: "2020-05-04", date_end: "2020-05-05")

        available = listing.available_dates.first 

        expect(available["date_start"]).to eq "2020-05-04"
        expect(available["date_end"]).to eq "2020-05-05"
      end 
    end 

  describe '.update' do
    it 'updates a listing' do
      user_sign_in
      listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')
      # Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: "#{listing.id}")

      updated_listing = Listing.update(id: listing.id, name: 'Cat House', description: 'Big fun house', price: '35.00')

      expect(updated_listing.id).to eq listing.id
      expect(updated_listing.name).to eq 'Cat House'
      expect(updated_listing.description).to eq 'Big fun house'
      expect(updated_listing.price).to eq '35.00'
    end
  end

  describe '.delete' do
    it 'deletes user listings' do
      user_sign_in
      listing = Listing.create(name: 'Village House', description: 'Lovely cottage in the countryside', price: '50.00')

      Listing.delete(id: listing.id)

      expect(Listing.all.length).to eq 0
    end
  end
end
