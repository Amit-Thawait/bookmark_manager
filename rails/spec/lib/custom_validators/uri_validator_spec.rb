require 'rails_helper'
require "#{Rails.root}/lib/custom_validators/uri_validator"

# Source: http://gist.github.com/bf4/5320847
# spec/validators/uri_validator_spec.rb
describe UriValidator do

  let(:bookmark) { FactoryGirl.create(:bookmark) }

  it "should be valid for a valid http url" do
    bookmark.url = 'http://www.google.com'
    bookmark.valid?
    expect(bookmark.errors.full_messages).to eq([])
  end

  ['http://.com', 'http://ftp://ftp.google.com', 'http://ssh://google.com'].each do |invalid_url|
    it "#{invalid_url.inspect} is a invalid http url" do
      bookmark.url = invalid_url
      bookmark.valid?
      expect(bookmark.errors.full_messages).to eq([])
    end
  end

  ['http:/www.google.com', '<>hi', 'http://google'].each do |invalid_url|
    it "#{invalid_url.inspect} is an invalid url" do
      bookmark.url = invalid_url
      bookmark.valid?
      expect(bookmark.errors.keys).to include(:url)
      expect(bookmark.errors[:url]).to include("is an invalid URL")
    end
  end

  ['www.google.com','google.com'].each do |valid_url|
    it "#{valid_url.inspect} is a valid url" do
      bookmark.url = valid_url
      expect(bookmark.valid?).to be true
      expect(bookmark.errors.full_messages).to eq([])
    end
  end

  ['ftp://ftp.google.com','ssh://google.com'].each do |invalid_url|
    it "#{invalid_url.inspect} is an invalid url" do
      bookmark.url = invalid_url
      bookmark.valid?
      expect(bookmark.errors).to include(:url)
      expect(bookmark.errors[:url]).to include("must begin with http or https")
    end
  end
end