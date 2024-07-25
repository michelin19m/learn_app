require 'csv'

class TestsController < ApplicationController
  before_action :set_part, only: [:index, :show, :new, :create]

  def index
    @tests = @part.tests
  end

  def show
    @test = @part.tests.find(params[:id])
  end

  def new
    @test = @part.tests.build
  end

  def create
    title = params[:title]
    csv_content = params[:csv_content]

    if csv_content.blank?
      redirect_to new_part_test_path(@part), alert: 'Please paste valid CSV content.'
      return
    end

    questions_and_answers = []
    CSV.parse(csv_content, headers: true) do |row|
      questions_and_answers << { question: row['question'], answer: row['answer'] }
    end

    if questions_and_answers.empty?
      redirect_to new_part_test_path(@part), alert: 'The CSV content is empty or improperly formatted.'
      return
    end

    # Create a new test
    test = @part.tests.create(title: title, user: current_user)

    # Add questions to the test
    questions_and_answers.each do |qa|
      test.questions.create(content: qa[:question], correct_answer: qa[:answer])
    end

    redirect_to resource_path(@part.resource), notice: 'Quiz was successfully created from the pasted CSV content.'
  end

  def destroy
    @test = Test.find(params[:id])
    @test.destroy
    redirect_to request.referrer, notice: 'Skill was successfully destroyed.'
  end

  def take_quiz
    @test = Test.find(params[:id])
  end

  def submit_quiz
    @test = Test.find(params[:id])
    user_answers = params[:answers]
  
    @results = @test.questions.map do |question|
      user_answer = user_answers[question.id.to_s].strip.downcase
      correct_answer = question.correct_answer.strip.downcase
      {
        question: question.content,
        user_answer: user_answer,
        correct_answer: correct_answer,
        correct: user_answer == correct_answer
      }
    end
  
    # Store the attempt
    current_user.attempts.create(test: @test, answers: user_answers)
  
    redirect_to quiz_results_test_path(@test, results: @results)
  end

  def quiz_results
    @test = Test.find(params[:id])
    @results = params[:results] || []
  end

  private

  def set_part
    @part = Part.find(params[:part_id])
  end
end
