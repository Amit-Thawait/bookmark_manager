require 'rails_helper'
require "#{Rails.root}/lib/custom_validators/uri_validator"

# Source: http://gist.github.com/bf4/5320847
# spec/validators/uri_validator_spec.rb
describe UriValidator do
  subject do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :url
      validates :url, uri: { allowed_protocols: ['http', 'https'], disallowed_protocols: ['ftp', 'ssh']}
    end.new
  end

  it "should be valid for a valid http url" do
    subject.url = 'http://www.google.com'
    subject.valid?
    expect(subject.errors.full_messages).to eq([])
  end

  ['http://google', 'http://.com', 'http://ftp://ftp.google.com', 'http://ssh://google.com'].each do |invalid_url|
    it "#{invalid_url.inspect} is a invalid http url" do
      subject.url = invalid_url
      subject.valid?
      expect(subject.errors.full_messages).to eq([])
    end
  end

  ['http:/www.google.com','<>hi'].each do |invalid_url|
    it "#{invalid_url.inspect} is an invalid url" do
      subject.url = invalid_url
      subject.valid?
      expect(subject.errors.keys).to include(:url)
      expect(subject.errors[:url]).to include("is an invalid URL")
    end
  end

  ['www.google.com','google.com'].each do |valid_url|
    it "#{valid_url.inspect} is a valid url" do
      subject.url = valid_url
      expect(subject.valid?).to be true
      expect(subject.errors.full_messages).to eq([])
    end
  end

  ['ftp://ftp.google.com','ssh://google.com'].each do |invalid_url|
    it "#{invalid_url.inspect} is an invalid url" do
      subject.url = invalid_url
      subject.valid?
      expect(subject.errors).to include(:url)
      expect(subject.errors[:url]).to include("must begin with http or https")
    end
  end
end