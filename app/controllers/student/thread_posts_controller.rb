class Student::ThreadPostsController < ApplicationController
  layout 'student_portal'
  before_action :authenticate_student!
  before_action :student_subjects, :subjects

  def create
    post = ThreadPost.new(post_params)
    post.student_id = current_student.id
    post.topic_thread_id = params[:thread_id]
    if post.save
      flash[:success] = 'Post successfully added'
      redirect_to student_subject_section_discussion_topic_thread_path(params[:section_id], params[:discussion_id], params[:topic_id], params[:thread_id])
    else
      flash[:error] = 'There was a problem adding your post. Please try again later'
      redirect_to student_subject_section_discussion_topic_thread_path(params[:section_id], params[:discussion_id], params[:topic_id], params[:thread_id])
    end
  end

  def destroy
    post = ThreadPost.find(params[:id])
    if post.destroy
      flash[:success] = 'Post successfully deleted'
      redirect_to student_subject_section_discussion_topic_thread_path(params[:section_id], params[:discussion_id], params[:topic_id], params[:thread_id])
    else
      flash[:error] = 'There was a problem deleting your post. Please try again later'
      redirect_to student_subject_section_discussion_topic_thread_path(params[:section_id], params[:discussion_id], params[:topic_id], params[:thread_id])
    end
  end

  def edit
    @post = ThreadPost.find(params[:id])
  end

  def update
    post = ThreadPost.find(params[:id])
    if post.update_attributes(post_params)
      flash[:success] = 'Post successfully edited'
      redirect_to student_subject_section_discussion_topic_thread_path(params[:section_id], params[:discussion_id], params[:topic_id], params[:thread_id])
    else
      flash[:error] = 'There was a problem editing your post. Please try again later'
      redirect_to student_subject_section_discussion_topic_thread_path(params[:section_id], params[:discussion_id], params[:topic_id], params[:thread_id])
    end
  end

  private
  def post_params
    params.require(:thread_post).permit(:content)
  end
end
