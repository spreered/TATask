namespace :dev do
  task rebuild: ["db:drop", "db:setup", "db:seed",:fake]
  task fake: [:fake_user, :fake_tasks]
  task fake_user: :environment do
    20.times do |i|
      user = User.create(
        name: FFaker::Name::first_name,
        email: "user_#{i}@example.com",
        password: "123456"
      )
      puts "create user #{user.name} , #{user.email}"
    end
  end
  task fake_tasks: :environment do
    200.times do |i|
      rand_date = rand(1..3)
      task = Task.create(
        title: FFaker::Book::title,
        content: FFaker::Lorem::sentence(30),
        deadline: rand_date.week.from_now,
        priority: rand(0..2),
        state: rand(0..2),
        user: User.all.sample,
        tags: Tag.all.sample(3)
      )
      puts "create task #{task.title}"
    end 
  end
  task fake_tasks_user: :environment do
    Task.all.each do |task|
      task.user = User.all.sample
      task.save
    end
  end
end