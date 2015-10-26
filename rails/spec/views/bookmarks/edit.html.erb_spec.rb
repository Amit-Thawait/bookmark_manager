require 'rails_helper'

RSpec.describe "bookmarks/edit", type: :view do
  before(:each) do
    skip
    @bookmark = assign(:bookmark, Bookmark.create!(
      :name => "MyString",
      :url => "MyString",
      :tags => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit bookmark form" do
    render

    assert_select "form[action=?][method=?]", bookmark_path(@bookmark), "post" do

      assert_select "input#bookmark_name[name=?]", "bookmark[name]"

      assert_select "input#bookmark_url[name=?]", "bookmark[url]"

      assert_select "input#bookmark_tags[name=?]", "bookmark[tags]"

      assert_select "input#bookmark_description[name=?]", "bookmark[description]"
    end
  end
end
