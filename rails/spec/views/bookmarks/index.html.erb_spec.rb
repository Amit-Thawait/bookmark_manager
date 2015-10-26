require 'rails_helper'

RSpec.describe "bookmarks/index", type: :view do
  before(:each) do
    skip
    assign(:bookmarks, [
      Bookmark.create!(
        :name => "Name",
        :url => "Url",
        :tags => "Tags",
        :description => "Description"
      ),
      Bookmark.create!(
        :name => "Name",
        :url => "Url",
        :tags => "Tags",
        :description => "Description"
      )
    ])
  end

  it "renders a list of bookmarks" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
