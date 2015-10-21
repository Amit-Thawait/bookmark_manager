require 'rails_helper'

RSpec.describe "bookmarks/new", type: :view do
  before(:each) do
    assign(:bookmark, Bookmark.new(
      :name => "MyString",
      :url => "MyString",
      :tags => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new bookmark form" do
    render

    assert_select "form[action=?][method=?]", bookmarks_path, "post" do

      assert_select "input#bookmark_name[name=?]", "bookmark[name]"

      assert_select "input#bookmark_url[name=?]", "bookmark[url]"

      assert_select "input#bookmark_tags[name=?]", "bookmark[tags]"

      assert_select "input#bookmark_description[name=?]", "bookmark[description]"
    end
  end
end
