# Required Gems
require 'faker'
require 'open-uri'
require 'json'
require 'uri'
require 'net/http'

# Clear previous records
puts "delete all messages"
Message.destroy_all

puts 'Destroying all previous records'
Participation.destroy_all
puts 'All participations are destroyed'

# Destroy associated chatroom_users before deleting chatrooms
ChatroomUser.destroy_all
puts 'All chatroom_users are destroyed'

# Destroy chatrooms
Chatroom.destroy_all
puts 'All chatrooms are destroyed'

# Destroy classrooms
Classroom.destroy_all
puts 'All classrooms are destroyed'

User.destroy_all
puts 'All users are destroyed'

Lesson.destroy_all
puts 'All lessons are destroyed'

Question.destroy_all
puts 'All questions are destroyed'

Choice.destroy_all
puts 'All choices are destroyed'


# Seed Teacher
puts 'Creating teacher...'
teacher = User.create!(
  first_name: 'Rashad',
  last_name: 'DuPaty',
  learning_style: 'kinesthetic',
  email: 'abc@abc.com',
  password: 'password',
  teacher: true
)
file0 = File.open(Rails.root.join('app/assets/images/profile.png'))
teacher.photo.attach(io: file0, filename: 'teacher.png', content_type: 'image/png')
teacher.save
puts "Mr. #{teacher.last_name} has been created!"

# Seed Classroom
puts 'Creating classroom...'
classroom = Classroom.create!(
  user: teacher,
  name: "Class 2 - B",
  title: "Oral Communication",
)
puts "Mr. DuPaty's classroom has been created!"

# Seed Students
boy_avatars = %w[app/assets/images/students/boy1.jpg app/assets/images/students/boy2.jpg app/assets/images/students/boy3.jpg app/assets/images/students/boy4.jpg app/assets/images/students/boy5.jpg app/assets/images/students/boy6.jpg app/assets/images/students/boy7.jpg app/assets/images/students/boy8.jpg app/assets/images/students/boy9.jpg app/assets/images/students/boy10.jpg]

boy_first_names = %w[Shinji Rayji Toru Yosuke Koji Akira Shunsuke Taiga Kai Sora]

girl_avatars = %w[app/assets/images/students/girl1.jpg app/assets/images/students/girl2.jpg app/assets/images/students/girl3.jpg app/assets/images/students/girl4.jpg app/assets/images/students/girl5.jpg app/assets/images/students/girl6.jpg app/assets/images/students/girl7.jpg app/assets/images/students/girl8.jpg app/assets/images/students/girl9.jpg app/assets/images/students/girl10.jpg]

girl_first_names = %w[Reona Mari Aika Hikari Sakura Kaede Natsume Rin Fuuka Yukari]

last_names = %w[Watanabe Fujita Nakamura Ohtani Izumi Nakamura Mori Tanaka Suzuki Honda]


puts 'Creating 10 boy students...'

boy_avatars.each do |path|
  student = User.create!(
    first_name: boy_first_names.shift,
    last_name: last_names.sample,
    learning_style: %w[visual aural reading kinesthetic].sample,
    email: Faker::Internet.email,
    password: 'password',
    teacher: false,
    score: {
      'Present Tense' => rand(0..5),
      'Past Tense' => rand(0..5),
      'Conditionals' => rand(0..5),
      'Present Perfect' => rand(0..5)
    }
  )
  file = File.open(Rails.root.join(path))
  student.photo.attach(io: file, filename: 'user.jpg', content_type: 'image/jpg')
  student.save

  Participation.create!(
    user: student,
    classroom: classroom
  )
  puts "User #{student.first_name} has been created..."
end

puts 'Creating 10 girl students...'

girl_avatars.each do |path|
  student = User.create!(
    first_name: girl_first_names.shift,
    last_name: last_names.sample,
    learning_style: %w[visual aural reading kinesthetic].sample,
    email: Faker::Internet.email,
    password: 'password',
    teacher: false,
    score: {
      'Present Tense' => rand(0..5),
      'Past Tense' => rand(0..5),
      'Conditionals' => rand(0..5),
      'Present Perfect' => rand(0..5)
    }
  )
  file = File.open(Rails.root.join(path))
  student.photo.attach(io: file, filename: 'user.jpg', content_type: 'image/jpg')
  student.save

  Participation.create!(
    user: student,
    classroom: classroom
  )
  puts "User #{student.first_name} has been created..."
end

puts 'Creating Osama...'
osama = User.create!(
  first_name: 'Osama',
  last_name: 'Suleiman',
  learning_style: 'reading',
  email: 'student@abc.com',
  password: 'password1',
  teacher: false,
  score: {
    'Present Tense' => 4,
    'Past Tense' => 3,
    'Conditionals' => 2,
    'Present Perfect' => 0
  }
)
file = File.open(Rails.root.join('app/assets/images/students/Osama.jpg'))
osama.photo.attach(io: file, filename: 'user.jpg', content_type: 'image/jpg')
osama.save

Participation.create!(
  user: osama,
  classroom: classroom
)
puts "User #{osama.first_name} has been created..."

puts 'All students have been created!'

