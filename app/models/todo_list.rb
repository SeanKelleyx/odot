class TodoList < ActiveRecord::Base
	has_many :todo_item

	validates :title, presence: true
	validates :title, length: {minimum: 3}
	validates :description, presence: true
	validates :description, length: {minimum: 5}

  def has_completed_items?
    todo_item.complete.size > 0
  end

  def has_incomplete_items?
    todo_item.complete.size < todo_item.size
  end
end
