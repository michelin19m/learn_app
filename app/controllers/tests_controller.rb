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
    csv_content = params[:csv_content]

    service = CsvImportService.new(csv_content, @part, current_user)
    result = service.call

    if result[:success]
      redirect_to resource_path(@part.resource), notice: 'Quiz was successfully created from the pasted CSV content.'
    else
      redirect_to new_part_test_path(@part), alert: result[:message]
    end
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
