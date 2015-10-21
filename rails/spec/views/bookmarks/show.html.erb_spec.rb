require 'rails_helper'

RSpec.describe "bookmarks/show", type: :view do
  before(:each) do
    @bookmark = assign(:bookmark, Bookmark.create!(
      :name => "Name",
      :url => "Url",
      :tags => "Tags",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Tags/)
    expect(rendered).to match(/Description/)
  end
end
