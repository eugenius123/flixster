class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson
  def show

  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_lesson
    if current_user.enrolled_in?(current_lesson.section.course) != true
      redirect_to course_path(current_lesson.section.course), alert: 'You don\'t have access to the course'
    end
  end
end
