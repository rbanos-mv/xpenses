# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def setpwd(user)
  user.password = 'valido'
  user.password_confirmation = 'valido'
  user.save
  user
end

users = [
  setpwd(User.new(name: 'Roberto', email: 'roberto@mail.com')),
  setpwd(User.new(name: 'Elisa', email: 'elisa@mail.com'))
]

def create_groups(user)
  icons = Group.icon_list
  group_ids = []
  (0..9).each do |i|
    id = ((2 - (user.id % 2)) * 10) + i
    group = Group.create(user:, name: "Category #{id}", icon: icons[i])
    group_ids << group.id unless i < 3
  end
  group_ids
end

def create_expenses(user, group_ids)
  (0..5).each do |i|
    id = ((2 - (user.id % 2)) * 10) + i
    expense = Expense.create(user:, name: "Expense #{id}", amount: rand(1000..100_000) / 100)
    combine(expense, group_ids)
  end
end

def combine(expense, group_ids)
  used = []
  (0..5).each do
    group_id = 0
    loop do
      index = rand(0..group_ids.length)
      next if used.include?(index)

      group_id = group_ids[index]
      used << index
      break
    end
    Record.create(group_id:, expense:)
    print '#'
  end
end

users.each do |user|
  group_ids = create_groups(user)
  create_expenses(user, group_ids)
end
