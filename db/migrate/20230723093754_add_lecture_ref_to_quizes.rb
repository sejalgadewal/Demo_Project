class AddLectureRefToQuizes < ActiveRecord::Migration[7.0]
  def change
    add_reference :quizzes, :lecture, foreign_key: true
  end
end
