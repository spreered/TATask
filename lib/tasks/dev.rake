namespace :dev do
  task fake_tasks: :environment do
    100.times do |i|
      rand_date = rand(1..3)
      task = Task.create(
        title: FFaker::Name::first_name,
        content: FFaker::Lorem::sentence(30),
        deadline: rand_date.week.from_now,
        priority: rand(0..2),
        state: rand(0..2)
      )
      puts "create task #{task.title}"
    end 
  end
end