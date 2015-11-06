require 'spec_helper'
require_relative 'helper'

describe "Creating todo lists" do 

	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is what I'm doing today"

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end

	before do
		sign_in create(:user), password: "tester1"
	end

	it "redirects to the todo list index page on success" do
		
		create_todo_list 

		expect(page).to have_content("My todo list")
	end

	it "displays an error when the todo list title is empty" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today")
	end

	it "displays an error when the todo list title is too short" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "Hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today")
	end

	it "displays an error when the todo list description is empty" do
		expect(TodoList.count).to eq(0)

		create_todo_list description: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today")
	end

	it "displays an error when the todo list description is too short" do
		expect(TodoList.count).to eq(0)

		create_todo_list description: "desc"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today")
	end

end