Chatroom.create!(
  classroom: classroom
)
lesson_content = <<-MARKDOWN
# Present Perfect Tense supplementary

---

## What they are

The present perfect tense is an English verb tense used for past actions that are related to or continue into the present. It’s easily recognized by the auxiliary verbs (or helper verbs) have and has, as in, “I have gone fishing since I was a child.”

---

## Let's dive in

The present perfect tense is one of the common verb tenses in English, used to show an action that happened in the past that is directly related to the present, such as actions that are still continuing or that indicate a change over time.

---

In the present perfect tense, the main verbs always use the auxiliary verbs (helper verbs) has or have. The main verb takes a participle form, specifically the past participle. The past participle is often the same form as the simple past form of the verb, unless it’s an irregular verb, which each have their own unique past participle form. We explain in more detail how to form them in our guide to participles.

---

Only the auxiliary verbs are conjugated to fit the subject-verb agreement in the present perfect tense; the past participle of the main verb remains the same no matter what the subject is. Generally, you use have for all subjects except the singular third-person, which instead uses has.
MARKDOWN

# Seed Lesson
puts 'Creating a lesson...'
lesson = Lesson.create!(
  classroom: classroom,
  title: 'Present Perfect',
  content: lesson_content,
  date: '2024-03-01'
)
puts "The #{lesson.title} seed lesson has been created!"

# Seed Styled Lesson


# Seed Styled Lesson [Visual]
puts 'Creating visual lesson...'
visual_lesson = StyledLesson.create!(
  lesson: lesson,
  style: 'visual',
  content: ''
)

# Attaching the 8 lesson images to the visual_lesson
file1 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_1.jpg'))
visual_lesson.files.attach(io: file1, filename: 'visual_1.jpg')

file2 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_2.jpg'))
visual_lesson.files.attach(io: file2, filename: 'visual_2.jpg')

file3 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_3.jpg'))
visual_lesson.files.attach(io: file3, filename: 'visual_3.jpg')

file4 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_4.jpg'))
visual_lesson.files.attach(io: file4, filename: 'visual_4.jpg')

file5 = File.open(Rails.root.join('db/files/visual_lesson/lessonimg_5.jpg'))
visual_lesson.files.attach(io: file5, filename: 'visual_5.jpg')
visual_lesson.save

puts 'Visual lesson has been created!'

puts 'Creating aural lesson...'
aural_lesson = StyledLesson.create!(
  lesson: lesson,
  style: 'aural',
  content: ''
)

# Attaching audio file to aural_lesson
file9 = File.open(Rails.root.join('db/files/aural_lesson.mp3'))
aural_lesson.files.attach(io: file9, filename: 'aural.mp3')
aural_lesson.save

puts 'Aural lesson has been created!'

# Seed Styled Lesson [Reading]
puts 'Creating reading lesson...'
reading_lesson = StyledLesson.create!(
  lesson: lesson,
  style: 'reading',
  content: ''
)

# Attaching an open file to reading_lesson
file10 = File.open(Rails.root.join('db/files/reading_lesson.pdf'))
reading_lesson.files.attach(io: file10, filename: 'reading.pdf')
reading_lesson.save

puts 'Reading lesson has been created!'

# Seed Styled Lesson [Kinesthetic]
puts 'Creating kinesthetic lesson...'
kinesthetic_lesson = StyledLesson.create!(
  lesson: lesson,
  style: 'kinesthetic',
  content: ''
)

# Attaching a video file to kinesthetic_lesson
file11 = File.open(Rails.root.join('db/files/kinesthetic_lesson.mp4'))
kinesthetic_lesson.files.attach(io: file11, filename: 'kinesthetic.mp4')
kinesthetic_lesson.save

puts 'Kinesthetic lesson has been created!'

# 1st Seed Question
puts 'Creating lesson quiz questions...'
question1 = Question.create!(
  lesson: lesson,
  description: 'What does the CEFR exam evaluate?' # Will need to change this data type
)
puts "The #{lesson.title} homework questions have been created!"

# 1st Seed Choices
puts 'Creating lesson quiz choices...'
Choice.create!(
  question: question1,
  description: 'It is good for your reading practice.', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question1,
  description: 'It is valuable in Japanese universities.', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question1,
  description: 'It evaluates your conversation skill.', # Will need to change this data type
  correct: true
)
Choice.create!(
  question: question1,
  description: 'It can help you with your listening.', # Will need to change this data type
  correct: false
)

# 2nd Seed Question
question2 = Question.create!(
  lesson: lesson,
  description: 'Who\'s the GOAT of the NBA?' # Will need to change this data type
)

# 2nd Seed Choices
puts 'Creating lesson quiz choices...'
Choice.create!(
  question: question2,
  description: 'Kobe Bryant', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question2,
  description: 'Michael Jordan', # Will need to change this data type
  correct: true
)
Choice.create!(
  question: question2,
  description: 'Lebron James', # Will need to change this data type
  correct: false
)
Choice.create!(
  question: question2,
  description: 'Wilt Chamberlain', # Will need to change this data type
  correct: false
)
puts 'All choices are done!'
