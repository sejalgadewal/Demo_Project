module EnrollmentsHelper
    def enrolled?(student_id)
        Enrollment.exists?(user_id: student_id)
    end
end
