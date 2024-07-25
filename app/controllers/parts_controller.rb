class PartsController < ApplicationController
  before_action :set_resource, only: %i[new create]
  before_action :set_part, only: [:show, :edit, :update, :destroy, :create_quiz]

  def new
    @part = @resource.parts.build
  end

  def create
    @part = @resource.parts.build(part_params)
    if @part.save
      redirect_to @resource, notice: 'Part was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @part.update(part_params)
      redirect_to @part.resource, notice: 'Part was successfully updated.'
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @part.destroy
    redirect_to @part.resource, notice: 'Part was successfully destroyed.'
  end

  def create_quiz
    client = OpenAI::Client.new
    prompt = <<~PROMPT
      You are an assistant helping to create quiz questions and answers based on educational content.
      The skill being studied is "#{@part.resource.skill.name}".
      The resource is "#{@part.resource.name}".
      The specific part of the resource is "#{@part.name}".
      Please generate at least 5 questions and answers based on the content of this specific part.
    PROMPT

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are an assistant that generates quiz questions and answers based on provided content." },
          { role: "user", content: prompt }
        ],
        max_tokens: 500
      }
    )

    # Parse the response to extract questions and answers
    questions_and_answers = parse_quiz(response.choices.first.text)

    # Create a test and store it in the database
    test = @part.tests.create(title: "Quiz for #{@part.name}")

    # Create questions and store them in the database
    questions_and_answers.each do |qa|
      test.questions.create(content: qa[:question], correct_answer: qa[:answer])
    end

    redirect_to @part, notice: 'Quiz was successfully created.'
  end

  private

  def parse_quiz(response_text)
    # Parse the response text from OpenAI to extract questions and answers
    # This method will need to be customized based on the format of the response
    # For simplicity, assume the response is in the format: "Q1: ... A1: ... Q2: ... A2: ..."
    questions_and_answers = []
    response_text.scan(/Q\d+:(.*?)A\d+:(.*?)(?=Q\d+:|$)/m) do |question, answer|
      questions_and_answers << { question: question.strip, answer: answer.strip }
    end
    questions_and_answers
  end

  def set_resource
    @resource = Resource.find(params[:resource_id])
  end

  def set_part
    @part = Part.find(params[:id])
  end

  def part_params
    params.require(:part).permit(:name)
  end
end
