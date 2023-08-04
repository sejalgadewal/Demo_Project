require 'rails_helper'

RSpec.describe "Courses", type: :request do
  let(:instructor) { create(:user, role: 'Instructor') }
  let(:student) { create(:user, role: 'Student') }
  let(:course) { create(:course, user: instructor) }

  describe "GET /courses" do
    it "displays the courses index page" do
      get courses_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(course.title)
    end
  end

  describe "GET /courses/:id" do
    it "displays the course details page" do
      get course_path(course)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(course.title)
    end
  end

  describe "GET /courses/mycourse" do
    context "when user is authenticated" do
      before { sign_in instructor }

      it "displays the user's course page" do
        my_course = create(:course, user: instructor)
        my_lecture = create(:lecture, course: my_course, user: instructor)
        get mycourse_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include(my_course.title)
      end
    end

    context "when user is not authenticated" do
      it "redirects to sign-in page" do
        get mycourse_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST /courses" do
    context "when user is authenticated as instructor" do
      before { sign_in instructor }

      it "creates a new course and sends lecture emails" do
        students = create_list(:user, 3, role: 'Student')
        expect(CourseMailer).to receive(:send_lecture_email).exactly(3).times
        post courses_path, params: { course: attributes_for(:course) }
        expect(response).to redirect_to(courses_mycourse_path)
      end
    end

    context "when user is not authenticated" do
      it "redirects to sign-in page" do
        post courses_path, params: { course: attributes_for(:course) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


end
