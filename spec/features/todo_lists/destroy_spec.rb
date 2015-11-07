require 'spec_helper'

describe "Destroy todo lists" do 
	let(:todo_list){create(:todo_list)}

  before do
    sign_in todo_list.user, password: "tester1"
  end

	it "removes todo list item when the correct button is pressed" do
		expect(todo_list.user.todo_lists.count).to eq(1)
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Destroy"
		end
		expect(todo_list.user.todo_lists.count).to eq(0)
	end

end