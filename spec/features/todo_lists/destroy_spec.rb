require 'spec_helper'

describe "Destroy todo lists" do 
  let(:user){create(:user)}
	let!(:todo_list){user.todo_lists.create(title: "Groceries", description: "Grocery list.")}

  before do
    sign_in user, password: "tester1"
  end

	it "removes todo list item when the correct button is pressed" do
		expect(user.todo_lists.count).to eq(1)
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Destroy"
		end
		expect(user.todo_lists.count).to eq(0)
	end

end